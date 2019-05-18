import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swolemate/models/objects/colorlist.dart';
import '../appmodel.dart';

class SettingsHandler{
  static bool isDarkThemeUsed (AppModel model){ 
    /* This was sort of a hack in my eyes because the app on default is forced
    into no Dark Theme mode. Essentially returns if the model has darkTheme true
    or false. However, without the user setting it, it's null which is why I have
    to catch the exception. I am hoping to fix this later, but for now, this is
    what I've implemented.
    5/14/2019 - LV */

    // Also... why is the Settings page not broken from the same issue??? 
    
    try{
      return model.settings.isDarkThemeUsed;
    }
    catch(NoSuchMethodError){
      return false;
    }
  }
  static Color getColor(AppModel model){
    /* This method follows the same concept as the isDarkThemeUsed method. Once
    again, I'm hoping to fix these exceptions later on.
    5/14/2019 - LV */
    try{
      return ColorList.getColorList().elementAt(model.settings.setColor);
    }
    catch (Exception){
      return Colors.blue;
    }
  }
}