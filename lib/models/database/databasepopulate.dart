import 'databasehelper.dart';

class DatabasePopulate{
  static final dbHelper = DatabaseHelper.instance;

  static void insert() async {
      // row to insert
      Map<String, dynamic> row = {
        DatabaseHelper.exerciseName : 'Barbell bench press',
        DatabaseHelper.exerciseType  : 1,
        DatabaseHelper.exercisePref  : 0,
        DatabaseHelper.exerciseSuf  : 0,
        DatabaseHelper.exerciseDesc  : '',
      };
      final id = await dbHelper.insertIntoExercise(row);
      print('inserted row id: $id');

      row.clear();
      row = {
        DatabaseHelper.groupName : 'Chest',
      };
      final id2 = await dbHelper.insertIntoGroup(row);
      print('inserted row id: $id2');

      row.clear();
      row = {
        DatabaseHelper.groupId : id2,
        DatabaseHelper.exerciseId : id,
      };
    }



}