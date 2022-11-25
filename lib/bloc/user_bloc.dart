import 'package:accurate_test/constants/enum.dart';
import 'package:accurate_test/models/city_model.dart';
import 'package:accurate_test/models/user_model.dart';
import 'package:accurate_test/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserStateFetching(isLoading: true)) {
    on<UserEventFetching>(
      (event, emit) async {
        emit(
          const UserStateLoaded(
            userModel: null,
            isLoading: true,
            exception: null,
          ),
        );
        try {
          final userService = UserService();
          final users = await userService.getUser(
            nameSearch: event.nameSearch,
          );
          emit(
            UserStateLoaded(
              userModel: users,
              exception: null,
              isLoading: false,
            ),
          );
        } on DioError catch (e) {
          emit(
            UserStateLoaded(
              userModel: null,
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );
  }
}
