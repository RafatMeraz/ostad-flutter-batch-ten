import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleTEController,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 5,
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: _addNewTaskInProgress == false,
                  replacement: CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, String> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createNewTaskUrl,
      body: requestBody,
    );

    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _titleTEController.clear();
      _descriptionTEController.clear();
      showSnackBarMessage(context, 'Added new task');
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
