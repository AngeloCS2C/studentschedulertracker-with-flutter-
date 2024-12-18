// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentscheduletracker/features/task_assignment_tracking/data/repository_impl/assignment_impl.dart';
import 'features/class_schedule_management/domain/repositories/class_schedule_repo.dart';
import 'firebase_options.dart';

// Import repositories and cubits:
import 'features/class_schedule_management/data/repository_impl/class_schedule_impl.dart';
import 'features/task_assignment_tracking/domain/repositories/class_assignment_repo.dart';
import 'features/class_schedule_management/presentation/cubit/class_schedule_cubit.dart';
import 'features/task_assignment_tracking/presentation/cubit/assignment_cubit.dart';

// Import main screens
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  // Add mock data and fetch data for testing

  await fetchFirestoreData(firestore);

  // Create the remote data sources
  final classScheduleRemoteDataSource =
      ClassScheduleRemoteDataSourceImpl(firestore);

  // Create the repositories
  // Assuming ClassScheduleRepositoryImpl takes a data source as a constructor param
  final classScheduleRepository = classScheduleRemoteDataSource;

  // Assuming AssignmentRemoteDataSourceImpl implements AssignmentRepository directly
  final assignmentRepository = AssignmentRemoteDataSourceImpl(firestore);

  runApp(MyApp(
    classScheduleRepository: classScheduleRepository,
    assignmentRepository: assignmentRepository,
  ));
}

/// Adds mock data to Firestore collections for testing purposes.

/// Fetches and prints Firestore data for debugging.
Future<void> fetchFirestoreData(FirebaseFirestore firestore) async {
  try {
    // Fetch Class Schedules
    final classSchedulesSnapshot =
        await firestore.collection('class_schedules').get();
    print('Class Schedules:');
    for (var doc in classSchedulesSnapshot.docs) {
      print(doc.data());
    }

    // Fetch Assignments
    final assignmentsSnapshot = await firestore.collection('assignments').get();
    print('Assignments:');
    for (var doc in assignmentsSnapshot.docs) {
      print(doc.data());
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

class MyApp extends StatelessWidget {
  final ClassScheduleRepository classScheduleRepository;
  final AssignmentRepository assignmentRepository;

  const MyApp({
    super.key,
    required this.classScheduleRepository,
    required this.assignmentRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              ClassScheduleCubit(repository: classScheduleRepository),
        ),
        BlocProvider(
          create: (_) => AssignmentCubit(repository: assignmentRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Student Schedule Tracker',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
