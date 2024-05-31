import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_management_app/app/screens/home_screen.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isVerified = false;

  Future<void> sendEmailVerification() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      try {
        await user.sendEmailVerification();
        if (kDebugMode) {
          print("Verification email sent");
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  void checkStatus() {
    if (FirebaseAuth.instance.currentUser?.emailVerified != null) {
      setState(() {
        isVerified = true;
      });
    } else {
      setState(() {
        isVerified = false;
      });
    }
  }

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/mail.png',
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Verify Email',
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
            ),
            Text('STATUS : $isVerified'),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                sendEmailVerification();
                checkStatus();
              },
              child: Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                    color: isVerified ? Colors.green : Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffc2c2c2),
                        spreadRadius: 3,
                        blurRadius: 3,
                      )
                    ]),
                child: Center(
                  child: Text(
                    isVerified ? '✔️ Verified' : 'Send Request',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isVerified ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            if (isVerified)
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => HomeScreen(
                            uid: FirebaseAuth.instance.currentUser!.uid),
                      ),
                    );
                  },
                  child: const Text('Procceed to Homepage'))
          ],
        ),
      ),
    );
  }
}
