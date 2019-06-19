import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swolemate/models/objects/exercise.dart';
import 'package:swolemate/models/objects/group.dart';
import 'package:swolemate/models/objects/set.dart';

/* This class is the main mediator between the database and the app itself -
everything will call the app through this database. The database is loaded
off a SQLite .db file. The database comes pre-dumped with standardized info
such as basic exercises and possibly basic workouts. Essentially, it builds
the schema. Later on, the user can edit the database through queries
but the DB is already built. */

class DBHelper {
  // The name of the database file that is called upon:
  static String databaseName = "swolematedb.db";
  // The folder that the database exists in (should be assets)
  static String databaseLoc = "assets";
  static Database _database; 

  static Future<Database> get database async {
    if (_database != null){
      return _database;
    }
    _database = await initializeDB();
    return _database;
  }

  static initializeDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join(databaseLoc, databaseName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String databasePath = join(appDocDir.path, databaseName);
      return await openDatabase(databasePath);
  }
  
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<void> insertExercise(Exercise exercise) async {
    Database db = await database;
    
    await db.insert(
      'exercises',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertGroup(ExerciseGroup group) async {
    Database db = await database;
    
    await db.insert(
      'groups',
      group.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertSet (ExerciseSet set) async {
    Database db = await database;
    
    await db.insert(
      'sets',
      set.toMap(),
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
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(
      'exercise as e join exInGroup as g where e.id = g.exerciseId and g.groupName = "Back";');

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

  static Future<List<ExerciseGroup>> getGroups() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('exGroup');

    // Convert the List<Map<String, dynamic> into a List<Group>.
    return List.generate(maps.length, (i) {
      return ExerciseGroup(
        name: maps[i]['name'],
        desc: maps[i]['desc'],
      );
    });
  }
}