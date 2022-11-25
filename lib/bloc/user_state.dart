part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final bool isLoading;
  const UserState({required this.isLoading});

  @override
  List<Object> get props => [];
}

class UserStateFetching extends UserState {
  const UserStateFetching({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class UserStateLoaded extends UserState {
  final UserModel? userModel;
  final Exception? exception;

  const UserStateLoaded({
    required this.userModel,
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);

  @override
  List<Object> get props => [isLoading, userModel ?? []];
}
