// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';
import 'package:studentscheduletracker/core/errors/failure.dart';
import 'package:studentscheduletracker/features/task_assignment_tracking/data/models/assignment_model.dart';
import 'package:studentscheduletracker/features/task_assignment_tracking/domain/entities/class_assignment.dart';

abstract class AssignmentRepository {
  Future<Either<Failure, List<Assignment>>> getAllAssignments();
  Future<Either<Failure, AssignmentModel>> getAssignmentById(String id);
  Future<Either<Failure, Unit>> createAssignment(Assignment assignment);
  Future<Either<Failure, AssignmentModel>> updateAssignment(
      Assignment assignment, Map<String, Object> json);
  Future<Either<Failure, Unit>> deleteAssignment(String id);
}
