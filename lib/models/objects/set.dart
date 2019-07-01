import 'package:flutter/material.dart';
import 'exercise.dart';


class ExerciseSet {
  String id;
  Exercise exercise;
  int weight;
  int percent;
  int reps;
  int weightType; // 0 = lb, 1 = kg
  int setType; // 0 = normal, 1 = given

  ExerciseSet({
    @required this.id,
    @required this.exercise,
    this.weight,
    this.percent,
    this.reps,
    this.weightType,
    this.setType,
  });

  factory ExerciseSet.fromMap(Map<String, dynamic> json) => new ExerciseSet(
        id: json["id"],
        exercise: json["exercise"],
        weight: json["weight"],
        percent: json["percent"],
        reps: json["reps"],
        weightType: json["weightType"],  
        setType: json["setType"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "exercise": exercise,
        "weight": weight,
        "percent": percent,
        "reps": reps,
        "weightType": weightType,
        "setType": setType,
    };


    get exerciseSet{
      return ExerciseSet;
    }
}