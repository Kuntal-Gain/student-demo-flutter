import 'package:student_management_app/domain/entities/user_entity.dart';
import 'package:student_management_app/domain/repo/firebase_repository.dart';

class GetCurrentUserUsecase {
  final FirebaseRepository repository;

  GetCurrentUserUsecase({required this.repository});

  Stream<List<UserEntity?>> call(String uid) {
    return repository.getCurrentUser(uid);
  }
}
