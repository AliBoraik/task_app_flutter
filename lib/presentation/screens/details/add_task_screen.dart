import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task/core/constants/colors.dart';
import 'package:task/core/util/date_time_converter.dart';
import 'package:task/presentation/screens/details/widgets/custom_button.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/task.dart';
import '../../bloc/task/task_bloc.dart';
import 'widgets/custom_input_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  static const routeName = '/addTaskScreen';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late int _selectIndex = 0;
  late IconData _selectedIcon = Icons.person;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  bool isModified = false;
  late String? taskId;

  @override
  Widget build(BuildContext context) {
    if (!isModified) {
      taskId = ModalRoute.of(context)?.settings.arguments as String?;
      if (taskId != null) {
        final task = BlocProvider.of<TaskBloc>(
          context,
          listen: false,
        ).findTaskById(taskId!);
        _titleController.text = task.title;
        _descriptionController.text = task.description;
        _selectIndex = getIndexByColor(task.color);
        _selectedIcon = task.iconData;
        _selectedDate = task.dateTime;
        _startTime = task.dateTime.toTimeOfDay();
      }
      isModified = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add Task",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<IconData>(
                      value: _selectedIcon,
                      onChanged: (IconData? newValue) {
                        setState(() {
                          _selectedIcon = newValue!;
                        });
                      },
                      items: _iconsList.map((IconData icon) {
                        return DropdownMenuItem<IconData>(
                          alignment: Alignment.center,
                          value: icon,
                          child: Icon(icon),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInputField(
                        controller: _titleController,
                        title: "Title",
                        hint: "write your task title",
                        maxLength: 20,
                      ),
                      CustomInputField(
                        controller: _descriptionController,
                        title: "Description",
                        hint: "description",
                        minLines: 2,
                        maxLength: 100,
                      ),
                      CustomInputField(
                        title: "Date",
                        hint: DateFormat.yMEd().format(_selectedDate),
                        widget: IconButton(
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                          ),
                          onPressed: () {
                            _getdateFromUser();
                          },
                        ),
                      ),
                      CustomInputField(
                        title: "Start Time",
                        hint: _startTime.format(context),
                        widget: IconButton(
                          icon: const Icon(
                            Icons.access_time_rounded,
                          ),
                          onPressed: () {
                            _getTimeFromUser();
                          },
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorChooser(),
                  CustomButton(
                    label: taskId == null ? "Create Task" : "Update Task",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        addStartTimeToDate();
                        if (taskId == null) {
                          BlocProvider.of<TaskBloc>(context).add(
                            AddTaskEvent(
                              TaskModel(
                                id: const Uuid().v1(),
                                title: _titleController.text,
                                description: _descriptionController.text,
                                color: getColorValue(),
                                dateTime: _selectedDate,
                                iconData: _selectedIcon,
                              ),
                            ),
                          );
                        } else {
                          BlocProvider.of<TaskBloc>(context).add(
                            UpdateTaskEvent(
                              TaskModel(
                                id: taskId!,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                color: getColorValue(),
                                dateTime: _selectedDate,
                                iconData: _selectedIcon,
                              ),
                            ),
                          );
                        }
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _colorChooser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Color",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? kYellowDark
                        : index == 1
                            ? kBlueDark
                            : kRedDark,
                    child: _selectIndex == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  final List<IconData> _iconsList = [
    Icons.person,
    Icons.school,
    Icons.shopping_bag,
    Icons.favorite,
    Icons.mail,
  ];

  _getdateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 100),
      ),
    );
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    }
  }

  _getTimeFromUser() async {
    TimeOfDay? pickerTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: _startTime,
    );
    if (pickerTime != null) {
      setState(() {
        _startTime = pickerTime;
      });
    }
  }

  void addStartTimeToDate() {
    _selectedDate = _selectedDate.setTimeOfDay(_startTime);
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      elevation: 0,
      title: const Text(
        "add new Task",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Color getColorValue() {
    switch (_selectIndex) {
      case 0:
        return kYellowDark;
      case 1:
        return kBlueDark;
      default:
        return kRedDark;
    }
  }

  int getIndexByColor(Color color) {
    if (color == kYellowDark) {
      return 0;
    } else if (color == kBlueDark) {
      return 1;
    }
    return 2;
  }
}
