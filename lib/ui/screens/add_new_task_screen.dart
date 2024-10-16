import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/data/models/network_response.dart';
import 'package:task_manager_mobile_app/ui/data/services/network_caller.dart';
import 'package:task_manager_mobile_app/ui/data/utils/urls.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';
import 'package:task_manager_mobile_app/ui/widgets/snackBarMessage.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        title: _buildTitleSection(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(labelText: 'title'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty == true) {
                        return 'Enter valid title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 6,
                    decoration: const InputDecoration(labelText: 'description'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty == true) {
                        return 'Enter a value';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: !_inProgress,
                    replacement: const CircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapAddButton,
                      child: const Text('ADD'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'Add New \nTask!',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  void _onTapAddButton() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    _addTask();
  }

  Future<void> _addTask() async {
    _inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New"
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createTask,
      body: requestBody,
    );
    _inProgress = false;
    setState(() {});
    if(response.isSuccess){
      Navigator.pop(context);
      _clearField();
      snackBarMessage(context, 'New task added');
    }else{
      snackBarMessage(context, response.errorMessage, true);
    }
  }

  void _clearField(){
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
