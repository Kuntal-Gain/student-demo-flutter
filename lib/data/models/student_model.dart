// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management_app/domain/entities/student_entity.dart';

class StudentModel extends StudentEntity {
  // ignore: duplicate_ignore
  // ignore: annotate_overrides
  final String? studentid;
  final String? name;
  final Timestamp? dob;
  final String? gender;

  const StudentModel({
    this.studentid,
    this.name,
    this.dob,
    this.gender,
  }) : super(
          studentid: studentid,
          name: name,
          dob: dob,
          gender: gender,
        );

  factory StudentModel.fromSnapshot(DocumentSnapshot snap) {
    var ss = snap.data() as Map<String, dynamic>;

    return StudentModel(
      studentid: ss['studentid'],
      name: ss['name'],
      dob: ss['dob'],
      gender: ss['gender'],
    );
  }

  Map<String, dynamic> toJson() => {
        "studentid": studentid,
        "name": name,
        "dob": dob,
        "gender": gender,
      };
}
