import 'package:student_management_app/domain/repo/firebase_repository.dart';

class IsVerifiedUsecase {
  final FirebaseRepository repository;

  IsVerifiedUsecase({required this.repository});

  Future<bool> call() async {
    return repository.isVerified();
  }
}
