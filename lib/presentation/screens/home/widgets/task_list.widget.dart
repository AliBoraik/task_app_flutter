import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/presentation/screens/details/detail_task_screen.dart';

import '../../../../core/constants/strings.dart';
import '../../../../data/models/task.dart';
import '../../../bloc/task/task_bloc.dart';
import '../../details/add_task_screen.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  const TaskList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: GridView.builder(
        itemCount: tasks.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => index == tasks.length
            ? _buildAddtask(context)
            : _buildtask(context, tasks[index]),
      ),
    );
  }

  Widget _buildAddtask(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AddTaskScreen.routeName,
        );
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        dashPattern: const [10, 10],
        color: Colors.grey,
        strokeWidth: 2,
        child: const Center(
          child: Text(
            kAddTaskText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildtask(BuildContext context, TaskModel task) {
    return Dismissible(
      key: ValueKey(task.id),
      confirmDismiss: (_) {
        return showDialog(
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
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: const Text(kYesText),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(task.id));
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            TaskDetailScreen.routeName,
            arguments: task.id,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: task.color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    task.iconData,
                    color: task.color,
                    size: 35,
                  ),
                  _bulidTaskStatus(
                    task.color.withOpacity(0.2),
                    task.color.withOpacity(1),
                    DateFormat.jm().format(task.dateTime),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                task.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                task.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bulidTaskStatus(
                    task.color.withOpacity(0.2),
                    task.color.withOpacity(1),
                    DateFormat.MMMd().format(task.dateTime),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        task.isCompleted = !task.isCompleted;
                        BlocProvider.of<TaskBloc>(context)
                            .add(UpdateTaskEvent(task));
                      },
                      child: _bulidTaskStatus(
                        Colors.white,
                        Colors.black,
                        task.isCompleted ? kUndoneText : kDoneText,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulidTaskStatus(Color bgColor, Color textColor, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
