import 'package:flutter/material.dart';
import 'package:swolemate/pages/settings.dart';

import 'package:swolemate/pages/workoutmain.dart';
import 'package:swolemate/models/appmodel.dart';

import 'package:scoped_model/scoped_model.dart';

void main() => runApp(SwoleMateApp());

class SwoleMateApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return MyApp();
  }

}
class MyApp extends State<SwoleMateApp> {
  // This widget is the root of your application.
  AppModel _model;
  bool _isAuthenticated = false;
  bool _isDarkThemeUsed = true;

  @override
  void initState() {
    _model = AppModel();

    _model.loadSettings();
    _model.autoAuthentication();

    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });

    _model.themeSubject.listen((bool isDarkThemeUsed) {
      setState(() {
        _isDarkThemeUsed = isDarkThemeUsed;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: _model,
      child: MaterialApp(
      title: 'SwoleMate',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        accentColor: Colors.lightBlue[300],
        brightness: Brightness.dark,
      ),
      routes: {
          '/settings': (BuildContext context) => SettingsPage(_model),
          // '/editor': (BuildContext context) =>
          //     _isAuthenticated ? TodoEditorPage() : AuthPage(),
          // '/register': (BuildContext context) =>
          //     _isAuthenticated ? WorkoutPage(_model) : RegisterPage(),
          // '/profile': (BuildContext context) =>
          //     _isAuthenticated ? ProfilePage(_model) : AuthPage(),
          // '/goals' : (BuildContext context) =>
          //     _isAuthenticated ? GoalsPage(_model) : AuthPage(),
          // '/import' : (BuildContext context) =>
          //     _isAuthenticated ? ImportPage(_model) : AuthPage(),
        },
      home: WorkoutPage(_model),
      ),
    );
  }
}

