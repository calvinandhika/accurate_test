// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final List<UserModelData> userModelList;
  UserModel({
    required this.userModelList,
  });

  factory UserModel.fromJson(List<dynamic> json) {
    List<UserModelData> data = [];
    for (var value in json) {
      data.add(UserModelData.fromJson(value));
    }
    return UserModel(userModelList: data);
  }
}

class UserModelData {
  final String? name;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? city;
  final String? id;

  UserModelData({
    this.name,
    this.address,
    this.email,
    this.phoneNumber,
    this.city,
    this.id,
  });

  factory UserModelData.fromJson(Map<String, dynamic> json) {
    return UserModelData(
      name: json["name"] ?? "",
      address: json["address"] ?? "",
      email: json["name"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      city: json["city"] ?? "",
      id: json["id"] ?? "",
    );
  }

  Map<String, String> toJson() {
    return {
      "name": name ?? '',
      "address": address ?? '',
      "email": email ?? '',
      "phoneNumber": phoneNumber ?? '',
      "city": city ?? '',
      "id": id ?? '',
    };
  }
}
