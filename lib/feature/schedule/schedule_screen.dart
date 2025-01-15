import 'package:daytaskapp/feature/schedule/view/priority_view.dart';
import 'package:daytaskapp/feature/schedule/view/task_list_view.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String? selectedPriority;
  String? selectedDatetime;

  void _onPrioritySelected(String? priority) {
    setState(() {
      selectedPriority = priority;
    });
  }

  void _onDatetimeSelected(String? datetime) {
    setState(() {
      selectedDatetime = datetime;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                final date = DateFormat('yyyy-MM-dd').format(selectedDate!);
                _onDatetimeSelected(date);
                print("DATE CHANGGES ${date}");
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PriorityView(
                onPrioritySelected: _onPrioritySelected,
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TaskListView(
                  priority: selectedPriority,
                  datetime: selectedDatetime
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
