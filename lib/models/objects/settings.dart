import 'package:flutter/material.dart';

class Settings {
  final bool isShortcutsEnabled;
  final bool isDarkThemeUsed;
  final int setColor;
  final bool areUnitsImperial;
  final bool isCalendarImperial;
  final List<int> roundType;
  final List<int> weekType;

  Settings({
    @required this.isShortcutsEnabled,
    @required this.isDarkThemeUsed,
    @required this.setColor,
    @required this.areUnitsImperial,
    @required this.isCalendarImperial,
    @required this.roundType,
    @required this.weekType,
  });
}
