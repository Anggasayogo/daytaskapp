import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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

  // Fungsi untuk memanggil API download
  void _downloadReport() {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both start and end dates")),
      );
      return;
    }

    String formattedStart = DateFormat('yyyy-MM-dd').format(_startDate!);
    String formattedEnd = DateFormat('yyyy-MM-dd').format(_endDate!);

    // Simulasi API call
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text("Downloading report from $formattedStart to $formattedEnd")),
    );

    // Di sini tambahkan kode HTTP untuk download laporan
    // Contoh API call menggunakan Dio atau http package
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
                Flexible(
                  flex: 1,
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
                Flexible(
                  flex: 1,
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
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: _downloadReport,
                style: TextButton.styleFrom(
                  backgroundColor: primary, // Warna latar belakang
                  padding: const EdgeInsets.symmetric(
                    vertical: 15, // Padding atas dan bawah
                  ),
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
