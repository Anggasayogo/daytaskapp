import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/feature/home/bloc/task_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart'; // Import service preference
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TaskListView extends StatefulWidget {
  final String? priority;
  final String? datetime;
  const TaskListView({super.key, this.priority, this.datetime});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  String? roleId; // Tambahkan variabel roleId

  @override
  void initState() {
    super.initState();
    _gettingRoleId(); // Ambil role id saat init
    _fetchTasks();
  }

  // Fungsi untuk mengambil role id secara asinkron
  void _gettingRoleId() async {
    final role = await getRoleId();
    setState(() {
      roleId = role;
    });
  }

  @override
  void didUpdateWidget(covariant TaskListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.priority != widget.priority || oldWidget.datetime != widget.datetime) {
      _fetchTasks();
    }
  }

  void _fetchTasks() {
    context.read<TaskBloc>().add(TaskFetchEvent(
      priority: '',
      taskProgress: widget.priority ?? '',
      filterDate: widget.datetime ?? '',
      keyword: '',
    ));
  }

  // --- HELPER UNTUK LABEL STATUS BERWARNA ---
  Widget _buildStatusLabel(String status) {
    Color backgroundColor;
    switch (status.toLowerCase()) {
      case 'done':
        backgroundColor = Colors.green;
        break;
      case 'in-progress':
        backgroundColor = Colors.orange;
        break;
      case 'revision':
        backgroundColor = Colors.redAccent;
        break;
      case 'asign':
        backgroundColor = Colors.blue;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TaskErrorState) {
          return Center(
            child: Text(state.message, style: const TextStyle(color: Colors.red)),
          );
        }

        if (state is TaskSuccessState) {
          final tasks = state.tasks;
          return tasks.isEmpty
              ? const Center(child: Text('No tasks available'))
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return InkWell(
                      onTap: () {
                        context.push(RoutePath.taskDetail, extra: task.id.toString());
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.grey.shade300, width: 1.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          task.taskName,
                                          style: semibold14.copyWith(fontSize: 14),
                                        ),
                                        const SizedBox(height: 6),
                                        // Deskripsi singkat
                                        Text(
                                          task.taskDocs.isNotEmpty 
                                              ? task.taskDocs.split('|').first.trim() 
                                              : 'No docs available',
                                          style: regular14.copyWith(fontSize: 12, color: Colors.black54),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        
                                        // --- TUGAS UNTUK (Hanya tampil jika Admin/Role 1) ---
                                        if (roleId == '1') ...[
                                          const SizedBox(height: 6),
                                          Text(
                                            "Tugas Untuk: ${task.username}",
                                            style: regular14.copyWith(
                                              fontSize: 12, 
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  // Priority Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      task.priority ?? 'Low',
                                      style: regular12_5.copyWith(fontSize: 11, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              
                              // --- STATUS LABEL BERWARNA ---
                              _buildStatusLabel(task.taskProgres),
                              
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  _buildDateRow('assets/icons/ic_calendar_clock.svg', task.taskDate),
                                  const SizedBox(width: 15),
                                  _buildDateRow('assets/icons/ic_flags.svg', task.taskDueDate),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        }

        return const Center(child: Text("No tasks available"));
      },
    );
  }

  Widget _buildDateRow(String iconPath, dynamic date) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, width: 22, height: 22),
        const SizedBox(width: 5),
        Text(
          date != null ? DateFormat('yyyy MMM dd').format(date) : 'N/A',
          style: regular14.copyWith(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}