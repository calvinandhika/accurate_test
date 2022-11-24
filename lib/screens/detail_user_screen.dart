import 'package:accurate_test/constants/style.dart';
import 'package:flutter/material.dart';

class DetailUserScreen extends StatelessWidget {
  const DetailUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final user = Get.parameters['user'];
    // final arguments = Get.parameters['alamat'];

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
              userTitle('Calvin Andhika'),
              userBody('0822 9884 7474'),
              userBody('calvin.andhika@gmail.com'),
              const SizedBox(height: 20),
              userBody(
                  'Jalan Taman cendana 2 p2 no 10 bekasi selatam jalan temen dasmskw'),
              userBody('Bekasi'),
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
