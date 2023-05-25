import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/shared/components/components.dart';
import '../../models/data_model.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

class UpdateDirectSupervisorScreen extends StatelessWidget {
  Data data;
  UpdateDirectSupervisorScreen({required this.data, super.key});
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
              context: context, title: 'Update Admin', centerTitle: true),
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
                                return 'First Name is required';
                              } return null;
                            },
                            label: 'First name',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: defaultTextFormField(
                            controller: sNameController,
                            keyboard: TextInputType.text,
                            label: 'Second name',
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
                            label: 'Third name',
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
                              } return null;
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
                              } return null;
                            },
                            label: 'Identity number',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: defaultTextFormField(
                            controller: phoneNoController,
                            keyboard: TextInputType.number,
                            label: 'Phone number',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    defaultTextFormField(
                      controller: emailController,
                      keyboard: TextInputType.text,
                      label: 'email',
                    ),
                    // const SizedBox(height: 20),

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: defaultTextFormField(
                    //         controller: TextEditingController(),
                    //         onSubmitted: (value) {
                    //           // if (formKey.currentState!.validate()) {
                    //           //   // ShopLoginCubit.get(context).userLogin(
                    //           //   //   email: emailController.text,
                    //           //   //   password: passwordController.text,
                    //           //   // );
                    //           // }
                    //         },
                    //         // validate: (String? value) {
                    //         //   if (value!.isEmpty) {
                    //         //     return 'password is too short';
                    //         //   }
                    //         // },

                    //         label: 'GSM',
                    //       ),
                    //     ),
                    //     const SizedBox(width: 6),
                    //     Expanded(
                    //       child: defaultTextFormField(
                    //         controller: TextEditingController(),
                    //         onSubmitted: (value) {
                    //           // if (formKey.currentState!.validate()) {
                    //           //   // ShopLoginCubit.get(context).userLogin(
                    //           //   //   email: emailController.text,
                    //           //   //   password: passwordController.text,
                    //           //   // );
                    //           // }
                    //         },
                    //         // validate: (String? value) {
                    //         //   if (value!.isEmpty) {
                    //         //     return 'password is too short';
                    //         //   }
                    //         // },

                    //         label: 'Branch',
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
                            controller: genderController,
                            readOnly: true,
                            label: 'Gender',
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: defaultTextFormField(
                            controller: statusController,
                            readOnly: true,
                            label: 'Account State',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20.0),
                    defaultButton(
                      text: 'update',
                      onPressedFunction: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).updateDirectSupervisorData(
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
                      height: 50.0,
                      fontSizeText: 18.0,
                    ),
                    const SizedBox(height: 20.0),
                    defaultButton(
                      text: 'Change Password',
                      onPressedFunction: () {},
                      height: 50.0,
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
