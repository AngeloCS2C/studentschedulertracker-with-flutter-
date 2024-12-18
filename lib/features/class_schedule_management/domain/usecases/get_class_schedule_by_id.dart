// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/class_schedule.dart';
import '../repositories/class_schedule_repo.dart';

class GetClassScheduleById {
  final ClassScheduleRepository repository;

  GetClassScheduleById({required this.repository});

  Future<Either<Failure, ClassSchedule>> call(String id) {
    return repository.getClassScheduleById(id);
  }
}
