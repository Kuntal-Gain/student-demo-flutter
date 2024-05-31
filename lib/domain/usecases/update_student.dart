import 'package:student_management_app/domain/entities/student_entity.dart';
import 'package:student_management_app/domain/repo/firebase_repository.dart';

class UpdateStudentUsecase {
  final FirebaseRepository repository;

  UpdateStudentUsecase({required this.repository});

  Future<void> call(StudentEntity student) {
    return repository.updateStudent(student);
  }
}
