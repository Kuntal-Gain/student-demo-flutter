import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management_app/app/cubit/student/student_cubit.dart';
import 'package:student_management_app/domain/entities/student_entity.dart';

class UpdateFormScreen extends StatefulWidget {
  final StudentEntity student;
  const UpdateFormScreen({super.key, required this.student});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateFormScreenState createState() => _UpdateFormScreenState();
}

class _UpdateFormScreenState extends State<UpdateFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dobController;
  late String _gender;
  late Timestamp dob;
  bool _isLoading = false; // Track loading state

  _updateStudent() async {
    setState(() {
      _isLoading = true;
    });
    await BlocProvider.of<StudentCubit>(context).updateStudent(StudentEntity(
      studentid: widget.student.studentid,
      name: _nameController.text.trim(),
      dob: dob,
      gender: _gender,
    ));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.student.name!);
    _dobController = TextEditingController();
    dob = widget.student.dob!;
    _gender = widget.student.gender!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  textTile('Name', _nameController),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _dobController.text =
                              pickedDate.toLocal().toString().split(' ')[0];
                          dob = Timestamp.fromDate(pickedDate);
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: textTile('Date of Birth', _dobController),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    height: 65,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xccd268cc),
                          blurRadius: 2,
                          spreadRadius: 1,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        value: _gender,
                        decoration: const InputDecoration(
                          hintText: 'Gender',
                          border: InputBorder.none,
                        ),
                        items: ['Male', 'Female']
                            .map((label) => DropdownMenuItem(
                                  value: label,
                                  child: Text(label),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      _updateStudent();

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Student Updated Successfully'),
                        backgroundColor: Colors.green,
                      ));

                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
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
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Update Student",
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget textTile(String label, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    padding: const EdgeInsets.all(12),
    height: 65,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color(0xccd268cc),
          blurRadius: 2,
          spreadRadius: 1,
        )
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Center(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

Widget textTileWithPassword(String label, TextEditingController controller,
    bool isHidden, Function func) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    padding: const EdgeInsets.all(12),
    height: 65,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color(0xccd268cc),
          blurRadius: 2,
          spreadRadius: 1,
        )
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Center(
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: TextField(
              obscureText: isHidden,
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () => func(),
              icon: Icon(
                !isHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
