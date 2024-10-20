import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/data/models/task_model.dart';
import 'package:task_manager_mobile_app/ui/widgets/neu_box.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.grey[200],
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              widget.taskModel.description ?? '',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${widget.taskModel.createdDate}',
              style: textTheme.labelSmall,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusChip(textTheme),
                _buildButtonBar()
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(TextTheme textTheme) {
    return NeuBox(
                child: Chip(
                  label: Text(
                    'New',
                    style: textTheme.labelSmall,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: Colors.grey.shade200,
                  side: const BorderSide(color: Colors.green),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(104),
                      bottomRight: Radius.circular(104),
                    ),
                  ),
                ),
              );
  }

  Widget _buildButtonBar() {
    return Wrap(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      (Icons.edit_document),
                      color: Colors.blue.shade300,
                      size: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      (Icons.delete_outline),
                      color: Colors.red,
                      size: 22,
                    ),
                  ),
                ],
              );
  }
}
