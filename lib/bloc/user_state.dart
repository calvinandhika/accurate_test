part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final bool isLoading;
  const UserState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class UserStateFetching extends UserState {
  const UserStateFetching({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class UserStateLoaded extends UserState {
  final UserModel? userModel;
  final Exception? exception;
  final CityModel? cityModel;
  final UserModelData? newUser;

  const UserStateLoaded({
    required this.userModel,
    required this.exception,
    required this.cityModel,
    this.newUser,
    required bool isLoading,
  }) : super(isLoading: isLoading);

  UserStateLoaded copyWith({
    UserModel? userModel,
    Exception? exception,
    CityModel? cityModel,
    UserModelData? newUser,
    bool? isLoading,
  }) =>
      UserStateLoaded(
        userModel: userModel ?? this.userModel,
        exception: exception ?? this.exception,
        cityModel: cityModel ?? this.cityModel,
        newUser: newUser ?? this.newUser,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [isLoading, userModel];
}
