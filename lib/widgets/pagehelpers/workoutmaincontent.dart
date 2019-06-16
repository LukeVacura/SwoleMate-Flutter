import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:swolemate/models/appmodel.dart';
import 'package:swolemate/models/handlers/settingshandler.dart';
import 'package:swolemate/models/objects/exercise.dart';
import 'package:swolemate/models/objects/set.dart';

import 'package:swolemate/widgets/ui/loading.dart';

class WorkoutPageContent extends StatefulWidget {
  final AppModel model;

  WorkoutPageContent(this.model);

  @override
  State<StatefulWidget> createState() {
    return _WorkoutPageContentState();
  }
}

class _WorkoutPageContentState extends State<WorkoutPageContent> {

   void handleNewDate(date) {
    print("handleNewDate ${date}");
  }

  /* Sets _currentDate to the ... Current Date
  Despite the name, _currentDate refers to the selected day in the app, so it will not always be the
  date of the use */
  DateTime _currentDate = DateTime.now();

  // Returns _currentDate
  DateTime getCD (){
    return _currentDate;
  }

  // Returns the _currentDate in the form of MM/DD/YYYY

  /* 5/15/19 - this code needs so much work lol but I also need to fix the display so that the date display ALWAYS uses the same amount of space
  instead of the janky spaces around Today, Yesterday and Tomorrow */ 

  String getDisplay(){
    String display = "";

    String day = _currentDate.day.toString();
    String month = _currentDate.month.toString();
    String year = _currentDate.year.toString();

    if((day + month + year) == DateTime.now().day.toString() + DateTime.now().month.toString() + DateTime.now().year.toString()){
      return "Today             ";
    }
    if((day + month + year) == DateTime.now().subtract(new Duration(days: 1)).day.toString() + DateTime.now().month.toString() + DateTime.now().year.toString()){
      return "Yesterday      ";
    }
    if((day + month + year) == DateTime.now().add(new Duration(days: 1)).day.toString() + DateTime.now().month.toString() + DateTime.now().year.toString()){
      return "Tomorrow     ";
    }

    if(int.parse(month) < 10){
      month = "0" + month;
    }
    if(int.parse(day) < 10){
      day = "0" + day;
    }

    display = " " + month + "/" + day + "/" + year + " ";
    return display;
  }

  /* 5/15/2019 - currently hardcoded to Workout Title for now */
  String getWorkoutTitle(){
    return "Workout Title";
  }

  // Changes the date color to light blue if it is the current date - currently not working
  Color getDisplayColor(){
    if (_currentDate == DateTime.now()){
      return Colors.lightBlue[300];
    }
    else{
      return Colors.white;
    }
  }

  DateTime selectedDate;
  @override
  void initState() {
    //widget.model.fetchExercises();

    super.initState();
  }

  Future<Null> _selectDate(AppModel model, BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2101),

