import 'package:flutter/material.dart';


class Workout {
  String id;
  String name;
  int type;
  int pref;
  int suf;

  Workout({
    @required this.id,
    @required this.name,
    this.type,
    this.pref,
    this.suf,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => new Workout(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        pref: json["pref"],
        suf: json["suf"],  
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "pref": pref,
        "suf": suf,
    };


    get exercise{
      return Workout;
    }
}
