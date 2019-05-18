import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  
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
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

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
    await db.execute('''
          CREATE TABLE $exercise (
            $exerciseId INTEGER PRIMARY KEY,
            $exerciseName TEXT NOT NULL,
            $exerciseType INTEGER NOT NULL,
            $exercisePref INTEGER NOT NULL,
            $exerciseSuf INTEGER NOT NULL,
            $exerciseDesc TEXT
          );
          CREATE TABLE $group (
            $groupId INTEGER PRIMARY KEY,
            $groupName TEXT NOT NULL
          );
          CREATE TABLE $belongsIn (
            $groupId INTEGER PRIMARY KEY,
            $exerciseId INTEGER PRIMARY KEY,
            FOREIGN KEY ($exerciseId) REFERENCES $exercise($exerciseId),
            FOREIGN KEY ($groupId) REFERENCES $group($groupId)
          );
          '''
          
          );
  }
  
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertIntoExercise(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(exercise, row);
  }

  Future<int> insertIntoGroup(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(group, row);
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