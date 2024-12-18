import '../repositories/class_assignment_repo.dart';

class DeleteAssignment {
  final AssignmentRepository repository;

  DeleteAssignment({required this.repository});

  Future<void> call(String id) {
    return repository.deleteAssignment(id);
  }
}
