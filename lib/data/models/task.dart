import 'package:flutter/material.dart';

class TaskModel {
  String id;
  String title;
  String description;
  Color color;
  DateTime dateTime;
  IconData iconData;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
    required this.dateTime,
    required this.iconData,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color.value,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'icon': iconData.codePoint,
      'is_completed': isCompleted ? 1 : 0,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      color: Color(map['color']),
      dateTime: DateTime.fromMillisecondsSinceEpoch(map["dateTime"]),
      iconData: IconData(map["icon"], fontFamily: 'MaterialIcons'),
      isCompleted: map['is_completed'] == 1,
    );
  }
}
