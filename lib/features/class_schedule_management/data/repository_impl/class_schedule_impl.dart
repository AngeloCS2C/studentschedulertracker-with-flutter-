// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:studentscheduletracker/core/errors/failure.dart';
import 'package:studentscheduletracker/features/class_schedule_management/domain/repositories/class_schedule_repo.dart';
import '../../domain/entities/class_schedule.dart';

class ClassScheduleRemoteDataSourceImpl implements ClassScheduleRepository {
  final FirebaseFirestore firestore;

  ClassScheduleRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failure, Unit>> createClassSchedule(
      ClassSchedule schedule) async {
    try {
      await firestore
          .collection('class_schedules')
          .doc(schedule.id)
          .set(schedule.toMap());
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ClassSchedule>>> getClassSchedules() async {
    try {
      final snapshot = await firestore.collection('class_schedules').get();
      final schedules = snapshot.docs
          .map((doc) => ClassSchedule.fromMap(doc.id, doc.data()))
          .toList();
      return Right(schedules);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClassSchedule>> getClassScheduleById(String id) async {
    try {
      final doc = await firestore.collection('class_schedules').doc(id).get();
      if (!doc.exists) {
        return const Left(Failure(message: 'Class schedule not found.'));
      }
      final schedule = ClassSchedule.fromMap(doc.id, doc.data()!);
      return Right(schedule);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateClassSchedule(
      ClassSchedule schedule) async {
    try {
      await firestore
          .collection('class_schedules')
          .doc(schedule.id)
          .update(schedule.toMap());
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteClassSchedule(String id) async {
    try {
      await firestore.collection('class_schedules').doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
