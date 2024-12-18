part of 'assignment_cubit.dart';

abstract class AssignmentState extends Equatable {
  const AssignmentState();

  @override
  List<Object?> get props => [];
}

class AssignmentInitial extends AssignmentState {}

class AssignmentLoading extends AssignmentState {}

class AssignmentLoaded extends AssignmentState {
  final List<Assignment> assignments;

  const AssignmentLoaded(this.assignments);

  @override
  List<Object?> get props => [assignments];
}

class SingleAssignmentLoaded extends AssignmentState {
  final Assignment assignment;

  const SingleAssignmentLoaded(this.assignment);

  @override
  List<Object?> get props => [assignment];
}

class AssignmentAdded extends AssignmentState {}

class AssignmentUpdated extends AssignmentState {}

class AssignmentDeleted extends AssignmentState {}

class AssignmentError extends AssignmentState {
  final String message;

  const AssignmentError(this.message);

  @override
  List<Object?> get props => [message];
}
