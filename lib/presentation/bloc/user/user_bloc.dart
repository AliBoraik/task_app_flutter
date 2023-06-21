import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/controller/user_controller.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserController userController;
  late String name = "";
  UserBloc({
    required this.userController,
  }) : super(UserInitial()) {
    on<SaveNameEvent>((event, emit) async {
      emit(LoadingUserState());
      var result = await userController.saveUserName(event.name);
      result.fold(
        (left) {},
        (right) {
          name = event.name;
          emit(SavedNameState(event.name));
        },
      );
    });
    on<CheckUserNameEvent>((event, emit) async {
      emit(LoadingUserState());
      var result = await userController.getUserName();
      result.fold(
        (left) {
          emit(UserInitial());
        },
        (right) {
          name = right;
          emit(SavedNameState(right));
        },
      );
    });
    on<RemoveUserNameEvent>((event, emit) async {
      emit(LoadingUserState());
      var result = await userController.removeUsername();
      name = "";
      result.fold(
        (left) {},
        (right) {
          emit(UserInitial());
        },
      );
    });
    on<EditUserNameEvent>((event, emit) async {
      emit(LoadingUserState());
      var result = await userController.editUserName(event.name);
      result.fold(
        (left) {},
        (right) {
          name = event.name;
          emit(EditedUserState(event.name));
        },
      );
    });
  }
}
