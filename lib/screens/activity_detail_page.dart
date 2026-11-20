import 'package:flutter/material.dart';

class ActivityDetailPage extends StatelessWidget {
  final Map<String, String> activity;

  const ActivityDetailPage({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(activity['title']!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(activity['detail']!),
          ],
        ),
      ),
    );
  }
}
