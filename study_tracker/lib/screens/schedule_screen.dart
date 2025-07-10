import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:study_tracker/screens/schedule_detail_screen.dart';
import 'package:study_tracker/widgets/header_bar.dart';
import 'package:study_tracker/widgets/schedule_item.dart';
import '../models/schedule.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // ────────────────────────────────────────────────────────────────────
  // DATA
  // ────────────────────────────────────────────────────────────────────
  final List<Schedule> mondayList = [
    Schedule(
      day: 'Thứ 2',
      start: '6h46',
      end: '9h25',
      subject: 'Lập trình Mobile App',
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
      subject: 'Lập trình Web',
      room: 'C2.102',
    ),
  ];

  // ────────────────────────────────────────────────────────────────────
  // NEW: ngày đang chọn
  // ────────────────────────────────────────────────────────────────────
  DateTime selectedDate = DateTime.now();
  final DateFormat ddMMyyyy = DateFormat('dd/MM/yyyy');

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(today.year - 3),
      lastDate: DateTime(today.year + 3),
      locale: const Locale('vi', 'VN'),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
      // TODO: load lại lịch theo ngày mới (gọi API / lọc list…) nếu cần
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(
        title: 'Thông Tin Học Tập',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          // ───────────────────────────────────────
          // HEADER: Lịch + ngày + filter
          // ───────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                const Text(
                  'Lịch học',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(width: 12),

                // Icon + Ngày -> cùng mở DatePicker
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 18),
                      const SizedBox(width: 4),
                      Text(ddMMyyyy.format(selectedDate)),
                    ],
                  ),
                ),

                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.filter_alt_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // ───────────────────────────────────────
          // LIST
          // ───────────────────────────────────────
          Expanded(
            child: ListView.builder(
              itemCount: mondayList.length,
              itemBuilder:
                  (context, index) => ScheduleItem(
                    item: mondayList[index],
                    onDelete: () => setState(() => mondayList.removeAt(index)),
                  ),
            ),
          ),

          // ───────────────────────────────────────
          // NÚT LƯU THỜI KHÓA BIỂU
          // ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF4696EB).withAlpha(230),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ScheduleDetailScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Lưu thời khóa biểu'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
