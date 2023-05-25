import 'package:flutter/material.dart';
import 'package:quran_automated/shared/components/components.dart';

class AddGCSScreen extends StatefulWidget {
  const AddGCSScreen({super.key});

  @override
  State<AddGCSScreen> createState() => _AddGCSScreenState();
}

const List<String> list = <String>['keep', 'quality'];

class _AddGCSScreenState extends State<AddGCSScreen> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text('add GCS')),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 145),
                child: Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
              ),
              const SizedBox(height: 20),
              defaultTextFormField(
                controller: TextEditingController(),
                onSubmitted: (value) {
                  // if (formKey.currentState!.validate()) {
                  //   // ShopLoginCubit.get(context).userLogin(
                  //   //   email: emailController.text,
                  //   //   password: passwordController.text,
                  //   // );
                  // }
                },
                // validate: (String? value) {
                //   if (value!.isEmpty) {
                //     return 'password is too short';
                //   }
                // },

                label: 'GCS name',
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'GCS job',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              dropDownButton(
                dropdownValue: dropdownValue,
                onChange: (value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'GCS region',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              dropDownButton(
                dropdownValue: dropdownValue,
                onChange: (value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              defaultTextFormField(
                controller: TextEditingController(),
                onSubmitted: (value) {
                  // if (formKey.currentState!.validate()) {
                  //   // ShopLoginCubit.get(context).userLogin(
                  //   //   email: emailController.text,
                  //   //   password: passwordController.text,
                  //   // );
                  // }
                },
                // validate: (String? value) {
                //   if (value!.isEmpty) {
                //     return 'password is too short';
                //   }
                // },

                label: 'GCS branch',
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'number of member in GCS',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              dropDownButton(
                dropdownValue: dropdownValue,
                onChange: (value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
              ),
              const SizedBox(height: 40.0),
              defaultButton(
                text: 'create',
                onPressedFunction: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

dropDownButton({dropdownValue, onChange}) => Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: DropdownButton(
        value: dropdownValue ?? 'keep',
        icon: const Icon(Icons.arrow_drop_down_rounded),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        onChanged: onChange,
        isExpanded: true,
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        dropdownColor: Colors.white,
        iconEnabledColor: Colors.black, //Icon color
      ),
    );
