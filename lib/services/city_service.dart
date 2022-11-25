import 'package:accurate_test/constants/config.dart';
import 'package:accurate_test/models/city_model.dart';
import 'package:dio/dio.dart';

class CityService {
  Future<CityModel> getCities() async {
    try {
      var dio = Dio();
      final response = await dio.get(
        GlobalConfig.CITY_API_URL,
        options: Options(
          validateStatus: (status) => true,
        ),
      );
      return CityModel.fromJson(response.data);
    } on DioError catch (_) {
      rethrow;
    }
  }
}
