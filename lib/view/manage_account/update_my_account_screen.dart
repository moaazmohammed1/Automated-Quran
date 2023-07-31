import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/my_data_model.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/controllers/cubit/app_cubit.dart';
import 'package:quran_automated/controllers/cubit/app_states.dart';

import 'change_my_password_screen.dart';

class UpdateMyAccountScreen extends StatelessWidget {
  MyDataModel data;
  UpdateMyAccountScreen({required this.data, super.key});
  TextEditingController fNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController tNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController identityNoController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        fNameController.text = data.fName!;
        sNameController.text = data.sName ?? '';
        tNameController.text = data.tName ?? '';
        lNameController.text = data.lName!;
        identityNoController.text = data.identityNo!;
        emailController.text = data.email ?? '';
        phoneNoController.text = data.phone ?? '';
        genderController.text = data.gender!;
        statusController.text = data.status!;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: '${getLang(context, "updateMyAccountTitle")}',
              centerTitle: true),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
                            controller: fNameController,
                            keyboard: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return '${getLang(context, "firstNameIsRequired")}';
                              }
                              return null;
                            },
                            label: '${getLang(context, "firstName")}',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: defaultTextFormField(
                            controller: sNameController,
                            keyboard: TextInputType.text,
                            label: '${getLang(context, "secondName")}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
                            controller: tNameController,
                            keyboard: TextInputType.text,
                            label: '${getLang(context, "thirdName")}',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: defaultTextFormField(
                            controller: lNameController,
                            keyboard: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return '${getLang(context, "lastNameIsRequired")}';
                              }
                              return null;
                            },
                            label: '${getLang(context, "lastName")}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
                            controller: identityNoController,
                            keyboard: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return '${getLang(context, "identityNoIsRequired")}';
                              }
                              return null;
                            },
                            label: '${getLang(context, "identityNo")}',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: defaultTextFormField(
                            controller: phoneNoController,
                            keyboard: TextInputType.number,
                            label: '${getLang(context, "phoneNo")}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    defaultTextFormField(
                      controller: tNameController,
                      keyboard: TextInputType.text,
                      label: '${getLang(context, "email")}',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
                            controller: genderController,
                            readOnly: true,
                            label: '${getLang(context, "gender")}',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: defaultTextFormField(
                            controller: statusController,
                            readOnly: true,
                            label: '${getLang(context, "accountStatus")}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    defaultButton(
                      text: '${getLang(context, "updateButton")}',
                      onPressedFunction: () {
                        if (formKey.currentState!.validate()) {
                          print(
                            '${fNameController.text} ${sNameController.text} ${tNameController.text} ${lNameController.text} ${identityNoController.text} ${emailController.text} ${statusController.text}',
                          );
                          AppCubit.get(context).updateMyAccountData(
                            context,
                            id: data.id!,
                            fName: fNameController.text,
                            sName: sNameController.text,
                            tName: tNameController.text,
                            lName: lNameController.text,
                            identityNo: identityNoController.text,
                            email: emailController.text,
                            phone: phoneNoController.text,
                            gender: genderController.text,
                            password: passwordController.text,
                            status: statusController.text,
                          );
                        }
                      },
                      height: 60.0,
                      fontSizeText: 18.0,
                    ),
                    const SizedBox(height: 20.0),
                    defaultButton(
                      text: '${getLang(context, "changePasswordButton")}',
                      onPressedFunction: () {
                        navigateTo(context, ChangeMyPasswordScreen());
                      },
                      height: 60.0,
                      fontSizeText: 18.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
