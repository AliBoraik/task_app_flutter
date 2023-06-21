part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SaveNameEvent extends UserEvent {
  final String name;

  const SaveNameEvent(this.name);
}

class CheckUserNameEvent extends UserEvent {}

class RemoveUserNameEvent extends UserEvent {}
