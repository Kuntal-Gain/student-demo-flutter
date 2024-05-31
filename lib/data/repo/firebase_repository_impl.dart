import 'package:student_management_app/data/data_source/remote_datasource.dart';
import 'package:student_management_app/domain/entities/student_entity.dart';

import 'package:student_management_app/domain/entities/user_entity.dart';

import '../../domain/repo/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final RemoteDatasource remoteDatasource;

  FirebaseRepositoryImpl({required this.remoteDatasource});

  @override
  Future<void> addStudent(StudentEntity student) =>
      remoteDatasource.addStudent(student);

  @override
  Future<String> getCurrentUid() => remoteDatasource.getCurrentUid();

  @override
  Stream<List<StudentEntity>> getStudent() => remoteDatasource.getStudent();

  @override
  Future<void> signInUser(UserEntity user) => remoteDatasource.signInUser(user);

  @override
  Future<void> signOut() => remoteDatasource.signOut();

  @override
  Future<void> signUpUser(UserEntity user) => remoteDatasource.signUpUser(user);

  @override
  Future<void> updateStudent(StudentEntity student) =>
      remoteDatasource.updateStudent(student);

  @override
  Stream<List<UserEntity?>> getCurrentUser(String uid) =>
      remoteDatasource.getCurrentUser(uid);

  @override
  Future<bool> isSignedIn() => remoteDatasource.isSignedIn();

  @override
  Future<void> createUser(UserEntity user) async {
    remoteDatasource.createUser(user);
  }

  @override
  Future<bool> isVerified() async => remoteDatasource.isVerified();
}
