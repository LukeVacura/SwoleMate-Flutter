 import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
//import 'package:swolemate/models/objects/firebase.dart';
import 'package:swolemate/models/appmodel.dart';
import 'package:swolemate/models/objects/colorlist.dart';
import 'package:swolemate/models/objects/settings.dart';
import 'dart:async';

import 'package:swolemate/widgets/helpers/confirmdialog.dart';
import 'package:swolemate/widgets/ui/loading.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class SettingsPage extends StatefulWidget {
  final AppModel model;

  SettingsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
  
  
}

class _SettingsPageState extends State<SettingsPage> {
  Color _accentColor;

  @override
  void initState() {
    //widget.model.fetchExercises();

    super.initState();
  }
  ColorSwatch _tempAccentColor;



  Widget _buildAppBar(AppModel model) {
    return AppBar(
      backgroundColor: ColorList.getColorList().elementAt(model.settings.setColor),
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
            model.toggleColor(getColorIndex(_accentColor));
            //_accentColor = ColorList.getColorList().elementAt(model.settings.setColor);
          },
        ),
      ],
    );
  }

  Widget _buildPageContent(AppModel model) {
    if(_accentColor == null){
      _accentColor = ColorList.getColorList().elementAt(model.settings.setColor);
    }
    return Scaffold(
      appBar: _buildAppBar(model),
      body: _buildBody(model),
    );
  }

  Widget _buildBody(AppModel model){
    return model.isLoading ? LoadingModal() :
    ListView(
      children: getSettings(model, context),

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

  List<ColorSwatch> getColors(){
    List<ColorSwatch> colors = new List<ColorSwatch>();

    colors.add(Colors.cyan);
    colors.add(Colors.lightGreen);
    colors.add(Colors.red);
    colors.add(Colors.purple);
    colors.add(Colors.blue);
    colors.add(Colors.amber);

    return colors;
  }

  int getColorIndex(Color c){
    List<ColorSwatch> colors = getColors();

    int index = colors.indexOf(c);
    return index;
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
            colors: getColors(),

              /* 5/13/2019 - need to update the colorSwatches later on so that they show
              the correct color on selection - right now just uses default Flutter colorSwatches */
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


  List<Widget> getSettings(AppModel model, BuildContext context) {
    // I have no idea why this model boolean calls are working when it's broken on the other page currently
    // Weird stuff - will look into a fix later - 5/14/19
    Color titleColor = model.settings.isDarkThemeUsed? Colors.grey[700] : Colors.white;
    Color tileColor = model.settings.isDarkThemeUsed? Colors.grey[800] : Colors.grey[200];

    return [
    Container(
      margin: EdgeInsetsDirectional.fromSTEB(4.0, 8.0, 4.0, 5.0),
      
      child: Column(
        children: <Widget>[
          Card(
            color: titleColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: ListTile(
              title: Text("Basic Settings"),
            ),
          ),
          Card(
            color: tileColor,
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
          Card(
            color: tileColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Enable dark mode"),
              leading: Icon(Icons.brightness_3, size: 30),
              trailing: Switch(
                value: model.settings.isDarkThemeUsed,
                onChanged: (value) {
                  model.toggleIsDarkThemeUsed();
                },
                activeTrackColor: Colors.grey[600], 
                activeColor: Colors.grey[300],
              ),
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
            color: titleColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: ListTile(
              title: Text("Workout Settings"),
            ),
          ),
          Card(
            color: tileColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Weight units"),
              subtitle: Text("Imperial or Metric"),
              trailing: model.settings.areUnitsImperial ? Text("Imperial") : Text("Metric"),
              onTap: (){
                model.toggleAreUnitsImperial();
              },
            ),
          ),
          Card(
            color: tileColor,
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
            color: tileColor,
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
            color: tileColor,
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
            color: titleColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: ListTile(
              title: Text("Account Settings - COMING SOON"),
            ),
          ),
          Card(
            color: tileColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Edit account details"),
              subtitle: Text("Change username, password, etc."),
            ),
          ),
          Card(
            color: tileColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Delete account"),
              subtitle: Text("Removes account and all saved data"),
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
            color: titleColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: ListTile(
              title: Text("Data Settings"),
            ),
          ),
          Card(
            color: tileColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Back up data"),
              subtitle: Text("Back up your data via local storage or Google Drive"),
            ),
          ),
          Card(
            color: tileColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("Restore data"),
              subtitle: Text("Restore data from previous backup"),
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
            color: titleColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: ListTile(
              title: Text("Other Options"),
            ),
          ),
          Card(
            color: tileColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("View changelog"),
              subtitle: Text("View previous updates and their respective logs"),
            ),
          ),
          Card(
            color: tileColor,
            margin: EdgeInsetsDirectional.fromSTEB(4.0, 2.0, 4.0, 2.0),
            child: ListTile(
              enabled: true,
              title: Text("View on GitHub"),
              subtitle: Text("View source code on GitHub"),
            ),
          ),
        ],
      ),
    ),
  ];
}
}

