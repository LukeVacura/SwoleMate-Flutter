 import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
//import 'package:swolemate/models/objects/firebase.dart';
import 'package:swolemate/models/appmodel.dart';
import 'package:swolemate/models/objects/settings.dart';
import 'dart:async';

import 'package:swolemate/widgets/helpers/confirmdialog.dart';
import 'package:swolemate/widgets/ui/loading.dart';
import 'package:swolemate/widgets/pagehelpers/settingsmaincontent.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class Setting {
  String title;
  String info;

  Setting(
      {this.title, this.info});
}

class SettingsPage extends StatefulWidget {
  final AppModel model;

  SettingsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
  
  
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    //widget.model.fetchExercises();

    super.initState();
  }

  ColorSwatch _tempAccentColor;
  Color _accentColor = Colors.cyan;

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      backgroundColor: Colors.cyan[800],
      //leading: Icon(Icons.favorite),
      title: Text("App Settings"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () async {
            // bool confirm = await ConfirmDialog.show(context);

            // if (confirm == true) {
            //   model.logout();
            // }
            print("Saved settings!");
          },
        ),
      ],
    );
  }

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
      appBar: _buildAppBar(model),
      body: _buildBody(model),
    );
  }

  Widget _buildBody(AppModel model){
    return ListView(
      children: getSettings(context),

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

  void _openDialog(){
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text("Select color"),
          content: MaterialColorPicker(
            allowShades: false,
            selectedColor: _accentColor,
            onMainColorChange: (color) => setState(() => _tempAccentColor = color),
            colors: [

              /* 5/13/2019 - need to update the colorSwatches later on so that they show
              the correct color on selection - right now just uses default Flutter colorSwatches */
              Colors.cyan,
              Colors.deepPurple,
              Colors.lightGreen,
              Colors.red,
              Colors.lightBlue,
              Colors.purple,
              Colors.pink,
              Colors.blue,
              Colors.amber,
              Colors.green,
              Colors.orange,
              Colors.deepOrange,
              // Colors.cyan[800],
              // Colors.deepPurple[300],
              // Colors.lightGreen[800],
              // Colors.red[900],
              // Colors.blue[800],
              // Colors.lightBlue[400],
              // Colors.purple[800],
              // Colors.pink[700],
              // Colors.amber[800],
            ],
          ),
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _accentColor = _tempAccentColor);
              },
            ),
          ],
        );
      },
    );
  }
  List<Widget> getSettings(BuildContext context) {
  return [
    Container(
      margin: EdgeInsetsDirectional.fromSTEB(4.0, 8.0, 4.0, 5.0),
      
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.grey[700],
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: ListTile(
              title: Text("Basic Settings"),
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Accent color"),
              leading: CircleAvatar(
                backgroundColor: _accentColor,
                radius: 15.0,
              ),
              onTap: _openDialog,
            ),
          ),
        ],
      ),
    ),
    Container(
      margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 5.0),
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.grey[700],
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: ListTile(
              title: Text("Workout Settings"),
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Weight units"),
              subtitle: Text("Imperial or Metric"),
              trailing: Text("Imperial"),
              onTap: (){
                print("Switch");
              },
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Weight rounding"),
              subtitle: Text("Select the rounding of weights"),
              trailing: Text("5 lbs"),
              onTap: (){
                print("Switch");
              },
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Date format"),
              subtitle: Text("MM/DD/YYYY or DD/MM/YYYY"),
              trailing: Text("MM/DD/YYYY"),
              onTap: (){
                print("Switch");
              },
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Week format"),
              subtitle: Text("Select the week start on"),
              trailing: Text("Sunday"),
              onTap: (){
                print("Switch");
              },
            ),
          ),
        ],
      ),
    ),
    Container(
      margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 5.0),
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.grey[700],
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: ListTile(
              title: Text("Account Settings"),
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Weight units"),
              subtitle: Text("Imperial or Metric"),
              trailing: Text("Imperial"),
              onTap: (){
                print("Switch");
              },
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Weight rounding"),
              subtitle: Text("Select the rounding of weights"),
              trailing: Text("5 lbs"),
              onTap: (){
                print("Switch");
              },
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Date format"),
              subtitle: Text("MM/DD/YYYY or DD/MM/YYYY"),
              trailing: Text("MM/DD/YYYY"),
              onTap: (){
                print("Switch");
              },
            ),
          ),
          Card(
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Week format"),
              subtitle: Text("Select the week start on"),
              trailing: Text("Sunday"),
              onTap: (){
                print("Switch");
              },
            ),
          ),
        ],
      ),
    ),
  ];
}
}

