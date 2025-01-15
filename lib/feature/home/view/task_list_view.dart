import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/feature/home/bloc/task_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
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
  @override
  void initState() {
    super.initState();
    // Memanggil TaskFetchEvent saat widget diinisialisasi
    context.read<TaskBloc>().add(const TaskFetchEvent(
      priority: '', 
      taskProgress: '',
      filterDate: '',
      keyword: ''
    ));
  }

  @override
  void didUpdateWidget(covariant TaskListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Jika priority berubah, panggil ulang API
    if (oldWidget.priority != widget.priority || oldWidget.keyword != widget.keyword) {
      context.read<TaskBloc>().add(TaskFetchEvent(
        priority: widget.priority ?? '',
        taskProgress: '',
        filterDate: '',
        keyword: widget.keyword ?? ''
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            
            // Handle loading state
            if (state is TaskLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // Handle error state
            if (state is TaskErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            // Handle success state
            if (state is TaskSuccessState) {
              final tasks = state.tasks; // Ambil data task dari state
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index]; // Ambil setiap task
                  return InkWell(
                    onTap: () {
                      context.push(RoutePath.taskDetail, extra: task.id.toString());
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.grey, width: 1.0),
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
                                      const SizedBox(height: 8),
                                      Text(
                                        task.taskDocs ?? 'No docs available',
                                        style: regular14.copyWith(fontSize: 12),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    task.priority ?? 'Low',
                                    style: regular12_5.copyWith(fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Progress: ${task.taskProgres}',
                              style: semibold12_5.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/ic_calendar_clock.svg',
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      task.taskDate != null
                                          ? DateFormat('yyyy MMM dd').format(task.taskDate)
                                          : 'No Date',
                                      style: regular14.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/ic_flags.svg',
                                      width: 25,
                                      height: 25,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      task.taskDueDate != null
                                          ? DateFormat('yyyy MMM dd').format(task.taskDueDate)
                                          : 'No Due Date',
                                      style: regular14.copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
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

            // Default: Jika state tidak diketahui, tampilkan pesan kosong
            return const Center(
              child: Text("No tasks available"),
            );
          },
        ),
      ),
    );
  }
}
