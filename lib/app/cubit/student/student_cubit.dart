import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management_app/domain/usecases/add_student_usecase.dart';
import 'package:student_management_app/domain/usecases/get_students_usecase.dart';
import 'package:student_management_app/domain/usecases/get_user_usecase.dart';
import 'package:student_management_app/domain/usecases/update_student.dart';

import '../../../domain/entities/student_entity.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final GetStudentUsecase getStudentsUsecase;
  final AddStudentUsecase addStudentUsecase;
  final UpdateStudentUsecase updateStudentUsecase;

  StudentCubit({
    required this.getCurrentUserUsecase,
    required this.getStudentsUsecase,
    required this.addStudentUsecase,
    required this.updateStudentUsecase,
  }) : super(StudentInitial());

  Future<void> getStudents() async {
    emit(StudentLoading());
    try {
      final streamResponse = getStudentsUsecase.call();
      streamResponse.listen((student) {
        emit(StudentLoaded(students: student));
      });
    } on SocketException catch (_) {
      emit(const StudentFailure(msg: ''));
    } catch (_) {
      emit(const StudentFailure(msg: ''));
    }
  }

  Future<void> addStudent(StudentEntity student) async {
    try {
      await addStudentUsecase.call(student);
    } on SocketException catch (_) {
      emit(const StudentFailure(msg: ''));
    } catch (e) {
      emit(StudentFailure(msg: e.toString()));
    }
  }

  Future<void> updateStudent(StudentEntity student) async {
    try {
      await updateStudentUsecase.call(student);
    } on SocketException catch (_) {
      emit(const StudentFailure(msg: ''));
    } catch (e) {
      emit(StudentFailure(msg: e.toString()));
    }
  }
}
