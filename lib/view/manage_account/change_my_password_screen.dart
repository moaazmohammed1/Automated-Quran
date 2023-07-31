import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/controllers/applocal.dart';
import '../components/components.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class ChangeMyPasswordScreen extends StatelessWidget {
  ChangeMyPasswordScreen({super.key});
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: '${getLang(context, "changePasswordButton")}',
              centerTitle: true),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: currentPasswordController,
                      keyboard: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '${getLang(context, "passwordIsTooShort")}';
                        }
                        return null;
                      },
                      obscurePassword: AppCubit.get(context).isCurrentPassword,
                      label: '${getLang(context, "currentPassword")}',
                      suffixIcon: AppCubit.get(context).currentSuffix,
                      onPressedSuffix: () {
                        AppCubit.get(context).changePasswordVisibility(
                          isPassword: 'isCurrentPassword',
                          suffix: 'currentSuffix',
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    defaultTextFormField(
                      controller: newPasswordController,
                      keyboard: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '${getLang(context, "passwordIsTooShort")}';
                        }
                        return null;
                      },
                      obscurePassword: AppCubit.get(context).isNewPassword,
                      label: '${getLang(context, "newPassword")}',
                      suffixIcon: AppCubit.get(context).newSuffix,
                      onPressedSuffix: () {
                        AppCubit.get(context).changePasswordVisibility(
                          isPassword: 'isNewPassword',
                          suffix: 'newSuffix',
                        );
                      },
                    ),
                    const SizedBox(height: 15.0),
                    defaultTextFormField(
                      controller: confirmPasswordController,
                      keyboard: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '${getLang(context, "passwordIsTooShort")}';
                        }
                        return null;
                      },
                      obscurePassword: AppCubit.get(context).isConfirmPassword,
                      label: '${getLang(context, "confirmPassword")}',
                      suffixIcon: AppCubit.get(context).confirmSuffix,
                      onPressedSuffix: () {
                        AppCubit.get(context).changePasswordVisibility(
                          isPassword: 'isConfirmPassword',
                          suffix: 'confirmSuffix',
                        );
                      },
                    ),
                    const SizedBox(height: 40.0),
                    defaultButton(
                      text: '${getLang(context, "saveButton")}',
                      onPressedFunction: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).changeMyPassword(
                            context,
                            currentPassword: currentPasswordController.text,
                            newPassword: newPasswordController.text,
                            newPasswordConfirmation:
                                confirmPasswordController.text,
                          );
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
        );
      },
    );
  }
}
