part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class SavedNameState extends UserState {
  final String name;
  const SavedNameState(this.name);
}

class LoadingUserState extends UserState {}
