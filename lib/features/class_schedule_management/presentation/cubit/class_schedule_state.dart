part of 'class_schedule_cubit.dart';

abstract class ClassScheduleState extends Equatable {
  const ClassScheduleState();

  @override
  List<Object?> get props => [];
}

class ClassScheduleInitial extends ClassScheduleState {}

class ClassScheduleLoading extends ClassScheduleState {}

class ClassScheduleLoaded extends ClassScheduleState {
  final List<ClassSchedule> schedules;

  const ClassScheduleLoaded(this.schedules);

  @override
  List<Object?> get props => [schedules];
}

class SingleClassScheduleLoaded extends ClassScheduleState {
  final ClassSchedule schedule;

  const SingleClassScheduleLoaded(this.schedule);

  @override
  List<Object?> get props => [schedule];
}

class ClassScheduleAdded extends ClassScheduleState {}

class ClassScheduleUpdated extends ClassScheduleState {}

class ClassScheduleDeleted extends ClassScheduleState {}

class ClassScheduleError extends ClassScheduleState {
  final String message;

  const ClassScheduleError(this.message);

  @override
  List<Object?> get props => [message];
}
