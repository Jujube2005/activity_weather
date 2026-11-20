import 'package:flutter/material.dart';

class ActivityFormPage extends StatefulWidget {
  const ActivityFormPage({super.key});

  @override
  State<ActivityFormPage> createState() => _ActivityFormPageState();
}

class _ActivityFormPageState extends State<ActivityFormPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final noteController = TextEditingController();

  String? selectedCategory;

  final List<String> categories = [
    'การเรียน',
    'สุขภาพ',
    'การเดินทาง',
    'งานส่วนตัว',
  ];

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'title': titleController.text.trim(),
        'category': selectedCategory,
        'note': noteController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มกิจกรรม')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ชื่อกิจกรรม
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'ชื่อกิจกรรม'),
                validator: (value) {
                  final title = (value ?? '').trim();

                  if (title.isEmpty) {
                    return 'กรุณากรอกชื่อกิจกรรม';
                  }

                  if (title.length > 60) {
                    return 'ชื่อต้องไม่เกิน 60 ตัวอักษร';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // หมวดหมู่
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: 'หมวดหมู่'),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาเลือกหมวดหมู่';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // หมายเหตุ
              TextFormField(
                controller: noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'หมายเหตุ (ไม่บังคับ)',
                ),
                validator: (value) {
                  final note = (value ?? '').trim();

                  if (note.length > 240) {
                    return 'หมายเหตุต้องไม่เกิน 240 ตัวอักษร';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _validateForm,
                child: const Text('ตรวจสอบข้อมูล'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
