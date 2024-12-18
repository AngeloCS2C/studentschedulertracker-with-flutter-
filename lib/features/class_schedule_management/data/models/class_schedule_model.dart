import 'package:studentscheduletracker/features/class_schedule_management/domain/entities/class_schedule.dart';
import 'dart:convert';

class ClassScheduleModel extends ClassSchedule {
  const ClassScheduleModel({
    required super.id,
    required super.courseName,
    required super.instructor,
    required super.time,
    required super.location,
    required super.daysOfWeek,
  });

  // Factory method to create an instance from a map (for data parsing)
  factory ClassScheduleModel.fromMap(Map<String, dynamic> map) {
    return ClassScheduleModel(
      id: map['id'] ?? '',
      courseName: map['courseName'] ?? '',
      instructor: map['instructor'] ?? '',
      time: map['time'] ?? '',
      location: map['location'] ?? '',
      daysOfWeek: List<String>.from(map['daysOfWeek'] ?? []),
    );
  }

  // Factory method to create an instance from a JSON string (for JSON parsing)
  factory ClassScheduleModel.fromJson(String source) =>
      ClassScheduleModel.fromMap(json.decode(source));

  // Method to convert the instance to a map (for saving or sending data)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courseName': courseName,
      'instructor': instructor,
      'time': time,
      'location': location,
      'daysOfWeek': daysOfWeek,
    };
  }

  // Method to convert the instance to a JSON string (for API requests or storage)
  String toJson() => json.encode(toMap());

  // Adding the copyWith method
  @override
  ClassScheduleModel copyWith({
    String? id,
    String? courseName,
    String? instructor,
    String? time,
    String? location,
    List<String>? daysOfWeek,
  }) {
    return ClassScheduleModel(
      id: id ?? this.id,
      courseName: courseName ?? this.courseName,
      instructor: instructor ?? this.instructor,
      time: time ?? this.time,
      location: location ?? this.location,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }
}
