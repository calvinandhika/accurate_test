import 'package:accurate_test/bloc/user_bloc.dart';
import 'package:accurate_test/constants/enum.dart';
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
  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String cityFilter = '';
  SortByName? sortByName;

  void emptySearch() {
    context.read<UserBloc>().add(
          const UserEventFetching(nameSearch: ''),
        );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userList?.length ?? 0,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final user = state.userModel?.userModelList[index];
                        if (cityFilter != '') {
                          if (user?.city == cityFilter) {
                            return UserListTile(
                              user: user,
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          return UserListTile(
                            user: user,
                          );
                        }
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
            selected: sortByName == SortByName.ascending,
            onSelected: (value) {
              setState(() {
                if (value) {
                  sortByName = SortByName.ascending;
                  context.read<UserBloc>().add(
                        UserEventFetching(
                          nameSearch: searchController.text,
                          sortByName: SortByName.ascending,
                        ),
                      );
                } else {
                  sortByName = null;
                  context.read<UserBloc>().add(
                        UserEventFetching(
                          nameSearch: searchController.text,
                          sortByName: null,
                        ),
                      );
                }
              });
            },
            label: const Text('Ascending'),
          ),
          const SizedBox(width: 5),
          ChoiceChip(
            selected: sortByName == SortByName.descending,
            onSelected: (value) {
              setState(() {
                if (value) {
                  sortByName = SortByName.descending;
                  context.read<UserBloc>().add(
                        UserEventFetching(
                          nameSearch: searchController.text,
                          sortByName: SortByName.descending,
                        ),
                      );
                } else {
                  sortByName = null;
                  context.read<UserBloc>().add(
                        UserEventFetching(
                          nameSearch: searchController.text,
                          sortByName: null,
                        ),
                      );
                }
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
                      child: ChoiceChip(
                        selected: cityFilter == cityList?[index].name,
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              cityFilter = cityList?[index].name ?? '';
                            } else {
                              cityFilter = '';
                            }
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
        controller: searchController,
        decoration: const InputDecoration(
          hintText: 'Search User Here, Empty to Search All',
          icon: Icon(
            Icons.search,
          ),
        ),
        onFieldSubmitted: (value) {
          cityFilter = '';
          context.read<UserBloc>().add(
                UserEventFetching(
                  nameSearch: value,
                  sortByName: sortByName,
                ),
              );
        },
        onChanged: (value) {
          if (value.isEmpty) {
            context.read<UserBloc>().add(
                  UserEventFetching(
                    nameSearch: '',
                    sortByName: sortByName,
                  ),
                );
          }
        },
        // takut beratin server
        // onChanged: (value) {
        //   cityFilter = '';
        //   context.read<UserBloc>().add(
        //         UserEventFetching(
        //           nameSearch: value,
        //         ),
        //       );
        // },
      ),
    );
  }
}
