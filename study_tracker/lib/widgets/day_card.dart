import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  const DayCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.zero,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
