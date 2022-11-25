import 'package:accurate_test/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailUserScreen extends StatelessWidget {
  const DetailUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = Get.parameters['name']!;
    final address = Get.parameters['address']!;
    final email = Get.parameters['email']!;
    final phoneNumber = Get.parameters['phoneNumber']!;
    final city = Get.parameters['city']!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calvin Andhika'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              userProfilePicture(),
              const SizedBox(height: 20),
              userTitle(name),
              userBody(phoneNumber),
              userBody(email),
              const SizedBox(height: 20),
              userBody(address),
              userBody(city),
            ],
          ),
        ),
      ),
    );
  }

  Text userBody(String body) {
    return Text(
      body,
      textAlign: TextAlign.center,
      style: MainStyle.bodyStyle.copyWith(
        fontSize: 18,
      ),
    );
  }

  Text userTitle(String name) {
    return Text(
      name,
      style: MainStyle.headerStyle.copyWith(
        fontSize: 22,
      ),
    );
  }

  Container userProfilePicture() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(300),
      ),
      child: const Icon(
        Icons.person,
        size: 175,
      ),
    );
  }
}
