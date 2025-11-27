import 'package:daytaskapp/feature/postask/bloc/user_list_bloc.dart';
import 'package:daytaskapp/feature/postask/widget/bottom_sheet.dart';
import 'package:daytaskapp/feature/report/widget/DownloadProgressDialog.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  int? _selectedUserId;
  String? _selectedUserName;
  String? roleId;

  @override
  void initState() {
    super.initState();
    gettingRoleId();
    context.read<UserListBloc>().add(const FetchUserListEvent());
  }

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

  void gettingRoleId() async {
    final role = await getRoleId();
    setState(() {
      roleId = role;
    });
  }

  // Fungsi untuk memulai proses download laporan
  Future<void> _downloadReport() async {
    final userId = await getUserId();

    if (_startDate == null || _endDate == null || userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both start and end dates")),
      );
      return;
    }

    // Format tanggal
    String formattedStart = DateFormat('yyyy-MM-dd').format(_startDate!);
    String formattedEnd = DateFormat('yyyy-MM-dd').format(_endDate!);

    // Meminta izin penyimpanan
    bool hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission is required")),
      );
      return;
    }

    // Menampilkan dialog unduhan
    showDialog(
      context: context,
      builder: (dialogContext) {
        return DownloadProgressDialog(
          start: formattedStart,
          end: formattedEnd,
          id: roleId == '1' ? _selectedUserId.toString() : userId,
        );
      },
    );

    // Mengirimkan event ke BLoC
    // context.read<ReportBloc>().add(
    //   DownloadReportEvent(
    //     id: userId,
    //     start: formattedStart,
    //     end: formattedEnd,
    //   ),
    // );
  }

  // Meminta izin penyimpanan
  static Future<bool> _requestStoragePermission() async {
    final status = await Permission.manageExternalStorage.request();
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      throw "Please allow storage permission to upload files";
    }

    return status.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Download Report"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                // Start Date Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Start Date",
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

                // End Date Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "End Date",
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
            Container(
              child: roleId == '1'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Select User',
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
                                          _selectedUserName =
                                              selectedItem['name'];
                                        });
                                      },
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Colors.grey, width: 1),
                                    ),
                                  ),
                                  child: _selectedUserName != null
                                      ? Text(_selectedUserName!,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54))
                                      : SvgPicture.asset(
                                          'assets/icons/ic_plus_inactive.svg',
                                          width: 30,
                                          height: 30,
                                        ),
                                );
                              } else if (state is UserListErrorState) {
                                return const Center(
                                    child:
                                        Text('Error when getting user list!'));
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _downloadReport,
                style: TextButton.styleFrom(
                  backgroundColor: primary, // Warna latar belakang
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Download Report',
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
    );
  }
}
