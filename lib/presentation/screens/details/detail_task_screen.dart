import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/models/task.dart';
import 'package:task/presentation/screens/details/add_task_screen.dart';

import '../../../core/constants/strings.dart';
import '../../bloc/task/task_bloc.dart';
import 'widgets/task_detail_view.dart';

enum PopupMenuDetailOption { edit, delete }

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});
  static const routeName = '/taskDetail';
  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context)?.settings.arguments as String;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final task = BlocProvider.of<TaskBloc>(
      context,
      listen: false,
    ).findTaskById(taskId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context, task),
      body: SingleChildScrollView(
        child: TaskDetailView(task: task, barHeight: statusBarHeight),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, TaskModel task) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      actions: [
        PopupMenuButton(
          onSelected: (PopupMenuDetailOption selectedValue) {
            if (selectedValue == PopupMenuDetailOption.delete) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text(kDialogAreYouSureText),
                  content: const Text(
                    kConfirmationText,
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(kNoText),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(kYesText),
                      onPressed: () {
                        BlocProvider.of<TaskBloc>(context)
                            .add(DeleteTaskEvent(task.id));
                        Navigator.of(ctx).popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              );
            }

            if (selectedValue == PopupMenuDetailOption.edit) {
              Navigator.of(context).pushNamed(
                AddTaskScreen.routeName,
                arguments: task.id,
              );
            }
          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 35,
          ),
          itemBuilder: (_) => [
            PopupMenuItem(
              value: PopupMenuDetailOption.delete,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.delete, color: Colors.black),
                  SizedBox(
                    width: 4,
                  ),
                  Text(kDeleteText),
                ],
              ),
            ),
            PopupMenuItem(
              value: PopupMenuDetailOption.edit,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.edit, color: Colors.black),
                  Text(kEditText),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
