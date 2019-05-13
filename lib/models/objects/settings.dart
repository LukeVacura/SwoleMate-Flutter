import 'package:flutter/material.dart';

class Settings {
  final bool isShortcutsEnabled;
  final bool isDarkThemeUsed;
  final Color setColor;

  Settings({
    @required this.isShortcutsEnabled,
    @required this.isDarkThemeUsed,
    @required this.setColor,
  });
}
