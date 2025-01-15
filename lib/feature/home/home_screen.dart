import 'package:daytaskapp/feature/home/bloc/task_bloc.dart';
import 'package:daytaskapp/feature/home/view/priority_view.dart';
import 'package:daytaskapp/feature/home/view/task_list_view.dart';
import 'package:daytaskapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/categories_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedPriority; 
  String? keyword; 
  // Controller untuk TextField
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // Membersihkan controller saat widget dihapus
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    setState(() {
      keyword = _searchController.text;
    });
  }

  void _onPrioritySelected(String? param) {
    setState(() {
      selectedPriority = param;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _searchController,
                  onSubmitted: (value) => {_onSearch()},
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
                PriorityView(onPrioritySelected: _onPrioritySelected), // Pass callback
                const SizedBox(height: 15),
                TaskListView(
                  priority: selectedPriority,
                  keyword: keyword
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
