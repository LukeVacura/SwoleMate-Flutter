import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:swolemate/models/appmodel.dart';
import 'package:swolemate/models/database/databasehelper.dart';
import 'package:swolemate/models/database/databasepopulate.dart';

import 'package:swolemate/widgets/ui/loading.dart';

class WorkoutInformation extends StatefulWidget {
  final AppModel model;

  WorkoutInformation(this.model);

  @override
  State<StatefulWidget> createState() {
    return _WorkoutInformationState();
  }
}

class _WorkoutInformationState extends State<WorkoutInformation> {
  @override
  final dbHelper = DatabaseHelper.instance;
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack stack = new Stack(
          children: <Widget>[ 
            
          ],
        );

        // if (model.isLoading) {
        //   stack.children.add(LoadingModal());
        // }

        return stack;
      },
    );
  }

  Widget _buildBody(AppModel model){
    
    return ListView(
      children: <Widget>[
    
    ListTile(
              title: Text("Update and Query Button"),
              onTap: () async {
                print("pressed");
                DatabasePopulate.insert();
                final allRows = await dbHelper.queryAllRows();
                print('query all rows:');
               allRows.forEach((row) => print(row));
              },
            ),
            ListTile(
              title: Text("Delete"),
              onTap: () async {
                print("pressed delete");
                DatabaseHelper.deleteDatabase();
              },
            ),
      ],
    );
  }
}
