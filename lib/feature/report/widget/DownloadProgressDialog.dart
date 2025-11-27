import 'package:flutter/material.dart';
import 'package:daytaskapp/utils/common/FileDownload.dart';

class DownloadProgressDialog extends StatefulWidget {
  final String id;
  final String start;
  final String end;

  const DownloadProgressDialog({
    Key? key,
    required this.id,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  State<DownloadProgressDialog> createState() => _DownloadProgressDialogState();
}

class _DownloadProgressDialogState extends State<DownloadProgressDialog> {
  double progress = 0.0;
  bool isDownloading = true;

  @override
  void initState() {
    super.initState();
    _startDownload();
  }

  /// Memulai proses pengunduhan file.
  void _startDownload() {
    FileDownload().startDownloading(
      context, 
      (receivedBytes, totalBytes) {
        if (totalBytes > 0) {
          setState(() {
            progress = receivedBytes / totalBytes;
          });
        }
      },
      widget.id,
      widget.start,
      widget.end,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format persentase pengunduhan.
    String downloadingProgress = (progress * 100).toStringAsFixed(0);

    return AlertDialog(
      title: const Text('Downloading File'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Downloading...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade300,
            color: Colors.green,
            minHeight: 10,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "$downloadingProgress%",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
