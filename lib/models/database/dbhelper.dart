import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// Object files
import 'package:swolemate/models/objects/group.dart';
import '../objects/exercise.dart';


/* This class is the main mediator between the database and the app itself -
everything will call the app through this database. The database is loaded
off a SQLite .db file. The database comes pre-dumped with standardized info
such as basic exercises and possibly basic workouts. Essentially, it builds
the schema. Later on, the user can edit the database through queries
but the DB is already built. */

// DB - 7.1.2019 work - Initialize DB to read from pre-existing SQLite file

class DBHelper {
  // The name of the database that is called upon:
  static String databaseName = "swolematedba";
  // The database file
  static String databaseFile = databaseName + ".db";
  // The folder that the database exists in (should be assets)
  static String databaseLoc = "assets";

  // Database constructor & getters
  DBHelper._();
  static Database _database;
  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDb();
    return _database;
  }
  static final DBHelper instance = DBHelper._();

  // Initialize the database if not already existing
  initDb() async{
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, databaseFile);

      // Only copy if the database does not exist in the system
      if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
        // Load database from asset and copy
        // print("Database does not exist");
        ByteData data = await rootBundle.load(join('assets', databaseName));
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Save copied asset to documents
        await new File(path).writeAsBytes(bytes);
      }

      // Build DB path
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String databasePath = join(appDocDir.path, databaseFile);
      return await openDatabase(databasePath);
  }
  
  Future<void> insertExercise(Exercise exercise) async{
    final Database db = await database;

    await db.insert(
      'exercise',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> insertGroup(ExerciseGroup group) async{
    final Database db = await database;

    await db.insert(
      'exGroup',
      group.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> insertExIntoGroup(Exercise exercise, ExerciseGroup group) async{
    final Database db = await database;

    await db.insert(
      'exInGroup',
      {"exerciseId": exercise.id, "groupName": group.name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Exercise>> exercises() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(
      'exercise as e join exInGroup as g where e.id = g.exerciseId;');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Exercise(
        id: maps[i]['id'],
        name: maps[i]['name'],
        type: maps[i]['type'],
        pref: maps[i]['pref'],
        suf: maps[i]['suf'],
        desc: maps[i]['desc'],
      );
    });
  }

  // Returns all exercises that are a part of a body group
  Future<List<Exercise>> getBPExercises(String groupKey) async{
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query(
      'exercise as e join exInGroup as g where e.id = g.exerciseId and g.groupName = "$groupKey";');

      return List.generate(maps.length, (i) {
        return Exercise(
          id: maps[i]['id'],
          name: maps[i]['name'],
          type: maps[i]['type'],
          pref: maps[i]['pref'],
          suf: maps[i]['suf'],
          desc: maps[i]['desc'],
        );
    });
  }

  Future<List<ExerciseGroup>> getGroups() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('exGroup order by name asc;');

    // Convert the List<Map<String, dynamic> into a List<Group>.
    return List.generate(maps.length, (i) {
      return ExerciseGroup(
        name: maps[i]['name'],
        desc: maps[i]['desc'],
      );
    });
  }
}