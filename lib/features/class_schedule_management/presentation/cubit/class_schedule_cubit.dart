import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentscheduletracker/features/class_schedule_management/data/models/class_schedule_model.dart';
import 'package:studentscheduletracker/features/class_schedule_management/domain/entities/class_schedule.dart';
import 'package:studentscheduletracker/features/class_schedule_management/domain/repositories/class_schedule_repo.dart';

part 'class_schedule_state.dart';

class ClassScheduleCubit extends Cubit<ClassScheduleState> {
  final ClassScheduleRepository repository;

  ClassScheduleCubit({required this.repository})
      : super(ClassScheduleInitial());

  /// Fetch all class schedules
  Future<void> fetchClassSchedules() async {
    emit(ClassScheduleLoading());
    try {
      final result = await repository.getClassSchedules();
      result.fold(
        (failure) => emit(ClassScheduleError(failure.message)),
        (schedules) => emit(ClassScheduleLoaded(schedules)),
      );
    } catch (e) {
      emit(ClassScheduleError('Unexpected error: $e'));
    }
  }

  /// Add a new class schedule and display it immediately
  Future<void> addSchedule(ClassScheduleModel newSchedule) async {
    emit(ClassScheduleLoading());
    try {
      final result = await repository.createClassSchedule(newSchedule);
      result.fold(
        (failure) => emit(ClassScheduleError(failure.message)),
        (_) async {
          // After successful addition, immediately fetch and display updated schedules
          await fetchClassSchedules();
          // No separate "Added" state is emitted, so the UI sees the updated list directly.
        },
      );
    } catch (e) {
      emit(ClassScheduleError('Failed to add schedule: $e'));
    }
  }

  /// Update an existing class schedule
  Future<void> updateSchedule(ClassScheduleModel updatedSchedule) async {
    emit(ClassScheduleLoading());
    try {
      final result = await repository.updateClassSchedule(updatedSchedule);
      result.fold(
        (failure) => emit(ClassScheduleError(failure.message)),
        (_) async {
          await fetchClassSchedules(); // Refresh schedules after update
        },
      );
    } catch (e) {
      emit(ClassScheduleError('Failed to update schedule: $e'));
    }
  }

  /// Delete a class schedule by ID
  Future<void> deleteSchedule(String id) async {
    emit(ClassScheduleLoading());
    try {
      final result = await repository.deleteClassSchedule(id);
      result.fold(
        (failure) => emit(ClassScheduleError(failure.message)),
        (_) async {
          await fetchClassSchedules(); // Refresh schedules after deletion
        },
      );
    } catch (e) {
      emit(ClassScheduleError('Failed to delete schedule: $e'));
    }
  }

  /// Fetch a single class schedule by ID
  Future<void> getClassScheduleById(String id) async {
    emit(ClassScheduleLoading());
    try {
      final result = await repository.getClassScheduleById(id);
      result.fold(
        (failure) => emit(ClassScheduleError(failure.message)),
        (schedule) => emit(SingleClassScheduleLoaded(schedule)),
      );
    } catch (e) {
      emit(ClassScheduleError('Failed to fetch schedule: $e'));
    }
  }
}
