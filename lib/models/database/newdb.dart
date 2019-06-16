import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'doggie_database8.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      db.execute(
        "CREATE TABLE exercise(id TEXT PRIMARY KEY, name TEXT, type INTEGER, pref INTEGER, suf INTEGER, desc TEXT);",
      );
      db.execute(
        "CREATE TABLE exGroup(name TEXT PRIMARY KEY, desc TEXT);"
      );
      db.execute(DBDump.getCreateExInGroupTable());
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  var fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  var exercise1 = Exercise(
    id: '0001',
    name: 'Bench press (Barbell)',
    type: 0,
    pref: 1,
    suf: 0,
    desc: '',
  );

  List<ExerciseGroup> groups = [
    ExerciseGroup(name: 'Chest', desc: ''),
    ExerciseGroup(name: 'Back', desc: ''),
  ];

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

  for(int i=0; i<groups.length; i++){
    await insertGroup(groups.elementAt(i));
  }
  for(int i=0; i<chestExercises.length; i++){
    await insertExercise(chestExercises.elementAt(i));
    await insertExIntoGroup(chestExercises.elementAt(i), groups.elementAt(0));
  }
  for(int i=0; i<backExercises.length; i++){
    await insertExercise(backExercises.elementAt(i));
    await insertExIntoGroup(backExercises.elementAt(i), groups.elementAt(1));
  }

  // Insert a dog into the database.

  await insertExercise(exercise1);

  // Print the list of dogs (only Fido for now).
  // print(await dogs());
  print(await exercises());

  // Update Fido's age and save it to the database.
  // fido = Dog(
  //   id: fido.id,
  //   name: fido.name,
  //   age: fido.age + 7,
  // );
  // await updateDog(fido);

  // // Print Fido's updated information.
  // print(await dogs());

  // // Delete Fido from the database.
  // await deleteDog(fido.id);

  // // Print the list of dogs (empty).
  // print(await dogs());
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

class Exercise {
  String id;
  String name;
  int type;
  int pref;
  int suf;
  String desc;

  Exercise({
    this.id,
    this.name,
    this.type,
    this.pref,
    this.suf,
    this.desc,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => new Exercise(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        pref: json["pref"],
        suf: json["suf"],  
        desc: json["desc"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "pref": pref,
        "suf": suf,
        "desc": desc,
    };
    get exercise{
      return Exercise;
    }

    @override
    String toString() {
      return 'Exercise{id: $id, name: $name, type: $type, pref: $pref, suf: $suf, desc: $desc}';
    }
}

class ExerciseGroup {
  String name;
  String desc;

  ExerciseGroup({
    this.name,
    this.desc,
  });

  factory ExerciseGroup.fromMap(Map<String, dynamic> json) => new ExerciseGroup(
      name: json["name"],
      desc: json["desc"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "desc": desc,
    };


    get exercisegroup{
      return ExerciseGroup;
    }
}

class DBDump{
  static String getCreateGroupTable(){
    return "CREATE TABLE exGroup(" +
	  "name TEXT PRIMARY KEY, " +
	  "desc TEXT);";
  }

  static String getCreateExInGroupTable(){
    return "CREATE TABLE exInGroup(" + 
    "exerciseId TEXT PRIMARY KEY, " + 
    "groupName TEXT, " + 
    "FOREIGN KEY (exerciseId) REFERENCES exercise(id), " + 
    "FOREIGN KEY (groupName) REFERENCES exGroup(name));";
  }
}