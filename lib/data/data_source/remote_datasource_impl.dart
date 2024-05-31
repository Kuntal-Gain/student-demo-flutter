import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:student_management_app/app/utils/generated_ids.dart';
import 'package:student_management_app/data/data_source/remote_datasource.dart';
import 'package:student_management_app/data/models/student_model.dart';
import 'package:student_management_app/data/models/user_model.dart';
import 'package:student_management_app/domain/entities/student_entity.dart';
import 'package:student_management_app/domain/entities/user_entity.dart';

class RemoteDatasourceImpl implements RemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  RemoteDatasourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<void> addStudent(StudentEntity student) async {
    final uid = await getCurrentUid();

    final studentCollection =
        firebaseFirestore.collection('user').doc(uid).collection('students');

    final id = generateId();

    studentCollection.doc(id).get().then((newStudent) {
      final newUser = StudentModel(
        studentid: id,
        name: student.name,
        dob: student.dob,
        gender: student.gender,
      ).toJson();

      if (!newStudent.exists) {
        studentCollection.doc(id).set(newUser);
      } else {
        studentCollection.doc(id).update(newUser);
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
    });
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity?>> getCurrentUser(String uid) {
    final userCollection = firebaseFirestore
        .collection('user')
        .where("uid", isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<StudentEntity>> getStudent() {
    return getCurrentUid().asStream().asyncExpand((uid) {
      final studentCollection = firebaseFirestore
          .collection('user')
          .doc(uid)
          .collection('students')
          .orderBy("name", descending: true);

      return studentCollection.snapshots().map((query) => query.docs
          .map((e) => StudentModel.fromSnapshot(e) as StudentEntity)
          .toList());
    });
  }

  @override
  Future<bool> isSignedIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('User Not Found');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password');
        }
      } else {
        if (kDebugMode) {
          print(e.code);
        }
      }
    }
  }

  @override
  Future<void> signOut() async => await firebaseAuth.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth
            .createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        )
            .then((value) async {
          if (value.user?.uid != null) {
            await createUser(user);
          }
        });

        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('User Already exists');
        }
      } else {
        if (kDebugMode) {
          print('Error 404');
        }
      }
    }
  }

  @override
  Future<void> updateStudent(StudentEntity student) async {
    final uid = await getCurrentUid();

    final studentCollection =
        firebaseFirestore.collection('user').doc(uid).collection('students');

    Map<String, dynamic> information = {};

    if (student.name != "" && student.name != null) {
      information["name"] = student.name!;
    }
    if (student.dob != null) {
      information["dob"] = student.dob;
    }
    if (student.gender != "" && student.gender != null) {
      information["gender"] = student.gender;
    }

    studentCollection.doc(student.studentid).update(information);
  }

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection('user');

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((newDoc) {
      final newUser = UserModel(
        uid: uid,
        email: user.email,
        name: user.name,
        password: user.password,
      ).toJson();

      if (!newDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
    });
  }

  @override
  Future<bool> isVerified() async =>
      firebaseAuth.currentUser?.emailVerified != null;
}
