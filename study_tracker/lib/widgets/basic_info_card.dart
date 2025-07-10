import 'package:flutter/material.dart';

class BasicInfoCard extends StatelessWidget {
  const BasicInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 300),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Thông Tin Cơ Bản',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Grid icons
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                InfoItem(icon: Icons.menu_book_rounded, label: 'Lịch Học'),
                InfoItem(icon: Icons.account_box_rounded, label: 'Hồ Sơ'),
                InfoItem(
                  icon: Icons.insert_chart_outlined_rounded,
                  label: 'Báo cáo',
                ),
                // InfoItem(
                //   icon: Icons.add,
                //   label: 'Chỉnh sửa',
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 36, color: Colors.black87),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
