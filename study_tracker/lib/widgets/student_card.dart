import 'dart:io';

import 'package:flutter/material.dart';
import 'package:study_tracker/models/student.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const StudentCard({super.key, required this.student, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          spacing: 20,
          children: [
            student.avatar.isNotEmpty
                ? SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundImage: FileImage(File(student.avatar)),
                    radius: 100,
                  ),
                )
                : Image.asset(
                  'assets/images/avatar_default.png',
                  height: 80,
                  width: 80,
                  fit: BoxFit.fitWidth,
                ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Mã sinh viên: ${student.id}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
