import 'package:swolemate/models/objects/Exercise.dart';

import 'databasehelper.dart';

class DatabasePopulate{
  static final dbHelper = DBHelper.instance;

  static void insert() async {
      // row to insert
      Map<String, dynamic> row = {
        DBHelper.exerciseName : 'Barbell bench press',
        DBHelper.exerciseType  : 1,
        DBHelper.exercisePref  : 0,
        DBHelper.exerciseSuf  : 0,
        DBHelper.exerciseDesc  : '',
      };
      final id = await dbHelper.insertIntoExercise(row);
      print('inserted row id: $id');

      row.clear();
      row = {
        DBHelper.groupName : 'Chest',
      };
      final id2 = await dbHelper.insertIntoGroup(row);
      print('inserted row id: $id2');

      row.clear();
      row = {
        DBHelper.groupId : id2,
        DBHelper.exerciseId : id,
      };
    }



}

class ListHandler{
  static List<Exercise> getChestExercises(){
    List<Exercise> chestExercises = [
      new Exercise(id: 0001.toString(), name:"Barbell bench press", type:0, pref:0, suf:0),
      new Exercise(id: 0002.toString(), name:"Incline barbell bench press", type:0, pref:0, suf:0),
      new Exercise(id: 0003.toString(), name:"Decline barbell bench press", type:1, pref:0, suf:0),
      new Exercise(id: 0004.toString(), name:"Dumbbell barbell bench press", type:1, pref:0, suf:0),
      new Exercise(id: 0005.toString(), name:"Dumbbell incline press", type:1, pref:0, suf:0),
      new Exercise(id: 0006.toString(), name:"Dumbbell decline press", type:1, pref:0, suf:0),
      new Exercise(id: 0007.toString(), name:"Pushup", type:1, pref:0, suf:0),
      new Exercise(id: 0008.toString(), name:"Close-grip pushup", type:1, pref:0, suf:0),
      new Exercise(id: 0009.toString(), name:"Close-grip bench press", type:1, pref:0, suf:0),
      new Exercise(id: 0010.toString(), name:"Dumbbell fly", type:1, pref:0, suf:0),
      new Exercise(id: 0011.toString(), name:"Incline dumbbell fly", type:1, pref:0, suf:0),
      new Exercise(id: 0012.toString(), name:"Cable fly", type:1, pref:0, suf:0),
      new Exercise(id: 0013.toString(), name:"High cable fly", type:1, pref:0, suf:0),
      new Exercise(id: 0014.toString(), name:"Low cable fly", type:1, pref:0, suf:0),
      new Exercise(id: 0015.toString(), name:"Machine fly", type:1, pref:0, suf:0),
      new Exercise(id: 0016.toString(), name:"Dips", type:1, pref:0, suf:0),
      new Exercise(id: 0017.toString(), name:"Machine press", type:1, pref:0, suf:0),
  ];
    return chestExercises;
  }
  static List<Exercise> getBackExercises(){
    List<Exercise> backExercises = [
      new Exercise(id: 0100.toString(), name:"Pullup", type:0, pref:0, suf:0),
      new Exercise(id: 0101.toString(), name:"Chinup", type:0, pref:0, suf:0),
      new Exercise(id: 0102.toString(), name:"Overhand barbell row", type:0, pref:0, suf:0),
      new Exercise(id: 0103.toString(), name:"Underhand barbell row", type:0, pref:0, suf:0),
      new Exercise(id: 0104.toString(), name:"One-armed dumbbell row", type:1, pref:0, suf:0),
      new Exercise(id: 0105.toString(), name:"Dumbbell row", type:1, pref:0, suf:0),
      new Exercise(id: 0106.toString(), name:"Cable row", type:1, pref:0, suf:0),
      new Exercise(id: 0107.toString(), name:"Row machine", type:0, pref:0, suf:0),
      new Exercise(id: 0108.toString(), name:"Chest-supported row", type:0, pref:0, suf:0),
      new Exercise(id: 0109.toString(), name:"Pulldown", type:0, pref:0, suf:0),
      new Exercise(id: 0110.toString(), name:"T-bar row", type:0, pref:0, suf:0),
    ];
    return backExercises;
  }
  static List<Exercise> getShoulderExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 0200.toString(), name:"Barbell OHP", type:0, pref:0, suf:0),
      new Exercise(id: 0201.toString(), name:"Barbell push press", type:0, pref:0, suf:0),
      new Exercise(id: 0202.toString(), name:"Dumbbell OHP", type:1, pref:0, suf:0),
      new Exercise(id: 0203.toString(), name:"Dumbbell push press", type:1, pref:0, suf:0),
      new Exercise(id: 0204.toString(), name:"Seated dumbbell OHP", type:1, pref:0, suf:0),
      new Exercise(id: 0205.toString(), name:"Seated OHP", type:1, pref:0, suf:0),
      new Exercise(id: 0206.toString(), name:"Dumbbell lateral raises", type:1, pref:0, suf:0),
      new Exercise(id: 0207.toString(), name:"Cable lateral raises", type:0, pref:0, suf:0),
      new Exercise(id: 0208.toString(), name:"Chest-down dumbbell raises", type:0, pref:0, suf:0),
      new Exercise(id: 0209.toString(), name:"Facepulls", type:0, pref:0, suf:0),
      new Exercise(id: 0210.toString(), name:"Front raises", type:0, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getBicepsExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 0300.toString(), name:"Barbell curl", type:1, pref:0, suf:0),
      new Exercise(id: 0301.toString(), name:"EZ bar curl", type:1, pref:0, suf:0),
      new Exercise(id: 0302.toString(), name:"Dumbbell curl", type:1, pref:0, suf:0),
      new Exercise(id: 0303.toString(), name:"Alternating dumbbell curl", type:1, pref:0, suf:0),
      new Exercise(id: 0304.toString(), name:"Reverse-grip curl", type:1, pref:0, suf:0),
      new Exercise(id: 0305.toString(), name:"Cable curl", type:1, pref:0, suf:0),
      new Exercise(id: 0306.toString(), name:"Spider curl", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getTricepsExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 0400.toString(), name:"Barbell skullcrushers", type:1, pref:0, suf:0),
      new Exercise(id: 0401.toString(), name:"Dumbbell skullcrushers", type:1, pref:0, suf:0),
      new Exercise(id: 0402.toString(), name:"Incline DB skullcrushers", type:1, pref:0, suf:0),
      new Exercise(id: 0403.toString(), name:"Overhead skullcrushers", type:1, pref:0, suf:0),
      new Exercise(id: 0404.toString(), name:"Cable pushdown", type:1, pref:0, suf:0),
      new Exercise(id: 0405.toString(), name:"Cable skullcrushers", type:1, pref:0, suf:0),
      new Exercise(id: 0406.toString(), name:"Dumbbell kickbacks", type:1, pref:0, suf:0),
      new Exercise(id: 0407.toString(), name:"Cable kickbacks", type:0, pref:0, suf:0),
      new Exercise(id: 0408.toString(), name:"French press", type:0, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getTrapExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 0500.toString(), name:"Barbell shrugs", type:1, pref:0, suf:0),
      new Exercise(id: 0501.toString(), name:"Dumbbell shrugs", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getForearmExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 0600.toString(), name:"Farmer's walk", type:1, pref:0, suf:0),
      new Exercise(id: 0601.toString(), name:"Wrist curl", type:1, pref:0, suf:0),
      new Exercise(id: 0602.toString(), name:"Reverse wrist curl", type:1, pref:0, suf:0),
      new Exercise(id: 0603.toString(), name:"Grip crush", type:1, pref:0, suf:0),
      new Exercise(id: 0604.toString(), name:"Reverse-grip curl", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getAbExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 0700.toString(), name:"Cable crunches", type:0, pref:0, suf:0),
      new Exercise(id: 0701.toString(), name:"Plank", type:0, pref:0, suf:0),
      new Exercise(id: 0702.toString(), name:"Leg raises", type:1, pref:0, suf:0),
      new Exercise(id: 0703.toString(), name:"Russian twists", type:1, pref:0, suf:0),
      new Exercise(id: 0704.toString(), name:"Crunches", type:1, pref:0, suf:0),
      new Exercise(id: 0705.toString(), name:"Ab rollout", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getGluteExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 0800.toString(), name:"Barbell glute bridges", type:1, pref:0, suf:0),
      new Exercise(id: 0801.toString(), name:"Barbell hip thrusts", type:1, pref:0, suf:0),
      new Exercise(id: 0802.toString(), name:"Cable hip thrusts", type:1, pref:0, suf:0),
      new Exercise(id: 0803.toString(), name:"Glute machine", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getHamstringExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 1000.toString(), name:"DB stiff-leg deadlift", type:1, pref:0, suf:0),
      new Exercise(id: 1001.toString(), name:"Barbell stiff-leg deadlift", type:1, pref:0, suf:0),
      new Exercise(id: 1002.toString(), name:"Lying hamstring curl", type:1, pref:0, suf:0),
      new Exercise(id: 1003.toString(), name:"Seated hamstring curl", type:1, pref:0, suf:0),
      new Exercise(id: 1004.toString(), name:"Glute-ham raise", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getQuadExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 0900.toString(), name:"Low bar barbell squat", type:0, pref:0, suf:0),
      new Exercise(id: 0901.toString(), name:"High bar barbell squat", type:0, pref:0, suf:0),
      new Exercise(id: 0902.toString(), name:"Front squat", type:1, pref:0, suf:0),
      new Exercise(id: 0903.toString(), name:"Dumbbell lunges", type:1, pref:0, suf:0),
      new Exercise(id: 0904.toString(), name:"Barbell lunges", type:1, pref:0, suf:0),
      new Exercise(id: 0905.toString(), name:"Romanian split squats", type:1, pref:0, suf:0),
      new Exercise(id: 0906.toString(), name:"Leg extensions", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getCalfExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 1100.toString(), name:"Smith machine calf raises", type:1, pref:0, suf:0),
      new Exercise(id: 1101.toString(), name:"Leg press calf raises", type:1, pref:0, suf:0),
      new Exercise(id: 1102.toString(), name:"Donkey calf raise", type:1, pref:0, suf:0),
      new Exercise(id: 1103.toString(), name:"Machine calf raise", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getCardioExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 1200.toString(), name:"Treadmill run", type:1, pref:0, suf:0),
      new Exercise(id: 1201.toString(), name:"Stairmaster", type:1, pref:0, suf:0),
      new Exercise(id: 1202.toString(), name:"Row machine", type:1, pref:0, suf:0),
      new Exercise(id: 1203.toString(), name:"Stationary bike", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getFBExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 1300.toString(), name:"Clean and jerk", type:0, pref:0, suf:0),
      new Exercise(id: 1301.toString(), name:"Snatch", type:0, pref:0, suf:0),
      new Exercise(id: 1302.toString(), name:"Power clean", type:1, pref:0, suf:0),
      new Exercise(id: 1303.toString(), name:"High pull", type:1, pref:0, suf:0),
    ];
    return Exercises;
  }
  static List<Exercise> getOtherExercises(){
    List<Exercise> Exercises = [
      new Exercise(id: 2000.toString(), name:"Phone staring", type:0, pref:0, suf:0),
    ];
    return Exercises;
  }
}