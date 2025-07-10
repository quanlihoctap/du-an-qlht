import 'package:flutter/material.dart';
import 'package:study_tracker/screens/edit_profile_screen.dart';
import 'package:study_tracker/screens/login_screen.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool isNotificationOn = true;
  bool isAutoUpdateOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.only(top: 40, left: 16, bottom: 16),
            width: double.infinity,
            child: Row(
              children: const [
                Icon(Icons.settings, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Cài đặt',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Nội dung chính
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView(
                children: [
                  // Avatar + Tên
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xFF4696EB).withAlpha(50),
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Color(0xFF4696EB).withAlpha(230),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Nguyễn Văn A',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Divider(),

                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Text(
                      'Thiết lập tài khoản',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                  ListTile(
                    title: const Text('Chỉnh sửa thông tin'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    title: const Text('Thay đổi mật khẩu'),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  SwitchListTile(
                    title: const Text('Bật thông báo'),
                    value: isNotificationOn,
                    activeColor: const Color(0xFF4696EB).withAlpha(230),
                    inactiveThumbColor: Colors.grey.shade400,
                    inactiveTrackColor: Colors.grey.shade300,
                    onChanged: (val) {
                      setState(() {
                        isNotificationOn = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Tự động cập nhật'),
                    value: isAutoUpdateOn,
                    activeColor: const Color(0xFF4696EB).withAlpha(230),
                    inactiveThumbColor: Colors.grey.shade400,
                    inactiveTrackColor: Colors.grey.shade300,
                    onChanged: (val) {
                      setState(() {
                        isAutoUpdateOn = val;
                      });
                    },
                  ),

                  const Divider(height: 32),

                  const Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      'Thông tin thêm',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  ListTile(
                    title: const Text('Về chúng tôi'),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    title: const Text('Chính sách bảo mật'),
                    onTap: () {},
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
