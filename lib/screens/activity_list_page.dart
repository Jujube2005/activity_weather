
import 'package:flutter/material.dart';

class ActivityListPage extends StatelessWidget {
  const ActivityListPage({super.key});

  static const List<Map<String, String>> activities = [
    {
      'title': 'เดินเล่น',
      'date': '24 ต.ค. 2026',
      'detail': 'เดินเล่นในสวนใกล้บ้าน ประมาณ 30 นาที',
    },
    {
      'title': 'อ่านหนังสือ',
      'date': '23 ต.ค. 2026',
      'detail': 'อ่านหนังสือเป็นเวลา 20 นาที',
    },
    {
      'title': 'ออกกำลัง',
      'date': '22 ต.ค. 2026',
      'detail': 'ออกกำลังกายและยืดกล้ามเนื้อ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กิจกรรม'),
      ),
      
body: ListView.builder(
  itemCount: activities.length,
  itemBuilder: (context, index) {
    final activity = activities[index];

    return ListTile(
      leading: const Icon(Icons.calendar_month),
      title: Text(activity['title']!),
      subtitle: Text(activity['date']!),
      trailing: const Icon(Icons.arrow_forward),
    );
  },
),

    );
  }
}
