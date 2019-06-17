import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swolemate/models/objects/exercise.dart';
import 'package:swolemate/models/objects/group.dart';
import 'package:swolemate/models/objects/set.dart';

import 'dump.dart';

class DBHelper {
  static final _databaseName = "SwoleMateDB5.db";
  static final _databaseVersion = 1;

  // make this a singleton class
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  static Future<void> deleteDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    databaseFactory.deleteDatabase(path);
    print("Successful deletion");
  }

  // SQL code to create the database exercise
  Future _onCreate(Database db, int version) async {
    await db.execute('' + 
      DBDump.getCreateExerciseTable() + 
      ''
    );
    await db.execute('' + DBDump.getCreateGroupTable() + '');
    await db.execute('' + DBDump.getCreateGroupContainsExerciseTable() + '');

    for(int i=0; i<DBDump.getPopulateGroups().length; i++){
      await insertGroup(DBDump.getPopulateGroups().elementAt(i));
    }
  }
  
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<void> insertExercise(Exercise exercise) async {
    Database db = await instance.database;
    
    await db.insert(
      'exercises',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertGroup(ExerciseGroup group) async {
    Database db = await instance.database;
    
    await db.insert(
      'groups',
      group.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertSet (ExerciseSet set) async {
    Database db = await instance.database;
    
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

  Future<List<ExerciseGroup>> getGroups() async {
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