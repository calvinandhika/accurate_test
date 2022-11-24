// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final List<UserModelData> userModelList;
  UserModel({
    required this.userModelList,
  });
}

class UserModelData {
  final String? name;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? city;
  final String? id;

  UserModelData({
    required this.name,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.id,
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

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "email": email,
      "phoneNumber": phoneNumber,
      "city": city,
      "id": id,
    };
  }
}
