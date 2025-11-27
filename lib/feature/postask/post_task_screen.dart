import 'package:daytaskapp/feature/postask/bloc/create_task_bloc.dart';
import 'package:daytaskapp/feature/postask/bloc/point_bloc.dart';
import 'package:daytaskapp/feature/postask/bloc/user_list_bloc.dart';
import 'package:daytaskapp/feature/postask/view/priority_view.dart';
import 'package:daytaskapp/feature/postask/widget/bottom_sheet.dart';
import 'package:daytaskapp/feature/postask/widget/dialog.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PostTaskScreen extends StatefulWidget {
  const PostTaskScreen({super.key});

  @override
  State<PostTaskScreen> createState() => _PostTaskScreenState();
}

class _PostTaskScreenState extends State<PostTaskScreen> {
  late DateTime _selectedDate;
  String? _taskTitle;
  String? _taskDocs;
  int? _selectedPriority;
  int? _selectedPointId;
  String? _selectedPointName;
  int? _selectedUserId;
  String? _selectedUserName;
  DateTime? _startDate;
  DateTime? _endDate;

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UserListBloc>().add(const FetchUserListEvent());
    context.read<PointBloc>().add(FetchPointsEvent());
    _selectedDate = DateTime.now();
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  void _onPrioritySelected(int? priority) {
    setState(() {
      _selectedPriority = priority;
    });
  }

  void _onCreateTask () async {
    final _getUserId = await getUserId();

    if (_taskTitle == null || 
        _taskDocs == null || 
        _selectedPriority == null || 
        _getUserId == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );

      return;
    }

    context.read<CreateTaskBloc>().add(CreateTaskButtonPressed(
      idPoint: _selectedPointId ?? 1,
      taskName: _taskTitle ?? '', 
      taskProgres: "asign", 
      taskDate: _startDate.toString(), 
      taskDueDate: _endDate.toString(), 
      taskDocs: _taskDocs ?? '', 
      idPic: _selectedUserId ?? 0, 
      idSvp: int.parse(_getUserId),
      idPriority: _selectedPriority ?? 0
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<CreateTaskBloc, CreateTaskState>(
        listener: (context, state) {
          if (state is CreateTaskSuccessState) {
            ShowSuccessDialog(context);
          } else if (state is CreateTaskErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 20),
              child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Task Date",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _startDate == null
                                ? "Select Start Date"
                                : DateFormat('yyyy-MM-dd').format(_startDate!),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Task Duedate",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _endDate == null
                                ? "Select End Date"
                                : DateFormat('yyyy-MM-dd').format(_endDate!),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Title',
                    style: semibold12_5.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    maxLines: 3,
                    onChanged: (value) => _taskTitle = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter your task title',
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Task Docs Url',
                    style: semibold12_5.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    maxLines: 1,
                    onChanged: (value) => _taskDocs = value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Enter your task docs url',
                    ),
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Priority',
                    style: semibold12_5.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  PriorityView(onPrioritySelected: _onPrioritySelected),
                  const SizedBox(height: 20),
                  Text(
                    'Set Point',
                    style: semibold12_5.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<PointBloc, PointState>(
                      builder: (context, state) {
                        if (state is PointLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is PointLoadedState) {
                          List<Map<String, dynamic>> items =
                              state.pointListResponse.points.map((point) {
                            return {
                              "id": point.idPoint,
                              "name": point.point.toString(),
                            };
                          }).toList();

                          return TextButton(
                            onPressed: () {
                              BottomSheetWithList.show(
                                context,
                                items,
                                (selectedItem) {
                                  var selectedId = selectedItem['id'];
                                  setState(() {
                                    _selectedPointId = selectedId;
                                    _selectedPointName = selectedItem['name'];
                                  });
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                            ),
                            child: _selectedPointName != null
                                ? Text(
                                    _selectedPointName!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54
                                  )) // Gunakan '!' untuk menandakan _selectedPointName tidak null
                                : SvgPicture.asset(
                                    'assets/icons/ic_plus_inactive.svg',
                                    width: 30,
                                    height: 30,
                                  ),
                          );
                        } else if (state is PointErrorState) {
                          return const Center(
                              child: Text('error when getting point list!'));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Assign User',
                    style: semibold12_5.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<UserListBloc, UserListState>(
                      builder: (context, state) {
                        if (state is UserListLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is UserListLoadedState) {
                          List<Map<String, dynamic>> items =
                              state.users.map((user) {
                            return {
                              "id": user.userId,
                              "name": user.username,
                            };
                          }).toList();

                          return TextButton(
                            onPressed: () {
                              BottomSheetWithList.show(
                                context,
                                items,
                                (selectedItem) {
                                  var selectedId = selectedItem['id'];
                                  setState(() {
                                    _selectedUserId = selectedId;
                                    _selectedUserName = selectedItem['name'];
                                  });
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                            ),
                            child: _selectedUserName != null
                                ? Text(
                                    _selectedUserName!
                                  ,style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54
                                  )) // Gunakan '!' untuk menandakan _selectedPointName tidak null
                                : SvgPicture.asset(
                                    'assets/icons/ic_plus_inactive.svg',
                                    width: 30,
                                    height: 30,
                                  ),
                          );
                        } else if (state is UserListErrorState) {
                          return const Center(
                              child: Text('error when getting user list!'));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _onCreateTask,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Create Task',
                        style: semibold12_5.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}
