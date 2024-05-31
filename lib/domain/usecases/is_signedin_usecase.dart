import 'package:student_management_app/domain/repo/firebase_repository.dart';

class IsSignedInUsecase {
  final FirebaseRepository repository;

  IsSignedInUsecase({required this.repository});

  Future<bool> call() async {
    return repository.isSignedIn();
  }
}
