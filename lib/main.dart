import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management_app/app/cubit/auth/auth_cubit.dart';
import 'package:student_management_app/app/cubit/credential/credential_cubit.dart';
import 'package:student_management_app/app/cubit/student/student_cubit.dart';
import 'package:student_management_app/app/cubit/user/user_cubit.dart';

import 'package:student_management_app/app/screens/auth_screen.dart';
import 'package:student_management_app/app/screens/home_screen.dart';
import 'package:student_management_app/app/screens/verify_screen.dart';
import 'firebase_options.dart';
import 'dependency_injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<StudentCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (ctx, state) {
            if (state is Authenticated) {
              return HomeScreen(uid: state.uid);
            } else if (state is NotVerified) {
              return const VerifyScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}
