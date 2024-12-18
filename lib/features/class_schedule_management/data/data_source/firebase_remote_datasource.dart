import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/class_schedule.dart';

class ClassScheduleRemoteDataSource {
  final FirebaseFirestore firestore;

  ClassScheduleRemoteDataSource(this.firestore);

  Future<List<ClassSchedule>> getAllClassSchedules() async {
    final snapshot = await firestore.collection('class_schedules').get();
    return snapshot.docs
        .map((doc) => ClassSchedule.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<ClassSchedule> getClassScheduleById(String id) async {
    final doc = await firestore.collection('class_schedules').doc(id).get();
    if (!doc.exists) throw Exception('Class schedule not found');
    return ClassSchedule.fromMap(doc.id, doc.data()!);
  }

  Future<void> createClassSchedule(ClassSchedule schedule) async {
    await firestore
        .collection('class_schedules')
        .doc(schedule.id)
        .set(schedule.toMap());
  }

  Future<void> updateClassSchedule(
      String id, Map<String, dynamic> updates) async {
    await firestore.collection('class_schedules').doc(id).update(updates);
  }

  Future<void> deleteClassSchedule(String id) async {
    await firestore.collection('class_schedules').doc(id).delete();
  }
}
