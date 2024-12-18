// ignore_for_file: depend_on_referenced_packages

import 'package:dartz/dartz.dart';

import 'package:studentscheduletracker/features/class_schedule_management/domain/entities/class_schedule.dart';
import 'package:studentscheduletracker/core/errors/failure.dart';

abstract class ClassScheduleRepository {
  Future<Either<Failure, Unit>> createClassSchedule(ClassSchedule schedule);
  Future<Either<Failure, List<ClassSchedule>>> getClassSchedules();
  Future<Either<Failure, ClassSchedule>> getClassScheduleById(String id);
  Future<Either<Failure, Unit>> updateClassSchedule(ClassSchedule schedule);
  Future<Either<Failure, Unit>> deleteClassSchedule(String id);
}
