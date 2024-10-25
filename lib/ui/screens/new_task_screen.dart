import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/data/models/network_response.dart';
import 'package:task_manager_mobile_app/ui/data/models/task_list_model.dart';
import 'package:task_manager_mobile_app/ui/data/models/task_model.dart';
import 'package:task_manager_mobile_app/ui/data/services/network_caller.dart';
import 'package:task_manager_mobile_app/ui/data/utils/urls.dart';
import 'package:task_manager_mobile_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/snackBarMessage.dart';
import 'package:task_manager_mobile_app/ui/widgets/summary_card.dart';
import 'package:task_manager_mobile_app/ui/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  List<TaskModel> _newTaskList = [];
  bool inProgress = false;

  @override
  void initState() {
    _getNewTaskList();
    super.initState();
  }

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
      body: Visibility(
        visible: !inProgress,
        replacement: const Center(child: CircularProgressIndicator()),
        child: RefreshIndicator(
          onRefresh: () async {
            _getNewTaskList();
          },
          child: Column(
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
                    itemCount: _newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskModel: _newTaskList[index],
                        onTapDelete: _getNewTaskList,
                        onTapUpdate: _getNewTaskList,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh == true) {
      _getNewTaskList();
    }
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    inProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.newTaskList,
    );

    if (response.isSuccess) {
      final TaskListModel taskListModel =
          TaskListModel.fromJson(response.responseBody);

      _newTaskList = taskListModel.taskList ?? [];
    } else {
      snackBarMessage(context, response.errorMessage, true);
    }
    inProgress = false;
    setState(() {});
  }
}
