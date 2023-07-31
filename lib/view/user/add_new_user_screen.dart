import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';
import '../../controllers/network/end_point.dart';

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
                ? '${getLang(context, "addAdmin")}'
                : (type == 'supervisor'
                    ? '${getLang(context, "addDS")}'
                    : (type == 'keeper'
                        ? '${getLang(context, "addKeeper")}'
                        : (type == 'student'
                            ? '${getLang(context, "addStudent")}'
                            : ''))),
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
                    controller: emailController,
                    keyboard: TextInputType.emailAddress,
                    onSubmitted: (value) {},
                    label: '${getLang(context, "email")}',
                  ),
                  const SizedBox(height: 20),
                  defaultTextFormField(
                    controller: passwordController,
                    keyboard: TextInputType.visiblePassword,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return '${getLang(context, "passwordIsRequired")}';
                      }
                      return null;
                    },
                    obscurePassword: AppCubit.get(context).isPassword,
                    label: '${getLang(context, "password")}',
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
                    text: '${getLang(context, "create")}',
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
