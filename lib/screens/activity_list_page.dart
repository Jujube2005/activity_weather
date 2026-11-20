import 'package:flutter/material.dart';

import 'activity_detail_page.dart';
import 'activity_form_page.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  final List<Map<String, String>> activities = [
    {
      'title': 'เที่ยวรอบโลก',
      'date': '27 ต.ค. 2026',
      'detail': 'เดินทางทั่วโลก 80 วัน',
    },
    {'title': 'หาหมอ', 'date': '26 ต.ค. 2026', 'detail': 'เจ็บข้อมือขวา'},
    {
      'title': 'เดินชมจันทร์บนท้องฟ้ายามรัตติกาลแบบหมาป่าเดียวดาย',
      'date': '25 ต.ค. 2026',
      'detail': 'เดินชมจันทร์แบบหมาป่าเดียวดาย วูฟฟฟฟ',
    },
    {
      'title': 'เดินชมธรรมชาติในสวนสาธารณะคนเดียวเหงาๆ',
      'date': '24 ต.ค. 2026',
      'detail': 'เดินในสวน',
    },
    {'title': 'อ่านหนังสือ', 'date': '23 ต.ค. 2026', 'detail': 'อ่าน 20 นาที'},
    {'title': 'ออกกำลัง', 'date': '22 ต.ค. 2026', 'detail': 'ยืดกล้ามเนื้อ'},
    {
      'title': 'ร้องเพลงชาติ',
      'date': '21 ต.ค. 2026',
      'detail': 'ร้องเพลงชาติหน้าเสาธง',
    },
    {
      'title': 'ทิงเซี่ย',
      'date': '20 ต.ค. 2026',
      'detail': 'เขียนตามคำบอกภาษาจีน',
    },
    {
      'title': 'อาบน้ำใหญ่',
      'date': '19 ต.ค. 2026',
      'detail': 'อาบน้ำใหญ่ประจำสัปดาห์ สระผม นวดผม หมักผม ขัดผิวหน้า ขัดตัว',
    },
    {
      'title': 'ซักผ้า',
      'date': '18 ต.ค. 2026',
      'detail': 'แบกตะกร้าไปซักผ้าที่ร้านซักหน้าซอยหอ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('กิจกรรม'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'เพิ่มกิจกรรม',
            onPressed: () async {
              final result = await Navigator.push<Map<String, String>>(
                context,
                MaterialPageRoute(
                  builder: (context) => const ActivityFormPage(),
                ),
              );

              if (result != null) {
                setState(() {
                  activities.add({
                    'title': result['title']!,
                    'date': DateTime.now().toString().substring(0, 10),
                    'detail': result['note']!,
                  });
                });
              }
            },
          ),
        ],
      ),
      body: activities.isEmpty
          ? const Center(child: Text('ยังไม่มีกิจกรรม'))
          : ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return InkWell(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) =>
                            ActivityDetailPage(activity: activity),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(activity['title']!),
                        Text(activity['date']!),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
