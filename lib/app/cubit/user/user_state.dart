part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final UserEntity user;

  const UserLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class UserFailure extends UserState {
  final String msg;
  const UserFailure({required this.msg});
  @override
  List<Object> get props => [msg];
}
