import 'package:accurate_test/bloc/user_bloc.dart';
import 'package:accurate_test/constants/route.dart';
import 'package:accurate_test/constants/style.dart';
import 'package:accurate_test/utilities/show_error_dialog.dart';
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

  void emptySearch() {
    context.read<UserBloc>().add(
          const UserEventFetching(nameSearch: ''),
        );
  }

  @override
  void initState() {
    emptySearch();
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
        child: ListView(
          primary: false,
          children: [
            customSearchBar(context),
            const SizedBox(
              height: 10,
            ),
            ...sortByNameWidget(context),
            ...sortByCityWidget(context),
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
                  final userList = state.userModel?.userModelList;
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (userList?.isEmpty ?? true) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Text('No User Found'),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: userList?.length ?? 0,
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
    );
  }

  List<Widget> sortByNameWidget(BuildContext context) {
    return [
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
    ];
  }

  List<Widget> sortByCityWidget(BuildContext context) {
    return [
      Text(
        'Sort by City: ',
        style: MainStyle.bodyStyle,
      ),
      SizedBox(
        height: 50,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserStateLoaded) {
              if (!state.isLoading) {
                final cityList = state.cityModel?.cityModelList;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cityList?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: FilterChip(
                        selected: isSelected,
                        onSelected: (value) {
                          setState(() {
                            isSelected = !isSelected;
                          });
                        },
                        label: Text(cityList?[index].name ?? ''),
                      ),
                    );
                  },
                );
              }
            }
            return const Text('');
          },
        ),
      ),
    ];
  }

  Widget customSearchBar(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: 'Search User Here',
          icon: Icon(
            Icons.search,
          ),
        ),
        onChanged: (value) {
          context.read<UserBloc>().add(
                UserEventFetching(
                  nameSearch: value,
                ),
              );
        },
      ),
    );
  }
}
