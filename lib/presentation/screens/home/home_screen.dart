import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/presentation/bloc/user/user_bloc.dart';
import 'package:task/presentation/screens/details/add_task_screen.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/strings.dart';
import '../../bloc/task/task_bloc.dart';
import '../profile/profile_screen.dart';
import 'widgets/error_widget.dart';
import 'widgets/task_list.widget.dart';

enum PopupMenuHomeOption { deleteAll, logout }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: const Text(
              kTasksHomeTitle,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is LoadedTasksState) {
                  return TaskList(tasks: state.tasks);
                }
                if (state is EmptyState) {
                  return const TaskList(tasks: []);
                }
                if (state is ErrorState) {
                  return OnError(messgae: state.message);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.black87,
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddTaskScreen.routeName,
          );
        },
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 10,
                blurRadius: 10)
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          onTap: (index) {
            if (index == 1) {
              Navigator.of(context).pushNamed(
                ProfileScreen.routeName,
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: kBottomNavigationBarHomeLabel,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: kBottomNavigationBarPresonLabel,
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final name = BlocProvider.of<UserBloc>(context).name;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(left: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(kAppBarAvatarImage),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is EditedUserState) {
                return Text(
                  "$kHiText , ${state.name}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                );
              }
              if (state is LoadingUserState) {
                return const Center(child: CircularProgressIndicator());
              }
              return Text(
                "$kHiText , $name",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              );
            },
          ),
        ],
      ),
      actions: [
        PopupMenuButton(
          onSelected: (PopupMenuHomeOption selectedValue) {
            if (selectedValue == PopupMenuHomeOption.deleteAll) {
              BlocProvider.of<TaskBloc>(context).add(DeleteAllTasksEvent());
            }
            if (selectedValue == PopupMenuHomeOption.logout) {
              BlocProvider.of<UserBloc>(context).add(RemoveUserNameEvent());
            }
          },
          icon: const Icon(
            Icons.more_vert,
            color: Colors.black,
            size: 35,
          ),
          itemBuilder: (_) => [
            const PopupMenuItem(
              value: PopupMenuHomeOption.deleteAll,
              child: Text(kAppBarDeleteAllAction),
            ),
            const PopupMenuItem(
              value: PopupMenuHomeOption.logout,
              child: Text(kAppBarLogoutAction),
            ),
          ],
        ),
      ],
    );
  }
}
