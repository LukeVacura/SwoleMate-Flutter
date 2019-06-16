import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swolemate/models/objects/exercise.dart';
import 'package:swolemate/models/objects/group.dart';
import 'package:swolemate/models/objects/set.dart';

import 'databasedumps.dart';

class DBHelper {
  
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final exercise = 'Exercise';
  static final group = 'Group';
  static final belongsIn = 'ExerciseBelongsIn';
  
  static final exerciseId = 'exerciseId';
  static final exerciseName = 'name';
  static final exerciseType = 'type';
  static final exercisePref = 'pref';
  static final exerciseSuf = 'suf';
  static final exerciseDesc = 'desc';

  static final groupId = 'groupId';
  static final groupName = 'name';

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
      DBDump.getCreateGroupTable() + 
      DBDump.getCreateGroupContainsExerciseTable() +
      DBDump.getPopulateGroups() +
      DBDump.testGroupChest() + 
      DBDump.testPopulateChest() +
      ''
    );
  }
  
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertExercise(Exercise exercise) async {
    Database db = await instance.database;
    
    await db.insert(
      'exercises',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertGroup(ExerciseGroup group) async {
    Database db = await instance.database;
    
    await db.insert(
      'groups',
      group.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertSet (ExerciseSet set) async {
    Database db = await instance.database;
    
    await db.insert(
      'sets',
      set.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void insertIntoBelongsIn(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(belongsIn, row);
  }

  // All of the rows are returned as a list of maps, where each map is 
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $exercise');
  }

  getAllExercises() async {
    final db = await database;
    var res = await db.query("Exercise");
    List<Exercise> list =
        res.isNotEmpty ? res.map((c) => Exercise.fromMap(c)).toList() : [];
    //.then((){
      return list;
    //});
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $exercise'));
  }

  // We are assuming here that the id column in the map is set. The other 
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[exerciseId];
    return await db.update(exercise, row, where: '$exerciseId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is 
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(exercise, where: '$exerciseId = ?', whereArgs: [id]);
  }
}