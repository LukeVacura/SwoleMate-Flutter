import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swolemate/models/appmodel.dart';
import 'package:swolemate/models/database/dbhelper.dart';

import 'package:swolemate/models/handlers/settingshandler.dart';
import 'package:swolemate/models/objects/exercise.dart';
import 'package:swolemate/models/objects/group.dart';

import '../widgets/assets/fontassets.dart';



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

  printExercises() async{
    print(await DBHelper.instance.exercises());
  }


  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      body: _buildExerciseList(model),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          //
        }),
        child: Icon(Icons.add),
        tooltip: 'Add custom exercise',
      ),
    ); 
  }

  Widget _buildContent(AppModel model){
    return Column(
      children: <Widget>[
       _buildSearchBar(model),
       _buildExerciseList(model),
      ],
    );
  }

  Widget _buildSearchBar(AppModel model){
    return Row(
      children: <Widget>[
        Icon(Icons.search),
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
        IconButton(icon: Icon(Icons.search, size: 30.0, semanticLabel: 'Add exercise',),
          tooltip:'Add new exercise',
          onPressed: (){
            // showDialog(context: context,
            // builder: (BuildContext context) => _addNewExercise(context));
          }
        ),
        PopupMenuButton<String>(
          onSelected: (String choice) {
            switch (choice) {
              case 'Settings':
                Navigator.pushNamed(context, '/settings');
            }
            switch (choice) {
              case 'Profile':
                Navigator.pushNamed(context, '/profile');
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
               PopupMenuItem<String>(
                value: 'Profile',
                child: Text('Profile'),
              )
            ];
          },
        ),
      ]
    );
  }

  // Widget _buildExerciseList(AppModel model){
  //   printExercises();
  //   return FutureBuilder<List<Exercise>>(
  //     future: DBHelper.instance.getBPExercises("Back"),
  //     builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
  //       if (snapshot.hasData) {
  //         return ListView.builder(
  //           itemCount: snapshot.data.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             Exercise item = snapshot.data[index];
  //             return ListTile(
  //               title: Text(item.name),
  //               leading: Text(item.id),
  //               trailing: Text(item.desc),
  //             );
  //           },
  //         );
  //       } else {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );

  // }

  Widget _buildExerciseList(AppModel model){
    printExercises();
    return Center(child:
      FutureBuilder<List<ExerciseGroup>>(
        future: DBHelper.instance.getGroups(),
        builder: (BuildContext context, AsyncSnapshot<List<ExerciseGroup>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                ExerciseGroup item = snapshot.data[index];
                Future<List<Exercise>> exercises = DBHelper.instance.getBPExercises(item.name);
                return ExpansionTile(
                  title: Text(item.name),
                  children: <Widget>[
                    _buildExercises(model, exercises),
                  ],
                  trailing: Text(""),
                  leading: Icon(Icons.arrow_drop_down),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  Widget _buildExercises(AppModel model, Future<List<Exercise>> exercises){
    return FutureBuilder<List<Exercise>>(
      future: exercises,
      builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Exercise item = snapshot.data[index];
              return ListTile(
                title: Text(item.name),
                leading: Text(item.id),
                trailing: Text(item.desc),
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

