import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:swolemate/models/handlers/settingshandler.dart';
//import 'package:swolemate/models/objects/firebase.dart';
import 'package:swolemate/models/objects/app.dart';
import 'package:swolemate/models/appmodel.dart';

import 'package:swolemate/widgets/helpers/confirmdialog.dart';
import 'package:swolemate/widgets/ui/loading.dart';
import 'package:swolemate/widgets/pagehelpers/workoutmaincontent.dart';

class WorkoutPage extends StatefulWidget {
  final AppModel model;

  

  WorkoutPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _WorkoutPageState();
  }
  
  
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      backgroundColor: SettingsHandler.getColor(model),
      leading: Icon(Icons.favorite),
      title: Text(AppInfo.AppName),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            print("Profile");
          }

        ),
        IconButton(
          icon: Icon(Icons.lock),
          onPressed: () async {
            bool confirm = await ConfirmDialog.show(context);

            if (confirm == true) {
              model.logout();
            }
          },
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
      ],
    );
  }

  Widget _buildImportFlatButton(AppModel model) {
    return FlatButton(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.file_download,
              size: 30.0,
              //color: model.filter == Filter.Progress ? Colors.white : Colors.black,
            ),
            Text(
              'Import',
              style: TextStyle(
              ),
            )
          ],
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/import'); 
      },
    );
  }

  Widget _buildAddFlatButton(AppModel model) {
    return FlatButton(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.add,
              size: 30.0,
            ),
            Text(
              'Add',
              style: TextStyle(
              ),
            )
          ],
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/addexercise');
      },
    );
  }

  Widget _buildSaveFlatButton(AppModel model) {
    return FlatButton(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.file_upload,
              size: 30.0,
            ),
            Text(
              'Save',
              style: TextStyle(
                //color: model.filter == Filter.Workout ? Colors.white : Colors.black,
              ),
            )
          ],
        ),
      ),
       onPressed: () {
        Navigator.pushNamed(context, '/save');
      },
    );
  }

  Widget _buildBottomAppBar(AppModel model) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // SizedBox(),
          _buildImportFlatButton(model),
          _buildAddFlatButton(model),
          _buildSaveFlatButton(model),
          // SizedBox(
          //   width: 80.0,
          // ),
        ],
      ),
      color: SettingsHandler.isDarkThemeUsed(model) ? Colors.grey[900] : Colors.grey[300],
      shape: CircularNotchedRectangle(),
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: _buildBottomAppBar(model),
      body: WorkoutPageContent(model),
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
