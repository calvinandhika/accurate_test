class CityModel {
  final List<CityModelData> cityModelList;

  CityModel({required this.cityModelList});
}

class CityModelData {
  final String name;
  final String id;

  CityModelData({
    required this.name,
    required this.id,
  });
}
