part of 'student_cubit.dart';

sealed class StudentState extends Equatable {
  const StudentState();
}

final class StudentInitial extends StudentState {
  @override
  List<Object> get props => [];
}

class StudentLoading extends StudentState {
  @override
  List<Object?> get props => [];
}

class StudentLoaded extends StudentState {
  final List<StudentEntity> students;

  const StudentLoaded({required this.students});

  @override
  List<Object?> get props => [students];
}

class StudentFailure extends StudentState {
  final String msg;

  const StudentFailure({required this.msg});

  @override
  List<Object?> get props => [msg];
}
