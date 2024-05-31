import 'package:student_management_app/domain/entities/user_entity.dart';
import 'package:student_management_app/domain/repo/firebase_repository.dart';

class CreateUserUsecase {
  final FirebaseRepository repository;

  CreateUserUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}
