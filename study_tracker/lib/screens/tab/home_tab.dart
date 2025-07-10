import 'package:flutter/material.dart';
import 'package:study_tracker/widgets/basic_info_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

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
      body: BasicInfoCard(),
    );
  }
}
