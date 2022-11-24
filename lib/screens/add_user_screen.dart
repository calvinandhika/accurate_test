import 'package:accurate_test/constants/style.dart';
import 'package:accurate_test/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final formKey = GlobalKey<FormState>();
  // text editing controller

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
              const CustomFormField(title: 'Name'),
              const CustomFormField(title: 'Email'),
              const CustomFormField(title: 'Phone'),
              const CustomFormField(
                title: 'Address',
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
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  value: null,
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  icon: const Icon(Icons.arrow_drop_down),
                  hint: const Text('City'),
                  isExpanded: true,
                  iconSize: 42,
                  underline: const SizedBox(),
                  onChanged: (_) {
                    print('keubah');
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {},
                child: Text(
                  'Submit',
                  style: MainStyle.headerStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
