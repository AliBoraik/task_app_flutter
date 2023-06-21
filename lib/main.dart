import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/presentation/bloc/task/task_bloc.dart';
import 'package:task/presentation/bloc/user/user_bloc.dart';
import 'package:task/presentation/screens/home/home_screen.dart';
import 'package:task/presentation/screens/welcome/welcome_screen.dart';
import 'package:task/presentation/screens/details/add_task_screen.dart';
import 'package:task/presentation/screens/details/detail_task_screen.dart';
import 'core/constants/colors.dart';
import 'core/constants/strings.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'presentation/screens/welcome/widgets/loading_widget.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context) => sl<TaskBloc>()..add(GetAllTasksEvent()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => sl<UserBloc>()..add(CheckUserNameEvent()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kMaterialAppTitle,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        home: BlocBuilder<UserBloc, UserState>(
          builder: (BuildContext context, state) {
            if (state is LoadingUserState) {
              return const LoadingScreen();
            }
            if (state is SavedNameState) {
              return const HomeScreen();
            }
            return const WelcomeScreen();
          },
        ),
        routes: {
          TaskDetailScreen.routeName: (ctx) => const TaskDetailScreen(),
          AddTaskScreen.routeName: (ctx) => const AddTaskScreen(),
        },
      ),
    );
  }
}
