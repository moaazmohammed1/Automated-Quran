import 'package:quran_automated/models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}

// **

class LoadingGetMyDataState extends LoginStates {}

class SuccessGetMyDataState extends LoginStates {}

class ErrorGetMyDataState extends LoginStates {}

// **

class LoadingUpdateMyAccountState extends LoginStates {}

class SuccessUpdateMyAccountState extends LoginStates {}

class ErrorUpdateMyAccountState extends LoginStates {}

// **

class LoadingChangeMyPasswordState extends LoginStates {}

class SuccessChangeMyPasswordState extends LoginStates {}

class ErrorChangeMyPasswordState extends LoginStates {}

// **

class LoadingDeleteMyAccountState extends LoginStates {}

class SuccessDeleteMyAccountState extends LoginStates {}

class ErrorDeleteMyAccountState extends LoginStates {}

// **