import 'package:accurate_test/bloc/user_bloc.dart';
import 'package:accurate_test/constants/style.dart';
import 'package:accurate_test/models/user_model.dart';
import 'package:accurate_test/utilities/show_error_dialog.dart';
import 'package:accurate_test/utilities/show_loading_dialog.dart';
import 'package:accurate_test/utilities/show_new_user_dialog.dart';
import 'package:accurate_test/widgets/custom_form_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? cityField;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New User'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              CustomFormField(
                title: 'Name',
                controller: nameController,
                textInputType: TextInputType.name,
              ),
              CustomFormField(
                title: 'Email',
                controller: emailController,
                textInputType: TextInputType.emailAddress,
              ),
              CustomFormField(
                title: 'Phone',
                controller: phoneController,
                textInputType: TextInputType.phone,
              ),
              CustomFormField(
                title: 'Address',
                controller: addressController,
                textInputType: TextInputType.streetAddress,
                isBigger: true,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Colors.lightBlue.shade600, width: 2.0),
                ),
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserStateLoaded) {
                      if (state.isLoading) {
                        showLoadingDialog(
                          context: context,
                        );
                      } else if (state.exception != null) {
                        Get.back();
                        final dioError = state.exception as DioError;
                        showErrorDialog(
                          title: 'Error Occured While Registering',
                          body: dioError.message,
                          context: context,
                        );
                      } else if (state.newUser != null) {
                        Get.back();
                        showNewUserDialog(
                          title: 'New Registration Success',
                          body: state.newUser,
                          context: context,
                        );
                        resetAllController();
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is UserStateLoaded) {
                      final cityList = state.cityModel?.cityModelList;
                      return DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: cityField,
                        items: cityList?.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        icon: const Icon(Icons.arrow_drop_down),
                        hint: const Text('City'),
                        isExpanded: true,
                        iconSize: 42,
                        underline: const SizedBox(),
                        onChanged: (value) {
                          setState(() {
                            cityField = value;
                          });
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                ),
                child: Text(
                  'Submit',
                  style: MainStyle.headerStyle,
                ),
                onPressed: () {
                  final name = nameController.text;
                  final email = emailController.text;
                  final phoneNumber = phoneController.text;
                  final address = addressController.text;
                  final city = cityField;

                  final UserModelData user = UserModelData(
                    name: name,
                    address: address,
                    email: email,
                    phoneNumber: phoneNumber,
                    city: city,
                  );

                  context.read<UserBloc>().add(
                        UserEventAddNewUser(user: user),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetAllController() {
    setState(() {
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      addressController.clear();
      cityField = null;
    });
  }
}
