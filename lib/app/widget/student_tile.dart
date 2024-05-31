import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_management_app/app/screens/update_user_screen.dart';
import 'package:student_management_app/domain/entities/student_entity.dart';

Widget studentTile(StudentEntity student, BuildContext context) {
  return Container(
    height: 150,
    padding: const EdgeInsets.all(14),
    margin: const EdgeInsets.all(18),
    width: double.infinity,
    decoration: BoxDecoration(
      color: const Color(0xffffffff),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0xffc2c2c2),
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 0.6),
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID : ${student.studentid} ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(student.name!,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 32,
                      ),
                    ))
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => UpdateFormScreen(student: student)));
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'DOB : ${student.dob!.toDate().day} / ${student.dob!.toDate().month} / ${student.dob!.toDate().year}'),
            Text(
              student.gender!,
              style: TextStyle(
                  fontSize: 20,
                  color: (student.gender!.toLowerCase() == "male"
                      ? Colors.purple
                      : Colors.red)),
            ),
          ],
        )
      ],
    ),
  );
}
