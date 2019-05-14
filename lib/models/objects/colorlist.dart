import 'package:flutter/material.dart';

class ColorList {
  static List<Color> colorOptions = [
    Colors.cyan[800],
    Colors.lightGreen[800],
    Colors.red[900],
    Colors.purple[800],
    Colors.blue[900],
    Colors.amber[900],
  ];

  static (){
    colorOptions = [
      Colors.cyan[800],
      Colors.lightGreen[800],
      Colors.red[900],
      Colors.purple[800],
      Colors.blue[900],
      Colors.amber[800],
    ];
  }

    // colors.add(Colors.cyan);
    // colors.add(Colors.lightGreen);
    // colors.add(Colors.red);
    // colors.add(Colors.purple);
    // colors.add(Colors.blue);
    // colors.add(Colors.amber);

  static List<Color> getColorList(){
    return colorOptions;
  }
}
