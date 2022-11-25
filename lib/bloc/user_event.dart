// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserEventFetching extends UserEvent {
  final SortByName? sortByName;
  final String nameSearch;

  const UserEventFetching({
    this.sortByName,
    this.nameSearch = "",
  });
}

class UserEventAddNewUser extends UserEvent {
  final UserModelData user;
  const UserEventAddNewUser({
    required this.user,
  });
}
