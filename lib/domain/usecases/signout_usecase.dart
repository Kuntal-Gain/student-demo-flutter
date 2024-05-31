import 'package:student_management_app/domain/repo/firebase_repository.dart';

class SignOutUsecase {
  final FirebaseRepository repository;

  SignOutUsecase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}
