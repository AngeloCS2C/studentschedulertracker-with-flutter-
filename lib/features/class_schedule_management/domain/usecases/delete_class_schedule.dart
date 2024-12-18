// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/class_schedule_repo.dart';

class DeleteClassSchedule {
  final ClassScheduleRepository repository;

  DeleteClassSchedule({required this.repository});

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteClassSchedule(id);
  }
}
