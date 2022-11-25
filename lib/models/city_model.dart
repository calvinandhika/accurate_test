class CityModel {
  final List<CityModelData> cityModelList;

  CityModel({required this.cityModelList});

  factory CityModel.fromJson(List<Map<String, dynamic>> json) {
    List<CityModelData> data = [];
    for (var value in json) {
      data.add(
        CityModelData.fromJson(value),
      );
    }
    return CityModel(cityModelList: data);
  }
}

class CityModelData {
  final String name;
  final String id;

  CityModelData({
    required this.name,
    required this.id,
  });

  factory CityModelData.fromJson(Map<String, dynamic> json) {
    return CityModelData(
      name: json['name'],
      id: json['id'],
    );
  }
}
