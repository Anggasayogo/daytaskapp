import 'package:daytaskapp/feature/schedule/view/priority_view.dart';
import 'package:daytaskapp/feature/schedule/view/task_list_view.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {
        'title': 'The Logo Process',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'progress': 'In-Progress',
        'date1': '12 Jan 2023',
        'date2': '20 Mar 2023',
      },
      {
        'title': 'Brand Identity',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'progress': 'Completed',
        'date1': '15 Feb 2023',
        'date2': '10 Apr 2023',
      },
      // You may want to avoid duplicates if these are identical entries
      {
        'title': 'Another Task',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'progress': 'Completed',
        'date1': '15 Feb 2023',
        'date2': '10 Apr 2023',
      },
    ];

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            EasyDateTimeLine(
              initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
                // Handle date change
              },
              headerProps: const EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                dateFormatter: DateFormatter.fullDateDMY(),
              ),
              activeColor: Colors.blueAccent,
              dayProps: const EasyDayProps(
                height: 60,
                width: 60,
                todayNumStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                todayStrStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
                todayMonthStrStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Progress',
                style: semibold12_5.copyWith(fontSize: 14, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: PriorityView(),
            ),
            const Flexible(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TaskListView()),
            ),
          ],
        ),
      ),
    );
  }
}
