import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_mobile_app/ui/data/models/network_response.dart';
import 'package:task_manager_mobile_app/ui/data/models/task_model.dart';
import 'package:task_manager_mobile_app/ui/data/services/network_caller.dart';
import 'package:task_manager_mobile_app/ui/data/utils/urls.dart';
import 'package:task_manager_mobile_app/ui/widgets/neu_box.dart';
import 'package:task_manager_mobile_app/ui/widgets/snackBarMessage.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskModel,
    required this.onTapDelete, required this.onTapUpdate,
  });

  final TaskModel taskModel;
  final VoidCallback onTapDelete;
  final VoidCallback onTapUpdate;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String date = DateFormat('EEE, M/ d/ y').format(
      DateTime.parse(
        widget.taskModel.createdDate!,
      ),
    );
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
            const SizedBox(height: 6),
            Text(
              widget.taskModel.description ?? '',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Date: $date',
              style: textTheme.labelSmall,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusChip(textTheme),
                _buildButtonBar(),
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
          widget.taskModel.status ?? '',
          style: textTheme.labelSmall,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: Colors.grey.shade200,
        side:  BorderSide(color: _getStatusColor(widget.taskModel.status!),),
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
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return _buildAlertDialog();
                });
          },
          icon: Icon(
            (Icons.edit_document),
            color: Colors.blue.shade300,
            size: 20,
          ),
        ),
        IconButton(
          onPressed: () =>_deleteTask(widget.taskModel.sId!),
          icon: const Icon(
            (Icons.delete_outline),
            color: Colors.red,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: const Text('Update Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ['New', 'Completed', 'Canceled', 'Progress']
            .map((e) => ListTile(
                  onTap: () => _updateTask(widget.taskModel.sId!, e),
                  title: Text(e),
                ))
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Future<void> _updateTask(String taskId, String status) async {
    _inProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: '${Urls.updateTaskStatus}/$taskId/$status');
    if (response.isSuccess) {
      widget.taskModel.status = status;
      widget.onTapUpdate();
      Navigator.pop(context);
      snackBarMessage(context, 'Task Update successfully');
    } else {
      snackBarMessage(context, response.errorMessage, true);
    }
    _inProgress = false;
    setState(() {});
  }

  Future<void> _deleteTask(String taskId) async {
    _inProgress = true;
    setState(() {});
    NetworkResponse response =
    await NetworkCaller.getRequest(url: '${Urls.deleteTask}/$taskId');
    if (response.isSuccess) {
      widget.onTapDelete();
      snackBarMessage(context, 'Task delete successfully');
    } else {
      snackBarMessage(context, response.errorMessage, true);
    }
    _inProgress = false;
    setState(() {});
  }

  Color _getStatusColor(String status){
    switch(status){
      case 'New':
        return Colors.blue;
      case 'Completed' :
        return Colors.green;
      case 'Canceled' :
        return Colors.red;
      case 'Progress' :
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

}
