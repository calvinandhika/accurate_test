import 'package:accurate_test/constants/route.dart';
import 'package:accurate_test/constants/style.dart';
import 'package:accurate_test/widgets/user_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accurate Test'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(addNewUserRoute);
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Form(
          key: formKey,
          child: ListView(
            primary: false,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search User Here',
                  icon: Icon(
                    Icons.search,
                  ),
                ),
                onFieldSubmitted: (value) {
                  print(value);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Sort by Name: ',
                style: MainStyle.bodyStyle,
              ),
              Wrap(
                children: [
                  ChoiceChip(
                    selected: isSelected,
                    onSelected: (value) {
                      setState(() {
                        isSelected = !isSelected;
                      });
                    },
                    label: const Text('Ascending'),
                  ),
                  const SizedBox(width: 5),
                  ChoiceChip(
                    selected: isSelected,
                    onSelected: (value) {
                      setState(() {
                        isSelected = !isSelected;
                      });
                    },
                    label: const Text('Descending'),
                  ),
                ],
              ),
              Text(
                'Sort by City: ',
                style: MainStyle.bodyStyle,
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FilterChip(
                      selected: isSelected,
                      onSelected: (value) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      label: const Text('Jakarta Dan Sekitarnya'),
                    ),
                    const SizedBox(width: 5),
                    FilterChip(
                      selected: isSelected,
                      onSelected: (value) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      label: const Text('Bekasi dan sekitarnya'),
                    ),
                    const SizedBox(width: 5),
                    FilterChip(
                      selected: isSelected,
                      onSelected: (value) {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      label: const Text('Bandung dan sekitarnya'),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 10,
                physics: const ClampingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) {
                  return const UserListTile();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
