import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:study_tracker/models/student.dart';
import 'package:study_tracker/screens/student/add_student_screen.dart';
import 'package:study_tracker/screens/study/student_detail_screen.dart';
import 'package:study_tracker/widgets/student_card.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late List<Student> students = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final box = await Hive.openBox<Student>('students');
    setState(() {
      students = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Danh Sách Sinh Viên',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: null,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Có ${students.length} sinh viên',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return StudentCard(
                      student: student,
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => StudentDetailScreen(student: student),
                          ),
                        );
                        if (result == true) {
                          _loadStudents();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddStudentScreen()),
                  );

                  if (result == true) {
                    _loadStudents();
                  }
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Thêm sinh viên',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4696EB).withAlpha(230),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // bo tròn góc
                  ),
                  elevation: 0, // nếu muốn phẳng
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
