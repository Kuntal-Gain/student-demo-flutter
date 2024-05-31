import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management_app/app/cubit/auth/auth_cubit.dart';
import 'package:student_management_app/app/cubit/user/user_cubit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_management_app/app/screens/create_user_screen.dart';
import 'package:student_management_app/app/screens/students_screen.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({super.key, required this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers(uid: widget.uid);
    super.initState();
  }

  final List<Widget> _screens = [
    const StudentFormScreen(),
    const StudentsListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).logout();
              },
              child: const Text('Logout'))
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (ctx, state) {
          if (state is UserLoaded) {
            return _screens[_selectedIndex];
          } else if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserFailure) {
            return Center(child: Text('Error : ${state.msg}'));
          } else {
            if (kDebugMode) {
              print(state);
            }
            return const Center(
              child: Text('Failed to load user data'), // Show error message
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.redAccent,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.deepPurpleAccent,
              activeColor: Colors.white,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.people,
                  text: 'Students',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
