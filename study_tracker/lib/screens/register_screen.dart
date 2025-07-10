import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:study_tracker/models/user.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterScreen({super.key});

  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 166, 225, 242),
      body: Stack(
        children: [
          Positioned(
            top: 60,
            right: 0,
            left: 0,
            child: Center(
              child: Text(
                'ĐĂNG KÝ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(24),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Image.asset('assets/images/icon_login.png'),
                    SizedBox(height: 16),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Tên đăng nhập',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Nhập lại mật khẩu',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        String username = usernameController.text.trim();
                        String password = passwordController.text;
                        String confirmPassword = confirmPasswordController.text;

                        // Kiểm tra dữ liệu
                        if (username.isEmpty ||
                            password.isEmpty ||
                            confirmPassword.isEmpty) {
                          _showMessage(
                            context,
                            'Vui lòng điền đầy đủ thông tin',
                          );
                            return;
                        }

                        if (password != confirmPassword) {
                          _showMessage(context, 'Mật khẩu không khớp');
                          return;
                        }

                        final box = Hive.box<User>('users');

                        if (box.containsKey(username)) {
                          _showMessage(context, 'Tên đăng nhập đã tồn tại');
                          return;
                        }

                        final hashed = hashPassword(password);
                        final user = User(
                          username: username,
                          hashedPassword: hashed,
                          displayName: username,
                        );

                        await box.put(username, user);

                        if (context.mounted) {
                          _showMessage(
                            context,
                            'Đăng ký thành công! Đang quay lại đăng nhập...',
                          );
                        }
                        await Future.delayed(Duration(seconds: 2));
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 70, 150, 235),
                        minimumSize: Size(double.infinity, 40),
                      ),
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Đã có tài khoản! Quay về đăng nhập',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
