import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentscheduletracker/features/task_assignment_tracking/data/models/assignment_model.dart';
import 'package:studentscheduletracker/features/task_assignment_tracking/presentation/cubit/assignment_cubit.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  void _addNewAssignment(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priorityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Assignment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: priorityController,
                  decoration: const InputDecoration(labelText: 'Priority'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newAssignment = AssignmentModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  dueDate: DateTime.now().add(const Duration(days: 7)),
                  priority: priorityController.text.trim().isEmpty
                      ? 'Medium'
                      : priorityController.text.trim(),
                  isCompleted: false,
                );
                context.read<AssignmentCubit>().addAssignment(newAssignment);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<AssignmentCubit>().loadAssignments();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
      body: BlocBuilder<AssignmentCubit, AssignmentState>(
        builder: (context, state) {
          if (state is AssignmentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AssignmentError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is AssignmentLoaded) {
            if (state.assignments.isEmpty) {
              return const Center(
                child: Text(
                    "No assignments available. Add one using the + button."),
              );
            }
            return ListView.builder(
              itemCount: state.assignments.length,
              itemBuilder: (context, index) {
                final assignment = state.assignments[index];
                return ListTile(
                  title: Text(assignment.title),
                  subtitle: Text(
                      "${assignment.description} | Priority: ${assignment.priority}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: assignment.isCompleted,
                        onChanged: (value) {
                          final updatedMap =
                              Map<String, Object>.from(assignment.toMap());
                          context.read<AssignmentCubit>().updateAssignment(
                                assignment.copyWith(
                                    isCompleted: value ?? false),
                                updatedMap,
                              );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          final assignmentModel = AssignmentModel(
                            id: assignment.id,
                            title: assignment.title,
                            description: assignment.description,
                            dueDate: assignment.dueDate,
                            priority: assignment.priority,
                            isCompleted: assignment.isCompleted,
                          );
                          _editAssignment(context, assignmentModel);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context
                              .read<AssignmentCubit>()
                              .deleteAssignment(assignment.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No assignments available."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewAssignment(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _editAssignment(BuildContext context, AssignmentModel assignment) {
    final titleController = TextEditingController(text: assignment.title);
    final descriptionController =
        TextEditingController(text: assignment.description);
    final priorityController = TextEditingController(text: assignment.priority);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Assignment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: priorityController,
                  decoration: const InputDecoration(labelText: 'Priority'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedAssignment = assignment.copyWith(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  priority: priorityController.text.trim(),
                );
                final updatedMap =
                    Map<String, Object>.from(updatedAssignment.toMap());
                context.read<AssignmentCubit>().updateAssignment(
                      updatedAssignment,
                      updatedMap,
                    );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
