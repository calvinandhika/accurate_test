import 'package:accurate_test/constants/route.dart';
import 'package:accurate_test/screens/add_user_screen.dart';
import 'package:accurate_test/screens/detail_user_screen.dart';
import 'package:accurate_test/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/route_manager.dart';

void main() => runApp(
      GetMaterialApp(
        initialRoute: homePageRoute,
        getPages: [
          GetPage(name: homePageRoute, page: () => const HomeScreen()),
          GetPage(name: addNewUserRoute, page: () => const AddUserScreen()),
          GetPage(
            name: userDetailRoute,
            page: () => const DetailUserScreen(),
          ),
        ],
        home: const MaterialApp(
          title: 'Accurate Test',
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
