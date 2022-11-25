import 'package:accurate_test/bloc/user_bloc.dart';
import 'package:accurate_test/constants/route.dart';
import 'package:accurate_test/screens/add_user_screen.dart';
import 'package:accurate_test/screens/detail_user_screen.dart';
import 'package:accurate_test/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

void main() => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
        ],
        child: GetMaterialApp(
          initialRoute: homePageRoute,
          debugShowCheckedModeBanner: false,
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
      ),
    );
