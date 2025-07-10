import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Delay splash
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (!mounted) return;

    // if (isLoggedIn) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Chào mừng bạn đã quay lại!')),
    //   );
    //   await Future.delayed(Duration(seconds: 2));
    //   if (!mounted) return;
    //   Navigator.pushReplacementNamed(context, '/home');
    // // } else {
    Navigator.pushReplacementNamed(context, '/login');
    // // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 166, 225, 242),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset('assets/images/bg_top_splash.png'),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Quản Lí\nHọc Tập',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'OldStandard',
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 250),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/banner_splash.png',
                height: 250,
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
