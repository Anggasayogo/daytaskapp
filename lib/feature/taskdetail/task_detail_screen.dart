import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailScreen({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late String _selectedProgress;

  @override
  void initState() {
    super.initState();
    _selectedProgress = 'asign'; // Inisialisasi nilai awal progress
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Task Detail"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task Name
                const Text('Create DashBord Menu dengan chart Bar & Pie',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Task Docs
                const Text('DOCS',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // Progress and Priority
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Progress: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: _selectedProgress,
                          items: [
                            'asign',
                            'in progress',
                            'completed',
                          ].map((progress) {
                            return DropdownMenuItem(
                              value: progress,
                              child: Text(
                                progress,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedProgress = value!;
                            });
                            // Tambahkan logika untuk menyimpan progress baru
                            print('Task Progress Updated: $_selectedProgress');
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('LOW',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Dates
                const Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: Colors.blue, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "2025-Sep-19",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(Icons.flag, color: Colors.blue, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "2025-Sep-21",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Save Button
                SizedBox(
                  width: double.infinity, 
                  child: TextButton(
                    onPressed: () {
                      print('Progress Saved: $_selectedProgress');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Task progress updated to $_selectedProgress'),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: primary, // Warna latar belakang
                      padding: const EdgeInsets.symmetric(
                        vertical: 16, // Padding atas dan bawah
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Update Progress',
                      style: semibold14.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
