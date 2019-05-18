import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:swolemate/models/appmodel.dart';

import 'package:swolemate/models/database/databasepopulate.dart';
import 'package:swolemate/models/handlers/settingshandler.dart';
import 'package:swolemate/models/objects/Exercise.dart';

class ExerciseListPage extends StatefulWidget {
  final AppModel model;

  ExerciseListPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ExerciseListPageState();
  }
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  @override
  void initState() {
    //widget.model.fetchExercises();

    super.initState();
  }

  static List<Exercise> chestExercises = ListHandler.getChestExercises();
  static List<Exercise> backExercises = ListHandler.getBackExercises();
  static List<Exercise> shoulderExercises = ListHandler.getShoulderExercises();
  static List<Exercise> trapExercises = ListHandler.getTrapExercises();
  static List<Exercise> bicepsExercises = ListHandler.getBicepsExercises();
  static List<Exercise> tricepsExercises = ListHandler.getTricepsExercises();
  static List<Exercise> forearmsExercises = ListHandler.getForearmExercises();
  static List<Exercise> coreExercises = ListHandler.getAbExercises();
  static List<Exercise> glutesExercises = ListHandler.getGluteExercises();
  static List<Exercise> quadExercises = ListHandler.getQuadExercises();
  static List<Exercise> hamstringExercises = ListHandler.getHamstringExercises();
  static List<Exercise> calfExercises = ListHandler.getCalfExercises();
  static List<Exercise> cardioExercises = ListHandler.getCardioExercises();
  static List<Exercise> fullbodyExercises = ListHandler.getFBExercises();
  static List<Exercise> otherExercises = ListHandler.getOtherExercises();
  
  static int newID = 2001;
  static int newType = 1;

  static final List<String> groups = [
    "Chest",
    "Back",
    "Shoulders",
    "Biceps",
    "Triceps",
    "Traps",
    "Forearms",
    "Core/Abs",
    "Glutes",
    "Quads",
    "Hamstrings",
    "Calves",
    "Cardio",
    "Full body",
    "Other",
  ];
  static final List<List<Exercise>> exercises = [
      chestExercises, //1
      backExercises,
      shoulderExercises,
      bicepsExercises,
      tricepsExercises, //5
      trapExercises,
      forearmsExercises, 
      coreExercises,
      glutesExercises,
      quadExercises, //10
      hamstringExercises, 
      calfExercises,
      cardioExercises,
      fullbodyExercises, 
      otherExercises, //15
  ];

  TextEditingController weightController = new TextEditingController();
  TextEditingController repsController = new TextEditingController();
  TextEditingController exerciseController = new TextEditingController();
  TextEditingController groupController = new TextEditingController();
  TextEditingController typeController = new TextEditingController();

  

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      body: _buildExerciseList(model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

        return stack;
      },
    );
  }
  
  Widget _buildAppBar(model){
    Color _accentColor = SettingsHandler.getColor(model);
    return AppBar(
      backgroundColor: _accentColor,
      title: Text('Exercises'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add),
          tooltip:'Add new exercise',
          onPressed: (){
            showDialog(context: context,
            builder: (BuildContext context) => _addNewExercise(context));
          }
        ),
      ]
    );
  }

  Widget _buildExerciseList(AppModel model) {
    List<ExpansionTile> _listOfExpansions = List<ExpansionTile>.generate(

      15,
      (i) => ExpansionTile(
            title: Text(groups.elementAt(i)),
            children: exercises.elementAt(i)
                .map((data) => ListTile(
                
                      leading: Text(data.id.toString()),
                      title: Text(data.name),
                      onTap: (){
                        print("Navigate");
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => _buildAboutDialog(context, data),);     
                      }
                    ))
                .toList(),
          ));


    return ListView(
        padding: EdgeInsets.all(8.0),
        children:
            _listOfExpansions.map((expansionTile) => expansionTile).toList(),
    );
  }


  static void navigateAccordingly(String title){
    print("navigate" + title);

    

    
  }

Widget _buildAboutDialog(BuildContext context, Exercise exercise) {
    String exerciseName = exercise.name;
    return new AlertDialog(
      
      title: Text(exerciseName),
      content: new Column(
       mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("Weight:"),
          new TextField(
            controller: weightController,
            maxLines: 1,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Please enter the weight'
            ),
          ),
          new Text("x"),
          new Text(""),
          new Text("Reps:"),
          new TextField(
            controller: repsController,
            maxLines: 1,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Please enter the reps'
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).accentColor,
          child: const Text('Close'),
        ),
        new FlatButton(
          onPressed: () {
            //Navigator.of(context).pop();
            _showDialog(context);
            //TodoListView.addNewExercise(exercise, weightController.text, repsController.text);
          },
          textColor: Theme.of(context).accentColor,
          child: const Text('Add Set'),
        ),
      ],
    );
  }
  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: new Text("Set has been added successfully!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
            ),
          ],
        );
      },
    );
  }
  Widget _addNewExercise(BuildContext context) {
    return new AlertDialog(
      
      title: Text('Add New Exercise'),
      content: new Column(
       mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("Please enter the exercise parameters"),
          new Text(""),
          new Text(""),
          new Text("Exercise name:"),
          new TextField(
            controller: exerciseController,
            maxLines: 1,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Example: Dumbbell high-low fly'
            ),
          ),
          new Text(""),
          new Text("Group name:"),
          new TextField(
            controller: groupController,
            maxLines: 1,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Example: Chest'
            ),
          ),
          new Text(""),
          new Text("Exercise type:"),
          new TextField(
            controller: typeController,
            maxLines: 1,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Compound or Accessory'
            ),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).accentColor,
          child: const Text('Close'),
        ),
        new FlatButton(
          onPressed: () {
            //Navigator.of(context).pop();
            _showNewExerciseDialog(context);
            if(typeController.text == 'Compound'){
              newType = 0;
            }
            else{
              newType = 1;
            }

            Exercise temp = new Exercise(id: newID.toString(), name: exerciseController.text, type: newType, pref:0, suf:0);
            switch(groupController.text){
              case 'Chest': {
                chestExercises.add(temp);
                break;
              }
              case 'Back': {
                backExercises.add(temp);
                break;
              }
              case 'Shoulders': {
                shoulderExercises.add(temp);
                break;
              }
              case 'Biceps': {
                bicepsExercises.add(temp);
                break;
              }
              case 'Triceps': {
                tricepsExercises.add(temp);
                break;
              }
              case 'Cardio': {
                cardioExercises.add(temp);
                break;
              }
              case 'Forearms': {
                forearmsExercises.add(temp);
                break;
              }
              case 'Quads': {
                quadExercises.add(temp);
                break;
              }
              case 'Hamstrings': {
                hamstringExercises.add(temp);
                break;
              }
              default: {
                otherExercises.add(temp);
                break;
              }
            }
            newID++;
          },
          textColor: Theme.of(context).accentColor,
          child: const Text('Add Exercise'),
        ),
      ],
    );
  }
  void _showNewExerciseDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: new Text("Exercise has been added successfully!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
            ),
          ],
        );
      },
    );
  }
}

