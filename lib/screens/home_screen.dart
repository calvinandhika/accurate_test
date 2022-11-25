import 'package:accurate_test/bloc/user_bloc.dart';
import 'package:accurate_test/constants/route.dart';
import 'package:accurate_test/constants/style.dart';
import 'package:accurate_test/utilities/utilities.dart';
import 'package:accurate_test/widgets/user_list_tile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    context.read<UserBloc>().add(
          const UserEventFetching(nameSearch: ''),
        );
    super.initState();
  }

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
                  context.read<UserBloc>().add(
                        UserEventFetching(
                          nameSearch: value,
                        ),
                      );
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
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserStateLoaded) {
                    if (state.exception != null) {
                      final dioError = state.exception as DioError;
                      showErrorDialog(
                        title: 'Error Occured',
                        body: dioError.message,
                        context: context,
                      );
                    }
                  }
                },
                builder: (context, state) {
                  if (state is UserStateFetching) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is UserStateLoaded) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.userModel?.userModelList.isEmpty ?? true) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: Text('No User Found'),
                        ),
                      );
                    } else {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.userModel?.userModelList.length ?? 0,
                        physics: const ClampingScrollPhysics(),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return UserListTile(
                            user: state.userModel?.userModelList[index],
                          );
                        },
                      );
                    }
                  } else {
                    return const Center(
                      child: Text('Problem Occur'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
