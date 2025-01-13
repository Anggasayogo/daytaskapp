import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return WillPopScope(
      onWillPop: () async {
        return true; // Mengizinkan kembali ke halaman sebelumnya
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Task Detail')),
        body: Center(
          child: Text('Task Detail Screen'),
        ),
      ),
    );
  }
}