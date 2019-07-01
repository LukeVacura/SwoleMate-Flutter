import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swolemate/models/appmodel.dart';
import 'package:swolemate/models/database/dbhelper.dart';

import 'package:swolemate/models/handlers/settingshandler.dart';
import 'package:swolemate/models/objects/exercise.dart';
import 'package:swolemate/models/objects/group.dart';

import '../models/database/dbhelper.dart' as prefix0;


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
            // showDialog(context: context,
            // builder: (BuildContext context) => _addNewExercise(context));
          }
        ),
      ]
    );
  }

  Widget _buildExerciseList(AppModel model){
    printExercises();
    FutureBuilder<List<Exercise>>(
      future: DBHelper.instance.exercises(),
      initialData: List(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, int index) {
              final item = snapshot.data[index];
              return ListTile(
                title: Text(item.name),
                leading: Text(item.name.toString()),
                trailing: Checkbox(
                  onChanged: (bool value) {
                    // DBProvider.db.blockClient(item);
                    // setState(() {});
                  },
                  //value: item.blocked,
                ),
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

