import 'dart:io';

import 'package:daytaskapp/app/config/server_config.dart';
import 'package:daytaskapp/utils/constants/api_path.dart';
import 'package:daytaskapp/utils/preferences/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:path_provider/path_provider.dart';

class FileDownload {
  Dio dio = Dio();
  bool isSuccess = false;

  String generateFileName(String start, String end) {
    DateFormat dateFormat = DateFormat('yyyy_MM_dd');
    String startDateFormatted = dateFormat.format(DateTime.parse(start));
    String endDateFormatted = dateFormat.format(DateTime.parse(end));

    return "report_${startDateFormatted}_to_${endDateFormatted}.pdf";
  }

  Future<void> startDownloading(
    BuildContext context, 
    final Function okCallback,
    String id,
    String start,
    String end,
  ) async {
    String url = ServerConfig.mainBaseUrl + ApiPath.v1 + ApiPath.report;
    String fileName = generateFileName(start, end);
    String baseUrl = "$url/?id=$id&start=$start&end=$end";
    String path = await _getFilePath(fileName);

    var headers = {
      'Authorization': await getToken(),
    };

    try {
      await dio.download(
        baseUrl,
        path,
        options: Options(headers: headers),
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes > 0) {
            okCallback(receivedBytes, totalBytes);  // Update progress
          }
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception: $e");
    }

    // When download is successful, close the dialog and show success dialog
    if (isSuccess) {
      print("Download Success");
      Navigator.pop(context);  // Close the download progress dialog

      // Show success dialog
      _showSuccessDialog(context);
    } else {
      print("Download Failed");
      Navigator.pop(context);  // Close the dialog if there was an error
    }
  }

  // Function to show success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Download successfully!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/');  // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}/$filename";
  }
}
