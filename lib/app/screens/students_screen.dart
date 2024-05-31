import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management_app/app/cubit/student/student_cubit.dart';
import 'package:student_management_app/app/widget/student_tile.dart';

import 'package:student_management_app/dependency_injection.dart' as di;

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<StudentCubit>()..getStudents(),
      child: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading || state is StudentInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentLoaded) {
            final students = state.students;

            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (ctx, idx) {
                return studentTile(students[idx], context);
              },
            );
          } else if (state is StudentFailure) {
            return Text('Error : ${state.msg}');
          } else {
            if (kDebugMode) {
              print(state);
            }

            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_alt),
                Text('NO DATA'),
              ],
            );
          }
        },
      ),
    );
  }
}
