import 'package:accurate_test/constants/route.dart';
import 'package:accurate_test/constants/style.dart';
import 'package:accurate_test/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListTile extends StatelessWidget {
  final UserModelData? user;
  const UserListTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          '$userRoute${user?.id}',
          parameters: user?.toJson(),
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
          child: Row(
            children: [
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
                        '${user?.name} - ${user?.phoneNumber}',
                        style: MainStyle.headerStyle,
                      ),
                      Text(
                        user?.email ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: MainStyle.bodyStyle,
                      ),
                      Text(
                        user?.address ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: MainStyle.bodyStyle,
                      ),
                      Text(
                        user?.city ?? '',
                        style: MainStyle.bodyStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
