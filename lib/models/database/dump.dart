import 'package:swolemate/models/objects/group.dart';

class DBDump{
  static String getCreateExerciseTable(){
    return "CREATE TABLE exercise (" + 
	  "id INTEGER PRIMARY KEY, " +
  	"name TEXT NOT NULL, " + 
	  "type INTEGER, " + 
	  "pref INTEGER, " +
	  "suf INTEGER, " + 
	  "desc TEXT );";
  }
  static String getCreateGroupTable(){
    return "CREATE TABLE exGroup (" +
	  "name TEXT PRIMARY KEY, " +
	  "desc TEXT );";
  }
  static String getCreateGroupContainsExerciseTable(){
    return "CREATE TABLE exInGroup (" + 
    "exerciseId TEXT PRIMARY KEY, " + 
    "groupName TEXT, " + 
    "FOREIGN KEY (exerciseId) REFERENCES exercise(id), " + 
    "FOREIGN KEY (groupName) REFERENCES exGroup(name) );";
  }

  // Temporary group dump - gotta be a better way to do this
  static List<ExerciseGroup> groups = [
    ExerciseGroup(name: 'Chest', desc: ''),
    ExerciseGroup(name: 'Back', desc: ''),
    ExerciseGroup(name: 'Shoulders', desc: ''),
    ExerciseGroup(name: 'Traps', desc: ''),
    ExerciseGroup(name: 'Biceps', desc: ''),
    ExerciseGroup(name: 'Triceps', desc: ''),
    ExerciseGroup(name: 'Core', desc: ''),
    ExerciseGroup(name: 'Glutes', desc: ''),
    ExerciseGroup(name: 'Quads', desc: ''),
    ExerciseGroup(name: 'Hamstrings', desc: ''),
    ExerciseGroup(name: 'Calves', desc: ''),
    ExerciseGroup(name: 'Cardio', desc: ''),
    ExerciseGroup(name: 'Full body', desc: ''),
    ExerciseGroup(name: 'Other', desc: ''),
  ];
  static List<ExerciseGroup> getPopulateGroups(){
    return groups;
  }
}