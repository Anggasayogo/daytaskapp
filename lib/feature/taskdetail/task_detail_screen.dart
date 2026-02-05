import 'package:daytaskapp/app/config/server_config.dart';
import 'package:daytaskapp/feature/taskdetail/bloc/task_detail_bloc.dart';
import 'package:daytaskapp/feature/taskdetail/bloc/update_task_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late String _selectedProgress;
  final TextEditingController _feedbackController = TextEditingController();
  String? roleId;

  @override
  void initState() {
    super.initState();
    _selectedProgress = 'asign';
    gettingRoleId();
    context
        .read<TaskDetailBloc>()
        .add(TaskDetailFetchEvent(taskId: widget.taskId));
  }

  void gettingRoleId() async {
    final role = await getRoleId();
    setState(() {
      roleId = role;
    });
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
      body: BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
          if (state is TaskDetailLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskDetailSuccessState) {
            final taskDetail = state.taskDetail;
            final isProgesDone =
                state.taskDetail.taskProgres == 'done' && roleId == '2';
            final superadmin = roleId == '1';
            final employe = roleId == '2';

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
                      const SizedBox(height: 15),

                      // BLOK DOKUMEN & DOWNLOAD (Sudah disesuaikan)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Deskripsi / Link:",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.copy,
                                      size: 18, color: Colors.blue),
                                  onPressed: () {
                                    // 1. Proses Copy ke Clipboard
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: taskDetail.taskDocs
                                            .split('|')
                                            .first
                                            .trim(),
                                      ),
                                    );
                                    // 2. Tampilkan SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Teks berhasil disalin!"),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              taskDetail.taskDocs.split('|').first.trim(),
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),

                            // Munculkan tombol download HANYA jika ada tanda '|'
                            if (taskDetail.taskDocs.contains('|')) ...[
                              const Divider(height: 20),
                              InkWell(
                                onTap: () async {
                                  final String fileName = taskDetail.taskDocs
                                      .split('|')
                                      .last
                                      .trim();
                                  final String urlString =
                                      "${ServerConfig.mainBaseUrl}/assets/task/$fileName";
                                  final Uri url = Uri.parse(urlString);
                                  try {
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Tidak dapat membuka browser untuk: $fileName")),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    debugPrint("Error Launching URL: $e");
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.file_download_outlined,
                                        color: Colors.blue, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Klik Untuk Mengunduh File",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          text: 'Tugas ${superadmin ? 'untuk' : 'dari'}: ',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                          children: [
                            TextSpan(
                              text: superadmin ? taskDetail.username : taskDetail.svp_name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                                'Progress : ',
                                style: TextStyle(fontSize: 16),
                              ),
                              Container(
                                child: isProgesDone
                                    ? const Text(
                                        'done',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      )
                                    : DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        value: _selectedProgress,
                                        items: [
                                          'asign',
                                          'in-progress',
                                          if (superadmin) 'revision',
                                          'done',
                                        ].map((progress) {
                                          return DropdownMenuItem(
                                            value: progress,
                                            child: Text(
                                              progress,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedProgress = value!;
                                          });
                                        },
                                      ),
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
                              const Icon(Icons.calendar_today,
                                  color: Colors.blue, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                taskDetail.taskDate.isNotEmpty
                                    ? (() {
                                        try {
                                          final date = DateTime.parse(
                                              taskDetail.taskDate);
                                          return DateFormat('yyyy MMM dd')
                                              .format(date);
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
                              const Icon(Icons.flag,
                                  color: Colors.blue, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                taskDetail.taskDueDate.isNotEmpty
                                    ? (() {
                                        try {
                                          final date = DateTime.parse(
                                              taskDetail.taskDueDate);
                                          return DateFormat('yyyy MMM dd')
                                              .format(date);
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: employe
                            ? [
                                Text(
                                  'Task Feedback',
                                  style: semibold12_5.copyWith(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.taskDetail.feedback,
                                  style: regular14.copyWith(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                              ]
                            : [],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: superadmin
                            ? [
                                Text(
                                  'Feedback',
                                  style: semibold12_5.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                TextField(
                                  controller: _feedbackController,
                                  maxLines: 4,
                                  onChanged: (value) => (),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    hintText: 'Enter your Feedback',
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),
                                const SizedBox(height: 30),
                              ]
                            : [],
                      ),
                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: BlocListener<UpdateTaskBloc, UpdateTaskState>(
                          listener: (context, state) {
                            if (state is TaskDetailSuccessState) {
                              Navigator.pop(
                                  context); // Close the loading dialog
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Task progress updated to $_selectedProgress'),
                                ),
                              );
                            }
                            if (state is UpdateTaskSuccessState) {
                              Navigator.pop(
                                  context); // Close the loading dialog
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                ),
                              );
                            }
                          },
                          child: TextButton(
                            onPressed: () {
                              // Trigger update progress when button is pressed
                              int taskId = int.parse(widget.taskId);
                              context.read<UpdateTaskBloc>().add(
                                    UpdateTaskFetchEvent(
                                      idTask: taskId,
                                      idPoint: state.taskDetail.id_point,
                                      taskName: state.taskDetail.taskName,
                                      taskProgres: _selectedProgress,
                                      taskDate: state.taskDetail.taskDate,
                                      taskDueDate: state.taskDetail.taskDueDate,
                                      taskDocs: state.taskDetail.taskDocs,
                                      feedback: _feedbackController.text,
                                      idPic: state.taskDetail.id_pic,
                                      idSvp: state.taskDetail.id_svp,
                                    ),
                                  );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: primary, // Warna latar belakang
                              padding: const EdgeInsets.symmetric(
                                vertical: 10, // Padding atas dan bawah
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: BlocBuilder<UpdateTaskBloc, UpdateTaskState>(
                              builder: (context, state) {
                                if (state is UpdateTaskLoadingState) {
                                  // Show spinner when loading
                                  return const CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                }
                                return Text(
                                  'Update Progress',
                                  style: regular12_5.copyWith(
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
      ),
    );
  }
}
