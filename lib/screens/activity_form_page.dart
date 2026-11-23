import 'package:flutter/material.dart';

class ActivityFormPage extends StatefulWidget {
  const ActivityFormPage({super.key});

  @override
  State<ActivityFormPage> createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  String? _selectedCategory;

  final List<String> _categories = const [
    'ออกกำลังกาย',
    'การเรียน',
    'พักผ่อน',
    'งานบ้าน',
    'อื่น ๆ',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _saveDraft() {
    // ถ้าข้อมูลไม่ผ่าน จะไม่ปิดฟอร์มและไม่ส่งข้อมูลกลับ
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final result = <String, String>{
      'title': _titleController.text.trim(),
      'date': DateTime.now().toString().substring(0, 10),
      'detail': _noteController.text.trim().isEmpty
          ? _selectedCategory!
          : _noteController.text.trim(),
      'category': _selectedCategory!,
    };

    // ส่งข้อมูลกลับไปยังหน้ารายการ
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มกิจกรรม'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'ชื่อกิจกรรม',
                hintText: 'เช่น เดินเล่น',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final title = (value ?? '').trim();

                if (title.isEmpty) {
                  return 'กรุณาใส่ชื่อกิจกรรม';
                }

                if (title.length > 60) {
                  return 'ชื่อต้องไม่เกิน 60 ตัวอักษร';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'หมวดหมู่',
                border: OutlineInputBorder(),
              ),
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'กรุณาเลือกหมวดหมู่';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'หมายเหตุ (ไม่บังคับ)',
                hintText: 'กรอกรายละเอียดเพิ่มเติม',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if ((value ?? '').length > 240) {
                  return 'หมายเหตุต้องไม่เกิน 240 ตัวอักษร';
                }

                return null;
              },
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _saveDraft,
              child: const Text('บันทึกฉบับร่าง'),
            ),
          ],
        ),
      ),
    );
  }
}