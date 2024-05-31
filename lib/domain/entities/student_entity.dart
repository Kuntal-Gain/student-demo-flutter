import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? studentid;
  final String? name;
  final Timestamp? dob;
  final String? gender;

  const StudentEntity({
    this.studentid,
    this.name,
    this.dob,
    this.gender,
  });

  @override
  List<Object?> get props => [studentid, name, dob, gender];
}
