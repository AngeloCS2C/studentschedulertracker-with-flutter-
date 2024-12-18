// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/class_schedule.dart';
import '../repositories/class_schedule_repo.dart';

class CreateClassSchedule {
  final ClassScheduleRepository repository;

  CreateClassSchedule({required this.repository});

  Future<Either<Failure, void>> call(ClassSchedule classSchedule) {
    return repository.createClassSchedule(classSchedule);
  }
}
