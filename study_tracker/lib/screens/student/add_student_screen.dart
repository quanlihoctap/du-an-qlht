import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:study_tracker/models/student.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDayController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? _avatarFile;

  Future<void> _pickAvatar(BuildContext context) async {
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          _avatarFile = File(picked.path);
        });
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Cần cấp quyền truy cập ảnh')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Thêm Sinh Viên',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async => _pickAvatar(context),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                _avatarFile != null
                    ? CircleAvatar(
                      radius: 40,
                      backgroundImage: FileImage(_avatarFile!),
                    )
                    : const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.school, color: Colors.white),
                    ),
              ],
            ),
            const SizedBox(height: 20),

            _buildTextField('Mã sinh viên:', studentIdController),
            const SizedBox(height: 16),

            _buildTextField('Tên sinh viên *', nameController),
            const SizedBox(height: 16),

            _buildTextField('Ngày sinh *', birthDayController),
            const SizedBox(height: 16),

            _buildTextField('Quê quán *', addressController),
            const SizedBox(height: 16),

            _buildTextField('Email sinh viên *', emailController),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  String studentId = studentIdController.text;
                  String name = nameController.text;
                  String birthDay = birthDayController.text;
                  String address = addressController.text;
                  String email = emailController.text;

                  if (studentId.isEmpty ||
                      name.isEmpty ||
                      birthDay.isEmpty ||
                      address.isEmpty ||
                      email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
                    );
                    return;
                  }

                  final box = Hive.box<Student>('students');

                  if (box.containsKey(studentId)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Mã sinh viên đã tồn tại')),
                    );
                    return;
                  }

                  final student = Student(
                    id: studentId,
                    name: name,
                    avatar: _avatarFile?.path ?? '',
                    birthDate: birthDay,
                    address: address,
                    email: email,
                  );
                  box.put(studentId, student);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tạo hồ sơ sinh viên thành công')),
                    );
                  }

                  await Future.delayed(Duration(seconds: 1));
                  if (context.mounted) {
                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Tạo hồ sơ sinh viên',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
