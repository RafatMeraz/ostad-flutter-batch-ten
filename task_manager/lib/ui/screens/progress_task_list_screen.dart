import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/data/urls.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import 'package:task_manager/ui/widgets/task_card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _getProgressTasksInProgress = false;
  List<TaskModel> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProgressTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
        visible: _getProgressTasksInProgress == false,
        replacement: CenteredCircularProgressIndicator(),
        child: ListView.builder(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskType: TaskType.progress,
              taskModel: _progressTaskList[index],
              onStatusUpdate: () {
                _getProgressTaskList();
              },
            );
          },
        ),
      ),
    );
  }


  Future<void> _getProgressTaskList() async {
    _getProgressTasksInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller
        .getRequest(url: Urls.getProgressTasksUrl);

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }

    _getProgressTasksInProgress = false;
    setState(() {});
  }
}
