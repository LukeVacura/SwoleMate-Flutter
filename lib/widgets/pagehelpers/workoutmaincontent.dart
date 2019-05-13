import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:swolemate/models/appmodel.dart';

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
  String getDisplay(){
    String display = "";

    String day = _currentDate.day.toString();
    String month = _currentDate.month.toString();
    String year = _currentDate.year.toString();

    if(int.parse(month) < 10){
      month = "0" + month;
    }
    if(int.parse(day) < 10){
      day = "0" + day;
    }

    display = " " + month + "/" + day + "/" + year + " ";
    return display;
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2101)
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
              _selectDate(context);
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
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: getDisplayColor()),
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

  Widget _buildPageContent(AppModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          color: Colors.black26,
          child:
            _buildCalendar(model),
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
