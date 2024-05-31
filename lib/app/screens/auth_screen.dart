import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management_app/app/cubit/auth/auth_cubit.dart';
import 'package:student_management_app/app/cubit/credential/credential_cubit.dart';
import 'package:student_management_app/app/screens/home_screen.dart';

import 'package:student_management_app/app/widget/text_tile.dart';
import 'package:student_management_app/domain/entities/user_entity.dart';
// ignore: depend_on_referenced_packages

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  bool isHidden = true;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (isLogin) {
      BlocProvider.of<CredentialCubit>(context).signInUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } else {
      BlocProvider.of<CredentialCubit>(context).signUpUser(
          user: UserEntity(
        name: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ));
    }

    BlocProvider.of<AuthCubit>(context).loggedIn();
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/login.jpg',
              height: 200,
            ),
          ),

          // Login / Register
          Center(
            child: Text(
              isLogin ? 'Login' : 'Register',
              style: const TextStyle(
                color: Color(0xffd268cc),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          // Username
          if (!isLogin) textTile("Username", _fullNameController),
          // Email
          textTile("Email", _emailController),
          // Dob
          // Password
          textTileWithPassword("Password", _passwordController, isHidden, () {
            setState(() {
              isHidden = !isHidden;
            });
          }),
          // confirm password
          if (!isLogin)
            textTileWithPassword(
                "Confirm Password", _confirmPasswordController, isHidden, () {
              setState(() {
                isHidden = !isHidden;
              });
            }),
          // submit

          GestureDetector(
            onTap: () {
              _submit();
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                padding: const EdgeInsets.all(12),
                height: 70,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffc2c2c2),
                      blurRadius: 2,
                      spreadRadius: 1,
                    )
                  ],
                  color: const Color(0xffd268cc),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    isLogin ? 'Login' : 'Register',
                    style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),

          // toggle

          TextButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Text(
              isLogin
                  ? "Don't Have an Account ? Sign Up"
                  : "Already Have an Account ? Login",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (ctx, state) {
          if (state is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }

          if (state is CredentialFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (ctx, state) {
          if (state is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return HomeScreen(uid: state.uid);
                } else {
                  return _bodyWidget();
                }
              },
            );
          }

          return _bodyWidget();
        },
      ),
    );
  }
}
