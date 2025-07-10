import 'package:study_tracker/models/student.dart';

class StudentRepository {
  static final List<Student> _students = [];

  List<Student> getAllStudents() => _students;

  void addStudent(Student student) => _students.add(student);

  void deleteStudent(String id) => _students.removeWhere((s) => s.id == id);

  void updateStudent(Student student) {
    final index = _students.indexWhere((s) => s.id == student.id);
    if (index != -1) _students[index] = student;
  }
}
