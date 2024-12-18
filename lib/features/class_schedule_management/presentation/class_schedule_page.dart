import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentscheduletracker/features/class_schedule_management/data/models/class_schedule_model.dart';
import 'package:studentscheduletracker/features/class_schedule_management/presentation/cubit/class_schedule_cubit.dart';

class ClassSchedulePage extends StatelessWidget {
  const ClassSchedulePage({super.key});

  void _addNewSchedule(BuildContext context) {
    final courseNameController = TextEditingController();
    final instructorController = TextEditingController();
    final timeController = TextEditingController();
    final locationController = TextEditingController();
    final daysOfWeekController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Schedule'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: courseNameController,
                  decoration: const InputDecoration(labelText: 'Course Name'),
                ),
                TextField(
                  controller: instructorController,
                  decoration: const InputDecoration(labelText: 'Instructor'),
                ),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: 'Time'),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                TextField(
                  controller: daysOfWeekController,
                  decoration: const InputDecoration(
                      labelText: 'Days (comma-separated)'),
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
                final newSchedule = ClassScheduleModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  courseName: courseNameController.text.trim(),
                  instructor: instructorController.text.trim(),
                  time: timeController.text.trim(),
                  location: locationController.text.trim(),
                  daysOfWeek: daysOfWeekController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList(),
                );
                context.read<ClassScheduleCubit>().addSchedule(newSchedule);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editSchedule(BuildContext context, ClassScheduleModel schedule) {
    final courseNameController =
        TextEditingController(text: schedule.courseName);
    final instructorController =
        TextEditingController(text: schedule.instructor);
    final timeController = TextEditingController(text: schedule.time);
    final locationController = TextEditingController(text: schedule.location);
    final daysOfWeekController =
        TextEditingController(text: schedule.daysOfWeek.join(', '));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Schedule'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: courseNameController,
                  decoration: const InputDecoration(labelText: 'Course Name'),
                ),
                TextField(
                  controller: instructorController,
                  decoration: const InputDecoration(labelText: 'Instructor'),
                ),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: 'Time'),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                TextField(
                  controller: daysOfWeekController,
                  decoration: const InputDecoration(
                      labelText: 'Days (comma-separated)'),
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
                final updatedSchedule = schedule.copyWith(
                  courseName: courseNameController.text.trim(),
                  instructor: instructorController.text.trim(),
                  time: timeController.text.trim(),
                  location: locationController.text.trim(),
                  daysOfWeek: daysOfWeekController.text
                      .split(',')
                      .map((e) => e.trim())
                      .toList(),
                );
                context
                    .read<ClassScheduleCubit>()
                    .updateSchedule(updatedSchedule);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<ClassScheduleCubit>().fetchClassSchedules();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Schedule"),
      ),
      body: BlocBuilder<ClassScheduleCubit, ClassScheduleState>(
        builder: (context, state) {
          if (state is ClassScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClassScheduleError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is ClassScheduleLoaded) {
            if (state.schedules.isEmpty) {
              return const Center(
                child:
                    Text("No schedules available. Add one using the + button."),
              );
            }
            return ListView.builder(
              itemCount: state.schedules.length,
              itemBuilder: (context, index) {
                final schedule = state.schedules[index];
                return ListTile(
                  title: Text(schedule.courseName),
                  subtitle: Text("${schedule.time} | ${schedule.location}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          final scheduleModel = ClassScheduleModel(
                            id: schedule.id,
                            courseName: schedule.courseName,
                            instructor: schedule.instructor,
                            time: schedule.time,
                            location: schedule.location,
                            daysOfWeek: schedule.daysOfWeek,
                          );
                          _editSchedule(context, scheduleModel);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => context
                            .read<ClassScheduleCubit>()
                            .deleteSchedule(schedule.id),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No schedules available."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewSchedule(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