      builder: (BuildContext context, Widget child) {
      return Theme(
        data: ThemeData(
          accentColor: SettingsHandler.getColor(model),
          brightness: SettingsHandler.isDarkThemeUsed(model) ? Brightness.dark : Brightness.light,
          primaryColor: SettingsHandler.getColor(model),
        ),
        child: child,
    );
  },
    );
    if (picked != null && picked != selectedDate){
      //print("Date selected");
      setState(() {
       _currentDate = picked; 
      });
    }
  }
  
  
  Widget _buildCalendar(AppModel model){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Ink(
          child: IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              print("View calendar");
              _selectDate(model, context);
            }
          ),
        ),
        Ink(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () async {
              print("Previous day");
              setState(() {
               _currentDate = _currentDate.subtract(new Duration(days: 1));
              });
            },
            tooltip: 'Previous day',
          ),
        ),
        Ink(
          child: Text(
            getDisplay(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: SettingsHandler.isDarkThemeUsed(model) ? Colors.white : Colors.black
            ),
          ),
        ),
        Ink(
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              print("Next day");
              setState(() {
               _currentDate = _currentDate.add(new Duration(days: 1));
              });
            },
            tooltip: 'Next day',
          ),
        ),
        Ink(
          child: IconButton(
            icon: Icon(Icons.restore),
            onPressed: () async {
              setState(() {
               _currentDate = DateTime.now();
              });
            },
            tooltip: 'Go to today',
          ),
        ),
      ],

    );
  }
  Widget _buildWorkoutHeader(AppModel model){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Ink(
          padding: EdgeInsets.fromLTRB(15.0, 0, 5.0, 0),
          child: Text(
            getWorkoutTitle(), 
              //"123456789012345678901234567890",  -- test case
              /* TITLES MAY ONLY HAVE A MAX OF 30 CHARACTERS BASED ON
               SIZE LIMITATIONS */
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: SettingsHandler.isDarkThemeUsed(model) ? Colors.white : Colors.black
            ),
          ),
        ),
        Spacer(flex: 1),
        Ink(
          child: IconButton(
            icon: Icon(Icons.add_circle),
            color: SettingsHandler.getColor(model),
            onPressed: () async {
              setState(() {
              });
            },
            tooltip: 'TEST QUERY',
          ),
        ),
        Ink(
          child: IconButton(
            icon: Icon(Icons.delete_forever),
            color: SettingsHandler.getColor(model),
            onPressed: () async {
              setState(() {
              });
            },
            tooltip: 'DELETE DB',
          ),
        ),
        Spacer(flex: 1),
        Ink(
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              setState(() {
              });
            },
            tooltip: 'Edit workout properties',
          ),
        ),
        Ink(
          child: IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () async {
              setState(() {
              });
            },
            tooltip: 'Clear workout',
          ),
        ),
      ],

    );
  }

  Widget _buildWorkoutContent(AppModel model){
    return model.isLoading ? LoadingModal() :
    Expanded(
      child: Container(
        color: SettingsHandler.isDarkThemeUsed(model) ? Colors.grey[850] : Colors.grey[200],
        child: ListView(
          children: getSettings(model, context)
        ),
      ),
    );
  }

  static Widget createExerciseTile(AppModel model, List<ExerciseSet> sets){
    TextStyle setStyle = new TextStyle(fontWeight: FontWeight.bold, fontSize: 16); // MUST READ THE STYLE FROM ANOTHER CLASS
    TextStyle setStyleAssigned = new TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: SettingsHandler.isDarkThemeUsed(model) ? Colors.grey[200] : Colors.blue[500]);
    Color tileColor = SettingsHandler.isDarkThemeUsed(model) ? Colors.grey[800] : Colors.grey[200]; // MUST READ FROM ANOTHER CLASS
    Color titleColor = SettingsHandler.isDarkThemeUsed(model) ? Colors.white12 : Colors.white;

    List<Widget> gridPopulate = new List<Widget>();

    for(int i=0; i<sets.length; i++){
      bool isWeightMetric = (sets.elementAt(i).weightType == 1);
      bool isPR = false;
      bool isAssigned = false;
      String exerciseWeight;
      String suffix = isWeightMetric? "lbs" : "kg";

      if(sets.elementAt(i).setType == 1){
        isAssigned = true;
        exerciseWeight = sets.elementAt(i).weight.toString() + "%";

        /* If user has a TM for the exercise ID - append exerciseWeight with a (Estimated Weight) 
        for instance, if it is set at 90% and the user's TM is 200 lbs, it would display as 90% (180 lbs) */

      }
      else{
        exerciseWeight = sets.elementAt(i).weight.toString() + " " + suffix;
      }

      gridPopulate.add(Center(child: Text(exerciseWeight, style: isAssigned? setStyleAssigned : setStyle)));
      gridPopulate.add(Center(child: Text('x', style: setStyle)));
      gridPopulate.add(Center(child: Text('4 reps', style: setStyle)));

      isPR ? gridPopulate.add(Center(child: Icon(Icons.star))) : gridPopulate.add(Center());
    }
    
    GestureDetector tile = new GestureDetector(
      onTap:(){print("EDIT");},
      child: Card(
        color: titleColor,
        margin: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
        child: Column(
          children: <Widget>[
            Container(
              color: SettingsHandler.isDarkThemeUsed(model) ? Colors.black12 : Colors.grey[50],
              child: Row(),   
              padding: EdgeInsets.all(8.0),
            ),
            Container(
              color: SettingsHandler.isDarkThemeUsed(model) ? Colors.black12 : Colors.grey[50],
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(6.0)),
                  Expanded(
                    child: Text(sets.elementAt(0).exercise.name, style: 
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ), 
                    ),
                  ),
                  Spacer(flex: 1), 
                  Icon(Icons.edit),
                ],
              ),
            ),
            Container(
              color: SettingsHandler.isDarkThemeUsed(model) ? Colors.black12 : Colors.grey[50],
              child: Row(),   
              padding: EdgeInsets.all(2.0),
            ),
            Container(
              color: SettingsHandler.isDarkThemeUsed(model) ? Colors.white30 : Colors.black26,
              padding: EdgeInsets.all(8.0),
              height: 2.0,
            ),
            Container(
              child:CustomScrollView(
                shrinkWrap: true,
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(4.0),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 8.0,
                      crossAxisCount: 4,
                      childAspectRatio: (5),
                      children: gridPopulate,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return tile;
  }
  
  List<Widget> getSettings(AppModel model, BuildContext context) {
    Color titleColor = SettingsHandler.isDarkThemeUsed(model) ? Colors.white12 : Colors.white;
    Color tileColor = SettingsHandler.isDarkThemeUsed(model) ? Colors.grey[800] : Colors.grey[200];

    List<Exercise> exercises = new List<Exercise>();
    exercises.add(new Exercise(id: "1", name: "Barbell bench press", type: 1, pref: 0, suf: 1, desc: null));
    exercises.add(new Exercise(id: "2", name: "Barbell incline press", type: 1, pref: 0, suf: 1, desc: null));

    List<ExerciseSet> benchsets = new List<ExerciseSet>();
    benchsets.add(new ExerciseSet(id: "1", exercise: exercises.elementAt(0), weight: 225, reps: 4, weightType: 1));
    benchsets.add(new ExerciseSet(id: "2", exercise: exercises.elementAt(0), weight: 225, reps: 4, weightType: 1));
    benchsets.add(new ExerciseSet(id: "3", exercise: exercises.elementAt(0), weight: 225, reps: 4, weightType: 1));

    List<ExerciseSet> inclinesets = new List<ExerciseSet>();
    inclinesets.add(new ExerciseSet(id: "4", exercise: exercises.elementAt(1), weight: 185, reps: 4, weightType: 1));
    inclinesets.add(new ExerciseSet(id: "5", exercise: exercises.elementAt(1), weight: 185, reps: 4, weightType: 1));
    inclinesets.add(new ExerciseSet(id: "6", exercise: exercises.elementAt(1), weight: 185, reps: 4, weightType: 1));

    List<ExerciseSet> inclinesets2 = new List<ExerciseSet>();
    inclinesets2.add(new ExerciseSet(id: "7", exercise: exercises.elementAt(1), weight: 90, reps: 4, weightType: 1, setType: 1));
    inclinesets2.add(new ExerciseSet(id: "8", exercise: exercises.elementAt(1), weight: 85, reps: 4, weightType: 1, setType: 1));
    inclinesets2.add(new ExerciseSet(id: "9", exercise: exercises.elementAt(1), weight: 80, reps: 4, weightType: 1, setType: 1));

    List<Widget> exerciseTiles = new List<Widget>();
    exerciseTiles.add(createExerciseTile(model, benchsets));
    exerciseTiles.add(createExerciseTile(model, inclinesets));
    exerciseTiles.add(createExerciseTile(model, inclinesets2));

    return [
      _buildWorkoutHeader(model),

      Container(
        margin: EdgeInsetsDirectional.fromSTEB(4.0, 8.0, 4.0, 5.0),
        child: Column(
          children: exerciseTiles,
        ),
      ),
    ];
  }
  Widget _buildPageContent(AppModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          color: SettingsHandler.isDarkThemeUsed(model) ? Colors.grey[900] : Colors.grey[300],
          child:
            _buildCalendar(model),
        ),
        new Container(
          child: _buildWorkoutContent(model),
        ),
      ],
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

        if (model.isLoading) {
          stack.children.add(LoadingModal());
        }

        return stack;
      },
    );
  }
}
