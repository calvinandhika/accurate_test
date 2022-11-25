import 'package:accurate_test/constants/enum.dart';
import 'package:accurate_test/models/city_model.dart';
import 'package:accurate_test/models/user_model.dart';
import 'package:accurate_test/services/city_service.dart';
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
              cityModel: null),
        );
        try {
          final userService = UserService();
          final cityService = CityService();

          final users = await userService.getUsers(
            nameSearch: event.nameSearch,
          );
          final cities = await cityService.getCities();

          if (event.sortByName != null) {
            if (event.sortByName == SortByName.ascending) {
              users.userModelList.sort(
                (a, b) =>
                    a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
              );
            } else {
              users.userModelList.sort(
                (b, a) =>
                    a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
              );
            }
          }

          emit(
            UserStateLoaded(
              userModel: users,
              exception: null,
              isLoading: false,
              cityModel: cities,
            ),
          );
        } on DioError catch (e) {
          emit(
            UserStateLoaded(
              userModel: null,
              exception: e,
              isLoading: false,
              cityModel: null,
            ),
          );
        }
      },
    );

    on<UserEventAddNewUser>(
      (event, emit) async {
        final currentState = (state as UserStateLoaded).copyWith();
        final userModelList = currentState.userModel?.userModelList;

        emit(
          (state as UserStateLoaded).copyWith(
            isLoading: true,
          ),
        );
        userModelList?.add(event.user);

        try {
          final userService = UserService();
          final newUser = await userService.addNewUser(event.user);
          // final newUser = UserModelData(
          //   name: "calvin",
          //   address: "address",
          //   city: "bekaso",
          //   email: "calvin@gmail.com",
          //   phoneNumber: "0822",
          // );

          emit(
            (state as UserStateLoaded).copyWith(
              userModel: currentState.userModel,
              newUser: newUser,
              isLoading: false,
            ),
          );
        } on DioError catch (e) {
          emit(
            (state as UserStateLoaded).copyWith(
              isLoading: false,
              exception: e,
            ),
          );
        }
      },
    );
  }
}
