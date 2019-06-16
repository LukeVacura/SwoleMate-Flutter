import 'package:flutter/material.dart';


class ExerciseGroup {
  String name;
  String bigGroup;

  ExerciseGroup({
    @required this.name,
    bigGroup,
  });

  factory ExerciseGroup.fromMap(Map<String, dynamic> json) => new ExerciseGroup(
      name: json["name"],
      bigGroup: json["bigGroup"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "bigGroup": bigGroup,
    };


    get exercisegroup{
      return ExerciseGroup;
    }
}