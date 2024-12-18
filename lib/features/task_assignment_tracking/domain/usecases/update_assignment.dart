// ignore_for_file: depend_on_referenced_packages

import '../../../../core/errors/failure.dart';
import '../entities/class_assignment.dart';
import '../repositories/class_assignment_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateAssignment {
  final AssignmentRepository repository;

  UpdateAssignment({required this.repository});

  Future<Either<Failure, void>> call(
      Assignment assignment, Map<String, Object> json) {
    return repository.updateAssignment(assignment, json);
  }
}
