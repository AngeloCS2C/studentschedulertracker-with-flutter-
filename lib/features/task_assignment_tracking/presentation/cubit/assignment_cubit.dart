import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentscheduletracker/features/task_assignment_tracking/domain/entities/class_assignment.dart';
import 'package:studentscheduletracker/features/task_assignment_tracking/domain/repositories/class_assignment_repo.dart';

part 'assignment_state.dart';

class AssignmentCubit extends Cubit<AssignmentState> {
  final AssignmentRepository repository;

  AssignmentCubit({required this.repository}) : super(AssignmentInitial());

  /// Load all assignments
  Future<void> loadAssignments() async {
    emit(AssignmentLoading());
    try {
      final result = await repository.getAllAssignments();
      result.fold(
        (failure) => emit(AssignmentError(failure.message)),
        (assignments) => emit(AssignmentLoaded(assignments)),
      );
    } catch (e) {
      emit(AssignmentError('Failed to load assignments: $e'));
    }
  }

  /// Add a new assignment
  Future<void> addAssignment(Assignment assignment) async {
    emit(AssignmentLoading());
    try {
      final result = await repository.createAssignment(assignment);
      result.fold(
        (failure) => emit(AssignmentError(failure.message)),
        (_) async {
          await loadAssignments(); // Refresh the list after addition
        },
      );
    } catch (e) {
      emit(AssignmentError('Failed to add assignment: $e'));
    }
  }

  /// Update an existing assignment
  Future<void> updateAssignment(
      Assignment assignment, Map<String, Object> updates) async {
    emit(AssignmentLoading());
    try {
      final result = await repository.updateAssignment(assignment, updates);
      result.fold(
        (failure) => emit(AssignmentError(failure.message)),
        (_) async {
          await loadAssignments(); // Refresh the list after update
        },
      );
    } catch (e) {
      emit(AssignmentError('Failed to update assignment: $e'));
    }
  }

  /// Delete an assignment by ID
  Future<void> deleteAssignment(String id) async {
    emit(AssignmentLoading());
    try {
      final result = await repository.deleteAssignment(id);
      result.fold(
        (failure) => emit(AssignmentError(failure.message)),
        (_) async {
          await loadAssignments(); // Refresh the list after deletion
        },
      );
    } catch (e) {
      emit(AssignmentError('Failed to delete assignment: $e'));
    }
  }
}
