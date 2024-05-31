import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:student_management_app/domain/usecases/currentuid_usecase.dart';
import 'package:student_management_app/domain/usecases/is_signedin_usecase.dart';
import 'package:student_management_app/domain/usecases/is_verified_usecase.dart';

import '../../../domain/usecases/signout_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUsecase signOutUsecase;
  final CurrentUidUsecase getCurrentUidUsecase;
  final IsSignedInUsecase isSignInUsecase;
  final IsVerifiedUsecase isVerifiedUsecase;

  AuthCubit({
    required this.signOutUsecase,
    required this.getCurrentUidUsecase,
    required this.isSignInUsecase,
    required this.isVerifiedUsecase,
  }) : super(AuthInitial());

  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUsecase.call();

      if (isSignIn == true) {
        final uid = await getCurrentUidUsecase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(const NotAuthenticated());
      }
    } catch (_) {
      emit(const NotAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUsecase.call();
      final checkVerification = await isVerifiedUsecase.call();

      if (checkVerification) {
        emit(Authenticated(uid: uid));
      } else {
        emit(const NotVerified());
      }
    } catch (_) {
      emit(const NotAuthenticated());
      emit(const NotVerified());
    }
  }

  Future<void> logout() async {
    try {
      await signOutUsecase.call();
      emit(const NotAuthenticated());
    } catch (_) {
      emit(const NotAuthenticated());
    }
  }

  Future<void> verify() async {
    try {
      await isVerifiedUsecase.call();
      emit(const Verified());
    } catch (_) {
      emit(const NotVerified());
    }
  }
}
