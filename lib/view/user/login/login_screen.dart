import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/view/user/login/cubit/login_cubit.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/view/components/drawer_component.dart';
import 'package:quran_automated/controllers/cubit/app_cubit.dart';
import 'package:quran_automated/controllers/network/local/cache_helper.dart';
import '../../../controllers/network/end_point.dart';
import '../../manage_account/home_screen.dart';
import '../../style/style.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController identityNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.token != null) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.token,
              ).then((value) {
                token = state.loginModel.token;
                printStatement(token);
                CacheHelper.saveData(
                  key: 'position',
                  value: state.loginModel.user!.position,
                ).then((value) {
                  position = state.loginModel.user!.position;
                  printStatement(position);
                });

                context.read<AppCubit>().getMyData();
                context.read<AppCubit>().studentsInGroupeModel = null;
                context.read<AppCubit>().jsonMessage = null;
                context.read<AppCubit>().keepModel = null;

                navigateAndRemove(context, HomeScreen());
              });
              showToast(
                msg: '${getLang(context, "loginSuccess")}',
                state: ToastStates.SUCCESS,
              );
            } else {
              showToast(
                msg: '${getLang(context, "loginError")}',
                state: ToastStates.ERROR,
              );
            }
          }
          if (state is LoginErrorState) {
            showToast(
              msg: state.error,
              state: ToastStates.ERROR,
            );
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              '${getLang(context, "loginTitle")}',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 20.0,
                  ),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${getLang(context, "login")}',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 30.0),
                      ),
                      const SizedBox(height: 40.0),
                      Text(
                        '${getLang(context, "welcome")}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 24.0),
                      defaultTextFormField(
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
                      const SizedBox(height: 15.0),
                      defaultTextFormField(
                        controller: passwordController,
                        keyboard: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return '${getLang(context, "passwordIsTooShort")}';
                          }
                          return null;
                        },
                        obscurePassword: LoginCubit.get(context).isPassword,
                        label: '${getLang(context, "password")}',
                        suffixIcon: LoginCubit.get(context).suffix,
                        onPressedSuffix: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(height: 40.0),
                      if (state is LoginLoadingState)
                        const Center(
                          child: CircularProgressIndicator(
                            color: defaultColor,
                          ),
                        ),
                      if (state is! LoginLoadingState)
                        defaultButton(
                            text: '${getLang(context, "login")}'.toUpperCase(),
                            height: 60.0,
                            fontSizeText: 17.0,
                            onPressedFunction: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  identityNo: identityNoController.text,
                                  password: passwordController.text,
                                  rememberMe: true,
                                );
                              }
                            }),
                      const SizedBox(height: 75.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          drawer: DrawerComponent(),
        ),
      ),
    );
  }
}
