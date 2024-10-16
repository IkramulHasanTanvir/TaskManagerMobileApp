import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/summary_card.dart';
import 'package:task_manager_mobile_app/ui/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundColor,
        onPressed: _onTapFAB,
        child: const Icon(
          Icons.add,
          color: AppColors.foregroundColor,
        ),
      ),
      body: Column(
        children: [
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SummaryCard(count: 9, title: 'New'),
                  SummaryCard(count: 8, title: 'Completed'),
                  SummaryCard(count: 0, title: 'Cancel'),
                  SummaryCard(count: 500, title: 'Progress'),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return const TaskCard();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapFAB() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }
}
