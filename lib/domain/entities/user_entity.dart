import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final String? password;

  const UserEntity({
    this.uid,
    this.email,
    this.name,
    this.password,
  });

  @override
  List<Object?> get props => [uid, email, name, password];
}
