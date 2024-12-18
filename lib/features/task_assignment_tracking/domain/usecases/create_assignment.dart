import '../entities/class_assignment.dart';
import '../repositories/class_assignment_repo.dart';

class CreateAssignment {
  final AssignmentRepository repository;

  CreateAssignment({required this.repository});

  Future<void> call(Assignment assignment) {
    return repository.createAssignment(assignment);
  }
}
