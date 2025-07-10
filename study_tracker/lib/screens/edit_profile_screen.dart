import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(text: 'Nguyễn Văn A');
  final birthController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    birthController.dispose();
    genderController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Thông tin đã được lưu!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF4696EB),
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text(
          'Thông Tin Thêm',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Avatar + Tên + icon sửa
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF4696EB).withAlpha(50),
                      radius: 40,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF4696EB).withAlpha(230),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          nameController.text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 16),
                          onPressed: () {
                            // Có thể mở dialog sửa tên ở đây
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Họ và tên
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Họ và tên',
                    border: OutlineInputBorder(),
                  ),
                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? 'Vui lòng nhập họ tên'
                              : null,
                ),
                const SizedBox(height: 12),

                // Ngày sinh
                TextFormField(
                  controller: birthController,
                  decoration: const InputDecoration(
                    labelText: 'Ngày sinh',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    FocusScope.of(
                      context,
                    ).requestFocus(FocusNode()); // ẩn bàn phím
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      birthController.text =
                          '${picked.day}/${picked.month}/${picked.year}';
                    }
                  },
                ),
                const SizedBox(height: 12),

                // Giới tính
                TextFormField(
                  controller: genderController,
                  decoration: const InputDecoration(
                    labelText: 'Giới tính',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                // Email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Vui lòng nhập email';
                    }
                    if (!val.contains('@')) return 'Email không hợp lệ';
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Nút lưu
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4696EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Lưu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
