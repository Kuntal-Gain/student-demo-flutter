// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_app/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  // ignore: duplicate_ignore
  // ignore: annotate_overrides
  final String? uid;
  final String? name;
  final String? email;
  final String? password;

  const UserModel({
    this.uid,
    this.email,
    this.name,
    this.password,
  }) : super(
          email: email,
          uid: uid,
          name: name,
          password: password,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var ss = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: ss['uid'],
      email: ss['email'],
      name: ss['name'],
      password: ss['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "name": name,
        "password": password,
      };
}
