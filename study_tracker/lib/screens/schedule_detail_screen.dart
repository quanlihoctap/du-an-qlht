import 'package:flutter/material.dart';
import 'package:study_tracker/widgets/day_card.dart';
import 'package:study_tracker/widgets/header_bar.dart';
import '../models/schedule.dart';

class ScheduleDetailScreen extends StatelessWidget {
  const ScheduleDetailScreen({super.key});

  // dữ liệu mẫu: map day -> list lịch
  Map<String, List<Schedule>> get grouped => {
    'Thứ 2': [
      Schedule(
        day: 'Thứ 2',
        start: '6h46',
        end: '9h25',
        subject: 'Lập trình mobile app',
      ),
      Schedule(
        day: 'Thứ 2',
        start: '9h30',
        end: '12h10',
        subject: 'Nhập môn tương tác người dùng máy',
      ),
      Schedule(
        day: 'Thứ 2',
        start: '13h40',
        end: '17h15',
        subject: 'Lập trình web',
      ),
    ],
    'Thứ 3': [
      Schedule(
        day: 'Thứ 3',
        start: '7h40',
        end: '10h20',
        subject: 'Thương mại điện tử',
      ),
      Schedule(
        day: 'Thứ 3',
        start: '13h45',
        end: '15h25',
        subject: 'Lập trình web',
      ),
    ],
    'Thứ 6': [
      Schedule(
        day: 'Thứ 6',
        start: '6h45',
        end: '9h25',
        subject: 'Nhập môn tương tác người và máy',
      ),
      Schedule(
        day: 'Thứ 6',
        start: '9h30',
        end: '12h10',
        subject: 'Thương mại điện tử',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBar(title: 'Chi Tiết Lịch Học'),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: const [
              Icon(Icons.sticky_note_2_outlined, color: Colors.amber),
              SizedBox(width: 8),
              Text(
                'Buổi sáng/chiều',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // danh sách nhóm theo ngày
          ...grouped.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DayCard(text: entry.key),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          entry.value.map((s) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Text(
                                '+ ${s.timeRange}: ${s.subject}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FilledButton.icon(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF4696EB).withAlpha(230),
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.add),
            label: const Text('Đăng ký lịch'),
          ),
        ],
      ),
    );
  }
}
