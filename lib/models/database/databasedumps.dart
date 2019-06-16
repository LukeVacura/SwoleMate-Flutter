class DBDump{
  static String getCreateExerciseTable(){
    return "CREATE TABLE Exercise (" + 
	  "exerciseId INTEGER PRIMARY KEY, " +
  	"exerciseName TEXT NOT NULL, " + 
	  "exerciseType INTEGER, " + 
	  "exercisePref INTEGER, " +
	  "exerciseSuf INTEGER, " + 
	  "exerciseDesc TEXT )";
  }
  static String getCreateGroupTable(){
    return "CREATE TABLE Group (" +
	  "groupName TEXT PRIMARY KEY, " +
	  "groupDesc TEXT )";
  }
  static String getCreateGroupContainsExerciseTable(){
    return "CREATE TABLE GroupContainsExercise (" + 
    "exerciseId INTEGER PRIMARY KEY, " + 
    "groupId INTEGER PRIMARY KEY, " + 
    "FOREIGN KEY (exerciseId) REFERENCES Exercise (exerciseId), " + 
    "FOREIGN KEY (groupName) REFERENCES Group(groupName) )";
  }
  static String getPopulateGroups(){
    return 'INSERT INTO Group(groupName, groupDesc) VALUES ("Chest", "")' + 
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Back", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Shoulders", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Biceps", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Triceps", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Forearms", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Traps", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Core", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Glutes", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Quads", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Hamstrings", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Calves", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Cardio", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Full body", "")' +
    'INSERT INTO Group(groupName, groupDesc) VALUES ("Other", "")';
  }

  static String testPopulateChest(){
    return 'INSERT INTO Exercise(exerciseId, exerciseName, exerciseType, exercisePref, exerciseSuf, exerciseDesc) VALUES (0001, "Barbell bench press", 1, 0, 0, "")' +
    'INSERT INTO Exercise(exerciseId, exerciseName, exerciseType, exercisePref, exerciseSuf, exerciseDesc) VALUES (0002, "Barbell incline press", 1, 0, 0, "")' + 
    'INSERT INTO Exercise(exerciseId, exerciseName, exerciseType, exercisePref, exerciseSuf, exerciseDesc) VALUES (0003, "Barbell decline press", 0, 0, 0, "")' + 
    'INSERT INTO Exercise(exerciseId, exerciseName, exerciseType, exercisePref, exerciseSuf, exerciseDesc) VALUES (0004, "Dumbbell bench press", 1, 0, 0, "")' +
    'INSERT INTO Exercise(exerciseId, exerciseName, exerciseType, exercisePref, exerciseSuf, exerciseDesc) VALUES (0005, "Dumbbell incline press", 1, 0, 0, "")' +
    'INSERT INTO Exercise(exerciseId, exerciseName, exerciseType, exercisePref, exerciseSuf, exerciseDesc) VALUES (0006, "Dumbbell decline press", 1, 0, 0, "")';
  }

  static String testGroupChest(){
    return 'INSERT INTO GroupContainsExercise(exerciseId, groupName) VALUES (0001, "Chest")' +
    'INSERT INTO GroupContainsExercise(exerciseId, groupName) VALUES (0002, "Chest")' +
    'INSERT INTO GroupContainsExercise(exerciseId, groupName) VALUES (0003, "Chest")' +
    'INSERT INTO GroupContainsExercise(exerciseId, groupName) VALUES (0004, "Chest")' +
    'INSERT INTO GroupContainsExercise(exerciseId, groupName) VALUES (0005, "Chest")' +
    'INSERT INTO GroupContainsExercise(exerciseId, groupName) VALUES (0006, "Chest")';
  }

}