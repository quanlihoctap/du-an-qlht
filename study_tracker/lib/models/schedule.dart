class Schedule {
  final String day; // “Thứ 2”
  final String start; // 06:45
  final String end; // 09:25
  final String subject; // “Lập trình Mobile App”
  final String room; // “C2.102” hoặc rỗng

  Schedule({
    required this.day,
    required this.start,
    required this.end,
    required this.subject,
    this.room = '',
  });

  String get timeRange => '$start - $end';
}
