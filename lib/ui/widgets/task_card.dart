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
    required this.onTapRefresh,
  });

  final TaskModel taskModel;
  final VoidCallback onTapRefresh;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectStatus = '';
  bool _changeStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  void initState() {
    _selectStatus = widget.taskModel.status!;
    super.initState();
  }

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
        side: BorderSide(
          color: _getStatusColor(widget.taskModel.status!),
        ),
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
        Visibility(
          visible: !_changeStatusInProgress,
          replacement: const CircularProgressIndicator(),
          child: IconButton(
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
        ),
        Visibility(
          visible: !_deleteTaskInProgress,
          replacement: const CircularProgressIndicator(),
          child: IconButton(
            onPressed: _deleteTask,
            icon: const Icon(
              (Icons.delete_outline),
              color: Colors.red,
              size: 22,
            ),
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
                  onTap: () {
                    _updateTask(e);
                    Navigator.pop(context);
                  },
                  title: Text(e),
                  selected: _selectStatus == e,
                  trailing: _selectStatus == e
                      ? const Icon(
                          Icons.check,
                          color: Colors.black,)
                      : null,)).toList(),
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

  Future<void> _updateTask(String newStatus) async {
    _changeStatusInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.updateTaskStatus(widget.taskModel.sId!, newStatus));
    if (response.isSuccess) {
      widget.onTapRefresh();
      snackBarMessage(context, 'Task Update successfully');
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      snackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> _deleteTask() async {
    _deleteTaskInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.deleteTask(widget.taskModel.sId!));
    if (response.isSuccess) {
      widget.onTapRefresh();
      snackBarMessage(context, 'Task delete successfully');
    } else {
      _deleteTaskInProgress = false;
      setState(() {});
      snackBarMessage(context, response.errorMessage, true);
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Canceled':
        return Colors.red;
      case 'Progress':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
