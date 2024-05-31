import 'package:student_management_app/domain/entities/student_entity.dart';
import 'package:student_management_app/domain/entities/user_entity.dart';

abstract class RemoteDatasource {
  // credential
  Future<void> signUpUser(UserEntity user);
  Future<void> signInUser(UserEntity user);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<bool> isVerified();

  // User
  Future<void> createUser(UserEntity user);
  Future<String> getCurrentUid();
  Stream<List<UserEntity?>> getCurrentUser(String uid);

  // DB
  Future<void> addStudent(StudentEntity student);
  Stream<List<StudentEntity>> getStudent();
  Future<void> updateStudent(StudentEntity student);
}
