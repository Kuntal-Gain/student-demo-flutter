import 'package:student_management_app/domain/entities/student_entity.dart';
import 'package:student_management_app/domain/repo/firebase_repository.dart';

class GetStudentUsecase {
  final FirebaseRepository repository;

  GetStudentUsecase({required this.repository});

  Stream<List<StudentEntity>> call() {
    return repository.getStudent();
  }
}
