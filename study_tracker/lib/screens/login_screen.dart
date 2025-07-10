import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:study_tracker/models/user.dart';
import 'package:study_tracker/utils/hash.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _login() async {
    String username = usernameController.text.trim();
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showMessage('Vui lòng điền đầy đủ thông tin');
      return;
    }

    final box = Hive.box<User>('users');
    final user = box.get(username);

    if (user == null) {
      _showMessage('Tài khoản không tồn tại');
      return;
    }

    String inputHashed = hashPassword(password);
    if (user.hashedPassword != inputHashed) {
      _showMessage('Mật khẩu không đúng');
      return;
    }

    _showMessage('Đăng nhập thành công');

    // Chuyển sang màn hình chính
    await Future.delayed(Duration(seconds: 1));
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (Route<dynamic> route) => false,
      );
    }
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
                'ĐĂNG NHẬP',
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 70, 150, 235),
                        minimumSize: Size(double.infinity, 40),
                      ),
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Đăng kí tài khoản',
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
