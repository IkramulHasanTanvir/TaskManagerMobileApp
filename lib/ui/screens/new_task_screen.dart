import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/widgets/summary_card.dart';
import 'package:task_manager_mobile_app/ui/widgets/task_card.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
