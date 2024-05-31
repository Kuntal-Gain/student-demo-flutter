import 'package:student_management_app/domain/entities/student_entity.dart';
import 'package:student_management_app/domain/repo/firebase_repository.dart';

class AddStudentUsecase {
  final FirebaseRepository repository;

  AddStudentUsecase({required this.repository});

  Future<void> call(StudentEntity student) {
    return repository.addStudent(student);
  }
}
