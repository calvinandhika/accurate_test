import 'package:accurate_test/constants/route.dart';
import 'package:accurate_test/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = {
      'nama': 'calvin',
      'alamat': 'bekasi',
    };
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '${userRoute}123123',
          parameters: data,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.lightBlue[100],
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: Row(children: [
            const SizedBox(
              width: 40,
              child: Icon(
                Icons.person_outline,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yovi - 08982313 123',
                      style: MainStyle.headerStyle,
                    ),
                    Text(
                      'calvin.andhika@gmail.com',
                      overflow: TextOverflow.ellipsis,
                      style: MainStyle.bodyStyle,
                    ),
                    Text(
                      'Jalan Taman Cendana 2 asdasd asdasd asdasdasd aasda asda',
                      overflow: TextOverflow.ellipsis,
                      style: MainStyle.bodyStyle,
                    ),
                    Text(
                      'Tangerang',
                      style: MainStyle.bodyStyle,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
