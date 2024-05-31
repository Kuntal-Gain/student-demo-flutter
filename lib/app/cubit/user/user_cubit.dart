import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management_app/domain/usecases/get_user_usecase.dart';

import '../../../domain/entities/user_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  UserCubit({required this.getCurrentUserUsecase}) : super(UserInitial());

  Future<void> getUsers({required String uid}) async {
    emit(UserLoading());
    try {
      final streamResponse = getCurrentUserUsecase.call(uid);

      // Listen to the stream response
      streamResponse.listen((users) {
        // Check if users list is not empty
        if (users.isNotEmpty) {
          emit(UserLoaded(user: users.first!));
        } else {
          // If users list is empty, emit failure state
          emit(const UserFailure(msg: 'empty users set'));
        }
      }, onError: (error) {
        // Handle stream errors, emit failure state
        emit(UserFailure(msg: error.toString()));
      });
    } on SocketException catch (_) {
      // Handle socket exceptions, emit failure state
      emit(const UserFailure(msg: 'Internet Error 404'));
    } catch (_) {
      // Handle other exceptions, emit failure state
      emit(const UserFailure(msg: 'something went error'));
    }
  }
}
