import 'package:studentscheduletracker/features/task_assignment_tracking/data/models/assignment_model.dart';

abstract class AssignmentRemoteDataSource {
  Future<void> createAssignment(AssignmentModel assignment);
  Future<AssignmentModel> getAssignmentById(String id);
  Future<void> updateAssignment(
      AssignmentModel assignment, Map<String, dynamic> json);
  Future<void> deleteAssignment(String id);
  Future<List<AssignmentModel>> getAllAssignments();
}
