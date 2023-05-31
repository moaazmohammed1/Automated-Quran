import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';
import '../../shared/network/end_point.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({required this.type, super.key});
  String? type;
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
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: defaultAppBar(
            context: context,
            title: type == 'admin'
                ? 'Add Admin'
                : (type == 'supervisor'
                    ? 'Add Direct Supervisor'
                    : (type == 'keeper'
                        ? 'Add Keeper'
                        : (type == 'student' ? 'Add Student' : ''))),
            centerTitle: true),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
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
                              return 'First Name is required';
                            }
                            return null;
                          },
                          label: 'First name',
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: defaultTextFormField(
                          controller: sNameController,
                          keyboard: TextInputType.text,
                          label: 'Second name (option)',
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
                          label: 'Third name (option)',
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: defaultTextFormField(
                          controller: lNameController,
                          keyboard: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Last Name is required';
                            }
                            return null;
                          },
                          label: 'Last name',
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
                              return 'identity number is required';
                            }
                            return null;
                          },
                          label: 'Identity number',
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: defaultTextFormField(
                          controller: phoneNoController,
                          keyboard: TextInputType.number,
                          label: 'Phone number ( option )',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  defaultTextFormField(
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    onSubmitted: (value) {},
                    label: 'Enter Email (option)',
                  ),
                  const SizedBox(height: 20),
                  defaultTextFormField(
                    controller: passwordController,
                    keyboard: TextInputType.visiblePassword,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'password is required';
                      }
                      return null;
                    },
                    obscurePassword: AppCubit.get(context).isPassword,
                    label: 'Password',
                    suffixIcon: AppCubit.get(context).suffix,
                    onPressedSuffix: () {
                      AppCubit.get(context).changePasswordVisibilityInAdmin();
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          width: double.infinity,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: greyColor,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.all(5),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'male',
                                                    groupValue:
                                                        AppCubit.get(context)
                                                            .selectedGender,
                                                    onChanged: (val) {
                                                      AppCubit.get(context)
                                                          .selectGender(
                                                              gender: 'male');
                                                    },
                                                  ),
                                                  const Text(
                                                    'male',
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 'female',
                                                    groupValue:
                                                        AppCubit.get(context)
                                                            .selectedGender,
                                                    onChanged: (val) {
                                                      AppCubit.get(context)
                                                          .selectGender(
                                                              gender: 'female');
                                                    },
                                                  ),
                                                  const Text(
                                                    'female',
                                                    style: TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  AppCubit.get(context).selectedGender != ''
                                      ? AppCubit.get(context).selectedGender
                                      : 'Gender',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: greyColor,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  size: 25.0,
                                  color: greyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          width: double.infinity,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: greyColor,
                              )),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.all(5),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'active',
                                                  groupValue:
                                                      AppCubit.get(context)
                                                          .selectedStatus,
                                                  onChanged: (val) {
                                                    AppCubit.get(context)
                                                        .selectStatus(
                                                            status: 'active');
                                                  },
                                                ),
                                                const Text(
                                                  'active',
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio(
                                                  value: 'draft',
                                                  groupValue:
                                                      AppCubit.get(context)
                                                          .selectedStatus,
                                                  onChanged: (val) {
                                                    // setState(
                                                    //     () => selectedRadio = val!);
                                                    AppCubit.get(context)
                                                        .selectStatus(
                                                            status: 'draft');
                                                  },
                                                ),
                                                const Text(
                                                  'draft',
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Radio(
                                            //       value: 'block',
                                            //       groupValue:
                                            //           AppCubit.get(context)
                                            //               .selectedStatus,
                                            //       onChanged: (val) {
                                            //         // setState(
                                            //         //     () => selectedRadio = val!);
                                            //         AppCubit.get(context)
                                            //             .selectStatus(
                                            //                 status: 'block');
                                            //       },
                                            //     ),
                                            //     const Text(
                                            //       'block',
                                            //       style:
                                            //           TextStyle(fontSize: 18.0),
                                            //     ),
                                            //   ],
                                            // ),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  AppCubit.get(context).selectedStatus != ''
                                      ? AppCubit.get(context).selectedStatus
                                      : 'Status',
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: greyColor,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  size: 25.0,
                                  color: greyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  defaultButton(
                    text: 'create',
                    onPressedFunction: () {
                      if (formKey.currentState!.validate()) {
                        if (type == 'admin') {
                          AppCubit.get(context).addAdmin(
                            context,
                            fName: fNameController.text,
                            sName: sNameController.text,
                            tName: tNameController.text,
                            lName: lNameController.text,
                            identityNo: identityNoController.text,
                            phone: phoneNoController.text,
                            email: emailController.text,
                            gender: AppCubit.get(context).selectedGender,
                            password: passwordController.text,
                            status: AppCubit.get(context).selectedStatus,
                          );
                        } else if (type == 'supervisor') {
                          AppCubit.get(context).addDirectSupervisor(
                            context,
                            fName: fNameController.text,
                            sName: sNameController.text,
                            tName: tNameController.text,
                            lName: lNameController.text,
                            identityNo: identityNoController.text,
                            phone: phoneNoController.text,
                            email: emailController.text,
                            gender: AppCubit.get(context).selectedGender,
                            password: passwordController.text,
                            status: AppCubit.get(context).selectedStatus,
                          );
                        } else if (type == 'keeper') {
                          AppCubit.get(context).addKeeper(
                            context,
                            fName: fNameController.text,
                            sName: sNameController.text,
                            tName: tNameController.text,
                            lName: lNameController.text,
                            identityNo: identityNoController.text,
                            phone: phoneNoController.text,
                            email: emailController.text,
                            gender: AppCubit.get(context).selectedGender,
                            password: passwordController.text,
                            status: AppCubit.get(context).selectedStatus,
                          );
                        } else if (type == 'student' && position != 'keeper') {
                          AppCubit.get(context).addStudent(
                            context,
                            fName: fNameController.text,
                            sName: sNameController.text,
                            tName: tNameController.text,
                            lName: lNameController.text,
                            identityNo: identityNoController.text,
                            phone: phoneNoController.text,
                            email: emailController.text,
                            gender: AppCubit.get(context).selectedGender,
                            password: passwordController.text,
                            status: AppCubit.get(context).selectedStatus,
                          );
                        } else if (type == 'student' && position == 'keeper') {
                          AppCubit.get(context).addStudentInGroupe(
                            context,
                            fName: fNameController.text,
                            sName: sNameController.text,
                            tName: tNameController.text,
                            lName: lNameController.text,
                            identityNo: identityNoController.text,
                            phone: phoneNoController.text,
                            email: emailController.text,
                            gender: AppCubit.get(context).selectedGender,
                            password: passwordController.text,
                            status: AppCubit.get(context).selectedStatus,
                          );
                        }
                      }
                    },
                    height: 60.0,
                    fontSizeText: 18.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
