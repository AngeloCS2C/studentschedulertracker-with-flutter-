import 'package:studentscheduletracker/features/class_schedule_management/domain/entities/class_schedule.dart';

abstract class ClassScheduleRemoteDataSource {
  Future<void> createClassSchedule(ClassSchedule schedule);
  Future<List<ClassSchedule>> getAllClassSchedules();
  Future<ClassSchedule> getClassScheduleById(String id);
  Future<void> updateClassSchedule(
      ClassSchedule schedule, Map<String, dynamic> map);
  Future<void> deleteClassSchedule(String id);
}
