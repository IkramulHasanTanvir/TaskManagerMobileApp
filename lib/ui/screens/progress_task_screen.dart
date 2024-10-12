import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/widgets/task_card.dart';

class ProgressTaskScreen extends StatelessWidget {
  const ProgressTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
      child: ListView.builder(
        itemCount: 9,
        itemBuilder: (context, index) {
          return const TaskCard();
        },
      ),
    );
  }
}
