import 'package:student_management_app/domain/entities/user_entity.dart';
import 'package:student_management_app/domain/repo/firebase_repository.dart';

class SignInUsecase {
  final FirebaseRepository repository;

  SignInUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signInUser(user);
  }
}
