// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/class_schedule.dart';
import '../repositories/class_schedule_repo.dart';

class GetAllClassSchedules {
  final ClassScheduleRepository repository;

  GetAllClassSchedules({required this.repository});

  Future<Either<Failure, ClassSchedule>> call() {
    return repository.getClassScheduleById(id as String);
  }
}
