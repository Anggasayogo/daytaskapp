import 'package:daytaskapp/feature/taskdetail/bloc/task_detail_bloc.dart';
import 'package:daytaskapp/feature/taskdetail/bloc/update_task_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskDetailView extends StatelessWidget {
  final String selectedProgress;

  const TaskDetailView({Key? key, required this.selectedProgress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      builder: (context, state) {
        if (state is TaskDetailLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskDetailSuccessState) {
          final taskDetail = state.taskDetail;

          return Padding(
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
                    Text(
                      taskDetail.taskName,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Task Docs
                    Text(
                      taskDetail.taskDocs,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      taskDetail.taskDocs,
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
                              value: selectedProgress,
                              items: [
                                'asign',
                                'in-progress',
                                'done',
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
                                // Handle progress change
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
                          child: Text(
                            taskDetail.priority,
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
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              taskDetail.taskDate.isNotEmpty
                                  ? (() {
                                      try {
                                        final date = DateTime.parse(taskDetail.taskDate);
                                        return DateFormat('yyyy MMM dd').format(date);
                                      } catch (e) {
                                        return 'Invalid Date';
                                      }
                                    })()
                                  : 'No Date',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Row(
                          children: [
                            const Icon(Icons.flag, color: Colors.blue, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              taskDetail.taskDueDate.isNotEmpty
                                  ? (() {
                                      try {
                                        final date = DateTime.parse(taskDetail.taskDueDate);
                                        return DateFormat('yyyy MMM dd').format(date);
                                      } catch (e) {
                                        return 'Invalid Date';
                                      }
                                    })()
                                  : 'No Date',
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
                      child: BlocListener<TaskDetailBloc, TaskDetailState>(
                        listener: (context, state) {
                          if (state is TaskDetailLoadingState) {
                            // Show a loading indicator while saving
                            // showDialog(
                            //   context: context,
                            //   builder: (_) => const Center(
                            //     child: CircularProgressIndicator(),
                            //   ),
                            // );
                          }
                          if (state is TaskDetailSuccessState) {
                            Navigator.pop(context); // Close the loading dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Task progress updated to $selectedProgress'),
                              ),
                            );
                          }
                          if (state is TaskDetailErrorState) {
                            Navigator.pop(context); // Close the loading dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                              ),
                            );
                          }
                        },
                        child: TextButton(
                          onPressed: () {
                            context.read<UpdateTaskBloc>().add(
                                  UpdateTaskFetchEvent(
                                    idTask: state.taskDetail.id,
                                    idPoint: state.taskDetail.id_point,
                                    taskName: state.taskDetail.taskName,
                                    taskProgres: selectedProgress,
                                    taskDate: state.taskDetail.taskDate,
                                    taskDueDate: state.taskDetail.taskDueDate,
                                    taskDocs: state.taskDetail.taskDocs,
                                    idPic: state.taskDetail.id_pic,
                                    idSvp: state.taskDetail.id_svp,
                                  ),
                                );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: primary, // Warna latar belakang
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: BlocBuilder<UpdateTaskBloc, UpdateTaskState>(
                            builder: (context, state) {
                              // if (state is UpdateTaskLoadingState) {
                              //   return const CircularProgressIndicator(
                              //     color: Colors.white,
                              //   );
                              // }
                              return Text(
                                'Update Progress',
                                style: semibold14.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is TaskDetailErrorState) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
