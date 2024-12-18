import 'package:equatable/equatable.dart';

class ClassSchedule extends Equatable {
  final String id;
  final String courseName;
  final String instructor;
  final String time;
  final String location;
  final List<String> daysOfWeek;

  const ClassSchedule({
    required this.id,
    required this.courseName,
    required this.instructor,
    required this.time,
    required this.location,
    required this.daysOfWeek,
  });

  @override
  List<Object> get props => [id];

  // Static method to create a ClassSchedule from a Map
  static ClassSchedule fromMap(String id, Map<String, dynamic> map) {
    return ClassSchedule(
      id: id,
      courseName: map['courseName'] as String,
      instructor: map['instructor'] as String,
      time: map['time'] as String,
      location: map['location'] as String,
      daysOfWeek: List<String>.from(map['daysOfWeek'] as List<dynamic>),
    );
  }

  // Adding the copyWith method
  ClassSchedule copyWith({
    String? id,
    String? courseName,
    String? instructor,
    String? time,
    String? location,
    List<String>? daysOfWeek,
  }) {
    return ClassSchedule(
      id: id ?? this.id,
      courseName: courseName ?? this.courseName,
      instructor: instructor ?? this.instructor,
      time: time ?? this.time,
      location: location ?? this.location,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }
}

// Firestore-related extensions
extension ClassScheduleFirestore on ClassSchedule {
  // Convert ClassSchedule to Map
  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'instructor': instructor,
      'time': time,
      'location': location,
      'daysOfWeek': daysOfWeek,
    };
  }

  // Create a ClassSchedule from Map
  static ClassSchedule fromMap(String id, Map<String, dynamic> map) {
    return ClassSchedule(
      id: id,
      courseName: map['courseName'] as String,
      instructor: map['instructor'] as String,
      time: map['time'] as String,
      location: map['location'] as String,
      daysOfWeek: List<String>.from(map['daysOfWeek'] as List<dynamic>),
    );
  }
}
