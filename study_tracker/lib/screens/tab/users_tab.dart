import 'package:flutter/material.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFF0F73E7),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(400, 120),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 120, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withValues(alpha: 0.2),
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(Icons.person, size: 72, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 14),
                // Mã sinh viên
                Text(
                  'MSV: 123456789',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                _InfoRow(label: 'Họ Tên:', value: 'Nguyễn Văn A'),
                _InfoRow(label: 'email:', value: 'nguyenvana@gmail.com'),
                _InfoRow(label: 'GPA:', value: '3.43'),
                _InfoRow(label: 'Quê quán:', value: 'TP HCM'),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Trường học:',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Đại học công nghệ giao thông vận tải',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 20),
                _InfoRow(
                  label: 'Số điện thoại:',
                  value: '+ 84 123456789',
                  labelStyle: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.blue.shade700,
                  ),
                  valueStyle: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 20),

                // Nút xác nhận
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color(0xFF0F73E7),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Xác nhận thành công!')),
                      );
                    },
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const _InfoRow({
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label  ',
            style:
                labelStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Expanded(
            child: Text(value, style: valueStyle ?? theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
