import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/assignment_model.dart';

class AssignmentRemoteDataSourceImpl {
  final FirebaseFirestore firestore;

  AssignmentRemoteDataSourceImpl(this.firestore);

  // Add a new Assignment
  Future<void> addAssignment(AssignmentModel assignment) async {
    try {
      await firestore
          .collection('assignments')
          .doc(assignment.id)
          .set(assignment.toJson());
    } catch (e) {
      throw Exception('Error adding assignment: $e');
    }
  }

  // Fetch all Assignments
  Future<List<AssignmentModel>> fetchAllAssignments() async {
    try {
      final querySnapshot = await firestore.collection('assignments').get();
      if (querySnapshot.docs.isEmpty) {
        return []; // Return empty list if no assignments found
      }
      return querySnapshot.docs.map((doc) {
        return AssignmentModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Error fetching assignments: $e');
    }
  }

  // Fetch a single Assignment by ID
  Future<AssignmentModel> fetchAssignmentById(String id) async {
    try {
      final doc = await firestore.collection('assignments').doc(id).get();
      if (!doc.exists) {
        throw Exception('Assignment not found');
      }
      return AssignmentModel.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Error fetching assignment by ID: $e');
    }
  }

  // Update an existing Assignment
  Future<void> updateAssignment(String id, Map<String, dynamic> updates) async {
    try {
      await firestore.collection('assignments').doc(id).update(updates);
    } catch (e) {
      throw Exception('Error updating assignment: $e');
    }
  }

  // Delete an Assignment
  Future<void> deleteAssignment(String id) async {
    try {
      await firestore.collection('assignments').doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting assignment: $e');
    }
  }
}
