import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:study_tracker/models/student.dart';
import 'package:study_tracker/screens/home_screen.dart';
import 'package:study_tracker/screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:study_tracker/screens/register_screen.dart';
import 'package:study_tracker/screens/splash_screen.dart';

import 'models/user.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<Student>('students');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản Lý Học Tập',
      debugShowCheckedModeBanner: false,
      locale: const Locale('vi', 'VN'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
