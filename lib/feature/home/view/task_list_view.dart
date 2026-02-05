import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/feature/home/bloc/task_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TaskListView extends StatefulWidget {
  final String? priority;
  final String? keyword;
  const TaskListView({super.key, this.priority, this.keyword});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  String? roleId;

  @override
  void initState() {
    super.initState();
    _gettingRoleId();
    context.read<TaskBloc>().add(const TaskFetchEvent(
        priority: '', taskProgress: '', filterDate: '', keyword: ''));
  }

  // Mengambil Role ID dari SharedPreferences
  void _gettingRoleId() async {
    final role = await getRoleId();
    setState(() {
      roleId = role;
    });
  }

  @override
  void didUpdateWidget(covariant TaskListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.priority != widget.priority ||
        oldWidget.keyword != widget.keyword) {
      context.read<TaskBloc>().add(TaskFetchEvent(
          priority: widget.priority ?? '',
          taskProgress: '',
          filterDate: '',
          keyword: widget.keyword ?? ''));
    }
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
    return Expanded(
      child: BlocBuilder<TaskBloc, TaskState>(
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
            if (tasks.isEmpty) {
              return const Center(child: Text("No tasks found"));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
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
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.grey.shade300, width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.taskName,
                                      style: semibold14.copyWith(fontSize: 14),
                                    ),
                                    const SizedBox(height: 6),
                                    // Deskripsi Task
                                    Text(
                                      task.taskDocs.isNotEmpty
                                          ? task.taskDocs.split('|').first.trim()
                                          : 'No description available',
                                      style: regular14.copyWith(fontSize: 12, color: Colors.black54),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    // Info Penerima Tugas (Hanya Muncul untuk Admin/Role 1)
                                    if (roleId == '1') ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        "Tugas Untuk: ${task.username}",
                                        style: regular14.copyWith(
                                          fontSize: 12, 
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Priority Label
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  task.priority ?? 'Low',
                                  style: regular12_5.copyWith(fontSize: 10, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          
                          // STATUS LABEL DISINI
                          _buildStatusLabel(task.taskProgres),
                          
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildDateInfo('assets/icons/ic_calendar_clock.svg', task.taskDate),
                              const SizedBox(width: 16),
                              _buildDateInfo('assets/icons/ic_flags.svg', task.taskDueDate),
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
      ),
    );
  }

  Widget _buildDateInfo(String iconPath, dynamic date) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, width: 18, height: 18),
        const SizedBox(width: 5),
        Text(
          date != null 
              ? DateFormat('yyyy MMM dd').format(date) 
              : 'N/A',
          style: regular14.copyWith(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }
}