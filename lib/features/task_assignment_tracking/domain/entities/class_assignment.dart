import 'package:equatable/equatable.dart';

class Assignment extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority; // Low, Medium, High
  final bool isCompleted;

  const Assignment({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });

  @override
  List<Object> get props => [id];

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  // Create from Map for Firestore
  static Assignment fromMap(String id, Map<String, dynamic> map) {
    return Assignment(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      dueDate: DateTime.parse(map['dueDate'] as String),
      priority: map['priority'] as String,
      isCompleted: map['isCompleted'] as bool,
    );
  }

  // Adding the copyWith method
  Assignment copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? priority,
    bool? isCompleted,
  }) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
