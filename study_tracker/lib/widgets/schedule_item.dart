import 'package:flutter/material.dart';
import '../../models/schedule.dart';

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({super.key, required this.item, this.onDelete});

  final Schedule item;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // chi tiết từng môn (nếu có)
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 0.8),
          ),
        ),
        child: Row(
          children: [
            // thời gian
            Expanded(
              flex: 3,
              child: Text(
                item.timeRange,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            // môn học
            Expanded(
              flex: 6,
              child: Text(
                item.room.isEmpty
                    ? item.subject
                    : '${item.subject} (${item.room})',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // nút xoá
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_sweep_rounded),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
