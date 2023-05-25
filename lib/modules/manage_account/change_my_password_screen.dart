import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

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
              context: context, title: 'Change My Password', centerTitle: true),
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
                          return 'password is too short';
                        }
                        return null;
                      },
                      obscurePassword: AppCubit.get(context).isCurrentPassword,
                      label: 'Current Password',
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
                          return 'password is too short';
                        }
                        return null;
                      },
                      obscurePassword: AppCubit.get(context).isNewPassword,
                      label: 'New Password',
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
                          return 'password is too short';
                        }
                        return null;
                      },
                      obscurePassword: AppCubit.get(context).isConfirmPassword,
                      label: 'Confirm Password',
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
                      text: 'save',
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
