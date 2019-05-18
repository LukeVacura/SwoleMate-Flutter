import 'package:flutter/material.dart';
import 'package:swolemate/models/objects/exercise.dart';


class ExerciseSet {
  String id;
  Exercise exercise;
  int weight;
  int reps;
  int weightType; // 0 = lb, 1 = kg
  int setType; // 0 = normal, 1 = given

  ExerciseSet({
    @required this.id,
    @required this.exercise,
    this.weight,
    this.reps,
    this.weightType,
    this.setType,
  });

  factory ExerciseSet.fromJson(Map<String, dynamic> json) => new ExerciseSet(
        id: json["id"],
        exercise: json["exercise"],
        weight: json["weight"],
        reps: json["reps"],
        weightType: json["weightType"],  
        setType: json["setType"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "exercise": exercise,
        "weight": weight,
        "reps": reps,
        "weightType": weightType,
        "setType": setType,
    };


    get exerciseSet{
      return ExerciseSet;
    }
}