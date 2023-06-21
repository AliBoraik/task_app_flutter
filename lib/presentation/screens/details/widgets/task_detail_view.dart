import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task/data/models/task.dart';
import 'package:task/core/util/date_time_converter.dart';

class TaskDetailView extends StatelessWidget {
  final TaskModel task;
  final double barHeight;
  const TaskDetailView(
      {super.key, required this.task, required this.barHeight});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appBarHeight = AppBar().preferredSize.height;
    double height = size.height - appBarHeight - barHeight;
    final timeofday = task.dateTime.toTimeOfDay();
    return Column(
      children: [
        Container(
          height: height * 0.08,
          decoration: BoxDecoration(
            color: task.color.withOpacity(0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                task.dateTime.toDMYformattedString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            hourContainer(height, size, timeofday.addhours(-1).format(context)),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(timeofday.addhours(0).format(context)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        color: task.color.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            task.iconData,
                            color: task.color,
                            size: 35,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            task.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            task.description,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: task.color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                DateFormat.jm().format(task.dateTime),
                                style: TextStyle(
                                  color: task.color.withOpacity(1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            hourContainer(height, size, timeofday.addhours(1).format(context)),
            hourContainer(height, size, timeofday.addhours(2).format(context)),
          ],
        ),
      ],
    );
  }

  Container hourContainer(double height, Size size, String data) {
    return Container(
      height: height * 0.23,
      width: size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Text(data),
          ],
        ),
      ),
    );
  }

  Container bulidTaskStatus(Color bgColor, Color textColor, String text) {
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
