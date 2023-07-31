import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/login_model.dart';
import 'package:quran_automated/view/user/login/cubit/login_states.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/controllers/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  LoginModel? loginModel;
  void userLogin({
    required String identityNo,
    required String password,
    required bool rememberMe,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'auto/login', dataFromUser: {
      'username': identityNo,
      'password': password,
      'remember_me': rememberMe,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      printStatement(errorMessage);
      emit(LoginErrorState(errorMessage));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
