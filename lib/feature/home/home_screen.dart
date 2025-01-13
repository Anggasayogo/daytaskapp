import 'package:daytaskapp/app/route/routes/route_path.dart';
import 'package:daytaskapp/feature/home/bloc/priority_bloc.dart';
import 'package:daytaskapp/feature/home/view/priority_view.dart';
import 'package:daytaskapp/feature/home/view/task_list_view.dart';
import 'package:daytaskapp/feature/login/bloc/login_bloc.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'bloc/categories_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      {
        'title': 'Brand Identity',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'progress': 'Completed',
        'date1': '15 Feb 2023',
        'date2': '10 Apr 2023',
      },
    ];

    return BlocProvider<CategoriesBloc>(
      create: (_) => CategoriesBloc()..add(const CategoriesFetchEvent()),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Let’s Finish Your Task',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/images/profile.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Your Task',
                  style:
                      semibold12_5.copyWith(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Find your task here..',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Priority',
                  style:
                      semibold12_5.copyWith(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 15),
                const PriorityView(),
                const SizedBox(height: 15),
                const TaskListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
