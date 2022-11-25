import 'package:accurate_test/constants/config.dart';
import 'package:accurate_test/constants/enum.dart';
import 'package:accurate_test/models/city_model.dart';
import 'package:accurate_test/models/user_model.dart';
import 'package:dio/dio.dart';

class UserService {
  Future<UserModel> getUsers(
      {CityModel? filterByCity,
      UserModel? listOfUser,
      SortByName sortByName = SortByName.ascending,
      String nameSearch = ''}) async {
    try {
      var dio = Dio();
      final response = await dio.get(
        GlobalConfig.USER_URL,
        queryParameters: {
          'name': nameSearch,
        },
        options: Options(
          validateStatus: (status) => true,
        ),
      );
      return UserModel.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }

  Future<UserModelData> addNewUser(UserModelData user) async {
    try {
      var dio = Dio();
      final response = await dio.post(
        GlobalConfig.USER_URL,
        data: user,
        options: Options(
          validateStatus: (status) => true,
        ),
      );
      return UserModelData.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
