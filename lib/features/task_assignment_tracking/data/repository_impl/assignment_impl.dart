// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentscheduletracker/core/errors/failure.dart';
import 'package:studentscheduletracker/features/task_assignment_tracking/domain/repositories/class_assignment_repo.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/class_assignment.dart';
import '../models/assignment_model.dart';

class AssignmentRemoteDataSourceImpl implements AssignmentRepository {
  final FirebaseFirestore firestore;

  AssignmentRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failure, Unit>> createAssignment(Assignment assignment) async {
    try {
      final model = AssignmentModel(
        id: assignment.id,
        title: assignment.title,
        description: assignment.description,
        dueDate: assignment.dueDate,
        priority: assignment.priority,
        isCompleted: assignment.isCompleted,
      );
      await firestore
          .collection('assignments')
          .doc(model.id)
          .set(model.toJson());
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AssignmentModel>> getAssignmentById(String id) async {
    try {
      final doc = await firestore.collection('assignments').doc(id).get();
      if (!doc.exists) {
        return const Left(Failure(message: 'Assignment not found'));
      }
      final data = doc.data()!;
      final assignmentModel = AssignmentModel.fromJson(data);
      return Right(assignmentModel);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AssignmentModel>> updateAssignment(
      Assignment assignment, Map<String, Object> json) async {
    try {
      // Update the assignment in Firestore
      await firestore.collection('assignments').doc(assignment.id).update(json);

      // Retrieve the updated assignment
      final updatedDoc =
          await firestore.collection('assignments').doc(assignment.id).get();
      if (!updatedDoc.exists) {
        return const Left(Failure(message: 'Updated assignment not found'));
      }

      final updatedData = updatedDoc.data()!;
      final updatedAssignment = AssignmentModel.fromJson(updatedData);
      return Right(updatedAssignment);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteAssignment(String id) async {
    try {
      await firestore.collection('assignments').doc(id).delete();
      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AssignmentModel>>> getAllAssignments() async {
    try {
      final snapshot = await firestore.collection('assignments').get();
      final assignments = snapshot.docs.map((doc) {
        final data = doc.data();
        return AssignmentModel.fromJson(data);
      }).toList();
      return Right(assignments);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
