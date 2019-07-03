import 'package:flutter/material.dart';


class ExerciseGroup{
  String name;
  String desc;

  ExerciseGroup({
    @required this.name,
    desc,
  });

  factory ExerciseGroup.fromMap(Map<String, dynamic> json) => new ExerciseGroup(
      name: json["name"],
      desc: json["desc"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "desc": desc,
    };


    get exercisegroup{
      return ExerciseGroup;
    }

    @override
    String toString(){
      return 'Group{name: $name, desc: $desc}';
    }


  
}