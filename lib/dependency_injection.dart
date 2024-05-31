// dependency_injection.dart
import 'package:get_it/get_it.dart';
import 'package:student_management_app/app/cubit/auth/auth_cubit.dart';
import 'package:student_management_app/app/cubit/credential/credential_cubit.dart';
import 'package:student_management_app/app/cubit/student/student_cubit.dart';
import 'package:student_management_app/app/cubit/user/user_cubit.dart';

import 'package:student_management_app/domain/usecases/add_student_usecase.dart';
import 'package:student_management_app/domain/usecases/create_user_usecase.dart';
import 'package:student_management_app/domain/usecases/currentuid_usecase.dart';
import 'package:student_management_app/domain/usecases/get_students_usecase.dart';
import 'package:student_management_app/domain/usecases/get_user_usecase.dart';
import 'package:student_management_app/domain/usecases/is_signedin_usecase.dart';
import 'package:student_management_app/domain/usecases/is_verified_usecase.dart';
import 'package:student_management_app/domain/usecases/signin_usecase.dart';
import 'package:student_management_app/domain/usecases/signout_usecase.dart';
import 'package:student_management_app/domain/usecases/signup_usecase.dart';
import 'package:student_management_app/domain/usecases/update_student.dart';
import 'package:student_management_app/data/repo/firebase_repository_impl.dart';
import 'package:student_management_app/domain/repo/firebase_repository.dart';
import 'package:student_management_app/data/data_source/remote_datasource.dart';
import 'package:student_management_app/data/data_source/remote_datasource_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits

  sl.registerFactory(
    () => AuthCubit(
      signOutUsecase: sl.call(),
      getCurrentUidUsecase: sl.call(),
      isSignInUsecase: sl.call(),
      isVerifiedUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UserCubit(getCurrentUserUsecase: sl.call()),
  );

  sl.registerFactory(
    () => CredentialCubit(
      signInUsecase: sl.call(),
      signUpUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => StudentCubit(
      getCurrentUserUsecase: sl.call(),
      getStudentsUsecase: sl.call(),
      addStudentUsecase: sl.call(),
      updateStudentUsecase: sl.call(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => SignInUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignUpUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignOutUsecase(repository: sl()));
  sl.registerLazySingleton(() => CurrentUidUsecase(repository: sl()));
  sl.registerLazySingleton(() => AddStudentUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetStudentUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateStudentUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => IsSignedInUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateUserUsecase(repository: sl()));
  sl.registerLazySingleton(() => IsVerifiedUsecase(repository: sl()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDatasource: sl()));

  // Data sources
  sl.registerLazySingleton<RemoteDatasource>(() => RemoteDatasourceImpl(
        firebaseAuth: sl(),
        firebaseFirestore: sl(),
      ));

  // External
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
}
