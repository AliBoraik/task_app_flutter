import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/controller/task_controller.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final TaskController taskController;
  UserBloc({
    required this.taskController,
  }) : super(UserInitial()) {
    on<SaveNameEvent>((event, emit) async {
      emit(LoadingUserState());
      var result = await taskController.saveUserName(event.name);
      result.fold(
        (left) {},
        (right) {
          emit(SavedNameState(event.name));
        },
      );
    });
    on<CheckUserEvent>((event, emit) async {
      emit(LoadingUserState());
      var result = await taskController.getUserName();
      result.fold(
        (left) {},
        (right) {
          emit(SavedNameState(right));
        },
      );
    });
    on<RemoveUserNameEvent>((event, emit) async {
      emit(LoadingUserState());
      var result = await taskController.getUserName();
      result.fold(
        (left) {},
        (right) {
          emit(SavedNameState(right));
        },
      );
    });
  }
}
