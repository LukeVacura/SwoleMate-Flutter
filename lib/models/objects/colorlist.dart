import 'package:flutter/material.dart';

class ColorList {
  static List<Color> colorOptions;

  static (){
    colorOptions = [
      Colors.cyan[800],
      Colors.deepPurple[300],
      Colors.lightGreen[800],
      Colors.red[900],
      Colors.blue[800],
      Colors.lightBlue[400],
      Colors.purple[800],
      Colors.pink[700],
      Colors.amber[800],
    ];
  }

  // List<Color> setColorList(){
  //   colorOptions.add(Colors.cyan[800]);
  //   colorOptions.add(Colors.deepPurple[300]);
  //   colorOptions.add(Colors.lightGreen[800]);
  //   colorOptions.add(Colors.red[900]);
  //   colorOptions.add(Colors.blue[800]);
  //   colorOptions.add(Colors.purple[800]);
  //   colorOptions.add(Colors.lightBlue[400]);
  //   colorOptions.add(Colors.pink[700]);
  //   colorOptions.add(Colors.amber[800]);

  //   return colorOptions;
  // }

  static List<Color> getColorList(){
    return colorOptions;
  }
}
