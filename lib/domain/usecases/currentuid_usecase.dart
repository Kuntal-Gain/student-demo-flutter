// currentuid_usecase.dart
import 'package:student_management_app/domain/repo/firebase_repository.dart';

class CurrentUidUsecase {
  final FirebaseRepository repository;

  CurrentUidUsecase({required this.repository});

  Future<String> call() async {
    return await repository.getCurrentUid();
  }
}
