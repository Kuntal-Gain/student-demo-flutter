import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_management_app/domain/entities/user_entity.dart';

import '../../../domain/usecases/signin_usecase.dart';
import '../../../domain/usecases/signup_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;

  CredentialCubit({required this.signInUsecase, required this.signUpUsecase})
      : super(CredentialInitial());

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(CredentialLoading());
    try {
      await signInUsecase.call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException {
      emit(const CredentialFailure(message: 'No Internet Connection'));
    } catch (err) {
      emit(CredentialFailure(message: err.toString()));
    }
  }

  Future<void> signUpUser({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUsecase.call(user);
      emit(CredentialSuccess());
    } on SocketException {
      emit(const CredentialFailure(message: 'No Internet Connection'));
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use') {
        emit(const CredentialFailure(message: 'User Already Exist'));
      } else if (err.code == 'weak-password') {
        emit(const CredentialFailure(message: 'Password is Weak'));
      }
    }
  }
}
