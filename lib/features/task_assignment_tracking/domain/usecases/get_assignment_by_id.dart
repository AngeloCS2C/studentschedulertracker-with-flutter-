// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';

import 'package:studentscheduletracker/core/errors/failure.dart';

import '../entities/class_assignment.dart';
import '../repositories/class_assignment_repo.dart';

class GetAssignmentById {
  final AssignmentRepository repository;

  GetAssignmentById({required this.repository});

  Future<Either<Failure, Assignment>> call(String id) {
    return repository.getAssignmentById(id);
  }
}
