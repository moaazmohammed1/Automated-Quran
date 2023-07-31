import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/all_centers_model.dart';
import 'package:quran_automated/models/all_groups_model.dart';
import 'package:quran_automated/models/all_keepers_model.dart';
import 'package:quran_automated/models/all_reports_keeper_model.dart';
import 'package:quran_automated/models/all_reports_supervisor_model.dart';
import 'package:quran_automated/models/all_students_model.dart';
import 'package:quran_automated/models/attendance_model.dart';
import 'package:quran_automated/models/get_keeper_test_model.dart';
import 'package:quran_automated/models/get_mark_model.dart';
import 'package:quran_automated/models/get_one_center_model.dart';
import 'package:quran_automated/models/get_one_groupe_model.dart';
import 'package:quran_automated/models/get_one_keeper_model.dart';
import 'package:quran_automated/models/keep_model.dart';
import 'package:quran_automated/models/tests_model.dart';
import 'package:quran_automated/models/user_model.dart';
import 'package:quran_automated/models/all_admin_model.dart';
import 'package:quran_automated/models/my_data_model.dart';
import 'package:quran_automated/view/DS/all_ds_screen.dart';
import 'package:quran_automated/view/DS/all_report_supervisor_screen.dart';
import 'package:quran_automated/view/admin/all_admin_screen.dart';
import 'package:quran_automated/view/center/all_centers_screen.dart';
import 'package:quran_automated/view/groupe/all_groups_screen.dart';
import 'package:quran_automated/view/keeper/all_keeper_screen.dart';
import 'package:quran_automated/view/manage_account/home_screen.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/controllers/cubit/app_states.dart';
import 'package:quran_automated/controllers/network/end_point.dart';
import '../../models/all_branches_model.dart';
import '../../models/all_student_in_groupe_model.dart';
import '../../models/all_supervisor_model.dart';
import '../../models/get_one_branch_model.dart';
import '../../models/juz_information_model.dart';
import '../../view/branch/all_branches_screen.dart';
import '../../view/keeper/question_screen.dart';
import '../../view/student/all_student_in_groupe_screen.dart';
import '../../view/student/all_student_screen.dart';
import '../network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  /////////////////////////////////////////////////////////////////////////
  ///  Admin Code: (GET_MY_DATA * UPDATE * DELETE * CHANGE_MY_PASSWORD) ///

  /// GET My Data ///

  MyDataModel? myData;
  getMyData() {
    emit(LoadingGetMyDataState());
    DioHelper.getData(
      url: 'auto/mng/accounts',
      token: token,
    ).then((value) {
      myData = MyDataModel.fromJson(value.data);

      printStatement('My position is ${myData!.position}');
      emit(SuccessGetMyDataState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetMyDataState());
    });
  }

  /// UPDATE My Account Data///

  void updateMyAccountData(
    context, {
    required int id,
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingUpdateMyAccountState());
    DioHelper.putData(
      url: 'auto/mng/accounts/update',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
      },
    ).then((value) {
      myData = MyDataModel.fromJson(value.data);
      printStatement('Admin ${myData!.id} updated');

      showToast(
        msg: 'Success Updated My Account',
        state: ToastStates.SUCCESS,
      );
      getMyData();
      navigateAndRemove(context, HomeScreen());
      emit(SuccessUpdateMyAccountState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.response);
      emit(ErrorUpdateMyAccountState());
    });
  }

  /// CHANGE My PASSWORD ///

  changeMyPassword(
    context, {
    required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) {
    emit(LoadingChangeMyPasswordState());
    DioHelper.putData(
      url: 'auto/mng/accounts/change-password',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
    ).then((value) {
      printStatement('My Password is changed');
      // showToast(
      //   msg: value.data['message'],
      //   state: ToastStates.SUCCESS,
      // );
      emit(SuccessChangeMyPasswordState());
      // navigateAndRemove(context, HomeScreen());
    }).catchError((error) {
      printStatement('My Password is not changed');
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(
        msg: errorMessage,
        state: ToastStates.ERROR,
      );
      printStatement(errorMessage);
      printStatement(error.toString());
      emit(ErrorChangeMyPasswordState());
    });
  }

  /// DELETE My Account ///

  deleteMyAccount(context) {
    emit(LoadingDeleteMyAccountState());
    DioHelper.getData(
      url: 'auto/mng/accounts/delete-account',
      token: token,
    ).then((value) {
      printStatement('My Account Deleted');
      // showToast(msg: 'My Account Deleted', state: ToastStates.SUCCESS);
      Map<String, dynamic> responseData = json.decode(value.data.toString());
      String successMessage = responseData['message'];
      showToast(msg: successMessage, state: ToastStates.SUCCESS);
      signOut(context);
      emit(SuccessDeleteMyAccountState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorDeleteMyAccountState());
    });
  }

  /////////////////////////////////////////////////////////////////////////
  ///  Admin Code: (ADD * GET_ADMIN * GET_ALL_ADMINS * UPDATE * DELETE) ///

  /// ADD Admin ///

  UserModel? adminModel;
  void addAdmin(
    context, {
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(AddAdminLoadingState());
    DioHelper.postData(
      url: 'auto/admins',
      dataFromUser: {
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
      },
      token: token,
    ).then((value) {
      adminModel = UserModel.fromJson(value.data);
      getAllAdminData();
      showToast(
        msg: adminModel!.message!,
        state: ToastStates.SUCCESS,
      );
      emit(AddAdminSuccessState());
      navigateTo(context, FollowAllAdminScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      Map<String, dynamic> errors = responseData['errors'];
      String errorDetails = '';
      errors.forEach((key, value) {
        // errorDetails += '$key: ${value[0]}\n';
        errorDetails += '${value[0]}\n';
      });
      printStatement(errorMessage);
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(AddAdminErrorState(error.toString()));
    });
  }

  /// GET Admin ///

  UserModel? adminData;
  void getAdminData({required int id}) {
    emit(LoadingGetAdminDataState());
    DioHelper.getData(
      url: 'auto/admins/$id',
      token: token,
    ).then((value) {
      adminData = UserModel.fromJson(value.data);
      printStatement('only admin is ${adminData!.admin!.email}');
      emit(SuccessGetAdminDataState(adminData!));
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetAdminDataState());
    });
  }

  /// GET ALL Admins ///

  AllAdminModel? allAdminModel;
  void getAllAdminData() {
    emit(LoadingGetAllAdminState());
    DioHelper.getData(
      url: 'auto/admins',
      token: token,
    ).then((value) {
      allAdminModel = AllAdminModel.fromJson(value.data);

      emit(SuccessGetAllAdminState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetAllAdminState());
    });
  }

  /// UPDATE Admin ///

  void updateAdminData(
    context, {
    required int id,
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingUpdateAdminState());
    DioHelper.putData(
      url: 'auto/admins/$id',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
      },
    ).then((value) {
      adminData = UserModel.fromJson(value.data);
      printStatement('Admin ${adminData!.admin!.id} updated');
      getAllAdminData();
      showToast(
        msg: 'Success Update',
        state: ToastStates.SUCCESS,
      );
      emit(SuccessUpdateAdminState(adminData!));
      navigateAndRemove(context, FollowAllAdminScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorUpdateAdminState());
    });
  }

  /// DELETE Admin ///

  deleteAdmin(context, {required int id}) {
    emit(LoadingDeleteAdminState());
    DioHelper.deleteData(
      url: 'auto/admins/$id',
      token: token,
    ).then((value) {
      printStatement('admin $id deleted');
      showToast(msg: 'Admin deleted', state: ToastStates.SUCCESS);
      getAllAdminData();
      emit(SuccessDeleteAdminState());
      navigateAndRemove(
        context,
        FollowAllAdminScreen(),
      );
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorDeleteAdminState());
    });
  }

  /// Visibility State When Change Password ///

  IconData currentSuffix = Icons.visibility_outlined;
  IconData newSuffix = Icons.visibility_outlined;
  IconData confirmSuffix = Icons.visibility_outlined;
  bool isCurrentPassword = true;
  bool isNewPassword = true;
  bool isConfirmPassword = true;
  void changePasswordVisibility({required suffix, required isPassword}) {
    switch (isPassword) {
      case 'isCurrentPassword':
        isCurrentPassword = !isCurrentPassword;
        break;
      case 'isNewPassword':
        isNewPassword = !isNewPassword;
        break;
      case 'isConfirmPassword':
        isConfirmPassword = !isConfirmPassword;
        break;
    }

    switch (suffix) {
      case 'currentSuffix':
        currentSuffix = isCurrentPassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined;

        break;
      case 'newSuffix':
        newSuffix = isNewPassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined;

        break;
      case 'confirmSuffix':
        confirmSuffix = isConfirmPassword
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined;

        break;
    }

    emit(ChangePasswordVisibilityState());
  }

  //*  in add Admin screen  */

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibilityInAdmin() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  String selectedGender = '';
  selectGender({required String gender}) {
    selectedGender = gender;
    emit(GenderState());
  }

  String selectedStatus = '';
  selectStatus({required String status}) {
    selectedStatus = status;
    emit(StatusState());
  }

  /*  Direct Supervisor */

  ///  Add Direct Supervisor ///

  UserModel? directSupervisorModel;
  void addDirectSupervisor(
    context, {
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingAddDirectSupervisorState());
    DioHelper.postData(
      url: 'auto/supervisors/create',
      dataFromUser: {
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
        'position': 'supervisor',
      },
      token: token,
    ).then((value) {
      directSupervisorModel = UserModel.fromJson(value.data);
      getAllDirectSupervisorData();
      showToast(
        msg: directSupervisorModel!.message!,
        state: ToastStates.SUCCESS,
      );
      emit(SuccessAddDirectSupervisorState());
      navigateTo(context, FollowAllDSScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];

      showToast(
        msg: errorMessage,
        state: ToastStates.ERROR,
      );
      printStatement(error.toString());
      emit(ErrorAddDirectSupervisorState());
    });
  }

  /// GET ALL Direct Supervisor ///

  SupervisorModel? allDirectSupervisorModel;
  void getAllDirectSupervisorData() {
    emit(LoadingGetAllDirectSupervisorState());
    DioHelper.getData(
      url: 'auto/supervisors',
      token: token,
    ).then((value) {
      allDirectSupervisorModel = SupervisorModel.fromJson(value.data);
      emit(SuccessGetAllDirectSupervisorState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());

      emit(ErrorGetAllDirectSupervisorState());
    });
  }

  /// UPDATE Direct Supervisor ///

  void updateDirectSupervisorData(
    context, {
    required int id,
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingUpdateDirectSupervisorState());
    DioHelper.putData(
      url: 'auto/supervisors/$id',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
        'position': 'supervisor',
      },
    ).then((value) {
      directSupervisorModel = UserModel.fromJson(value.data);
      printStatement('supervisors ${directSupervisorModel!.admin!.id} updated');
      getAllDirectSupervisorData();
      showToast(
        msg: directSupervisorModel!.message!,
        state: ToastStates.SUCCESS,
      );
      emit(SuccessUpdateDirectSupervisorState());
      navigateAndRemove(context, FollowAllDSScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorUpdateDirectSupervisorState());
    });
  }

  /// DELETE Direct Supervisor ///

  deleteDirectSupervisor(context, {required int id}) {
    emit(LoadingDeleteDirectSupervisorState());
    DioHelper.deleteData(
      url: 'auto/supervisors/$id',
      token: token,
    ).then((value) {
      printStatement('supervisors $id deleted');
      Map<String, dynamic> responseData = value.data;
      String successMessage = responseData['message'];
      showToast(msg: successMessage, state: ToastStates.SUCCESS);
      getAllDirectSupervisorData();
      emit(SuccessDeleteDirectSupervisorState());
      navigateAndRemove(
        context,
        FollowAllDSScreen(),
      );
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorDeleteDirectSupervisorState());
    });
  }

  /*  Keeper */

  ///  Add Keeper ///

  UserModel? keeperModel;
  void addKeeper(
    context, {
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingAddKeeperState());
    DioHelper.postData(
      url: 'auto/keepers/create',
      dataFromUser: {
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
        'position': 'keeper',
      },
      token: token,
    ).then((value) {
      keeperModel = UserModel.fromJson(value.data);
      getAllKeepersData();
      showToast(
        msg: keeperModel!.message!,
        state: ToastStates.SUCCESS,
      );
      emit(SuccessAddKeeperState());
      navigateTo(context, FollowAllKeepersScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];

      showToast(
        msg: errorMessage,
        state: ToastStates.ERROR,
      );
      printStatement(error.toString());
      emit(ErrorAddKeeperState());
    });
  }

  ///  Get Keeper ///

  GetOneKeeperModel? getOneKeeperModel;
  void getKeeperData({required int id}) {
    emit(LoadingGetKeeperDataState());
    DioHelper.getData(
      url: 'auto/keepers/$id',
      token: token,
    ).then((value) {
      getOneKeeperModel = GetOneKeeperModel.fromJson(value.data);
      emit(SuccessGetKeeperDataState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetKeeperDataState());
    });
  }

  /// GET ALL Keeper ///

  KeepersModel? allKeeperModel;
  void getAllKeepersData() {
    emit(LoadingGetAllKeeperState());
    DioHelper.getData(
      url: 'auto/keepers',
      token: token,
    ).then((value) {
      allKeeperModel = KeepersModel.fromJson(value.data);
      emit(SuccessGetAllKeeperState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());

      emit(ErrorGetAllKeeperState());
    });
  }

  /// UPDATE Keeper ///

  void updateKeeperData(
    context, {
    required int id,
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingUpdateKeeperState());
    DioHelper.putData(
      url: 'auto/keepers/$id',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
        'position': 'keeper',
      },
    ).then((value) {
      keeperModel = UserModel.fromJson(value.data);
      printStatement('keeper ${keeperModel!.admin!.id} updated');
      getAllKeepersData();
      showToast(
        msg: keeperModel!.message!,
        state: ToastStates.SUCCESS,
      );
      emit(SuccessUpdateKeeperState());
      navigateAndRemove(context, FollowAllKeepersScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData = json.decode(error.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorUpdateKeeperState());
    });
  }

  /// DELETE Keeper ///

  deleteKeeper(context, {required int id}) {
    emit(LoadingDeleteKeeperState());
    DioHelper.deleteData(
      url: 'auto/keepers/$id',
      token: token,
    ).then((value) {
      printStatement('keepers $id deleted');
      Map<String, dynamic> responseData = value.data;
      String successMessage = responseData['message'];
      showToast(msg: successMessage, state: ToastStates.SUCCESS);
      getAllKeepersData();
      emit(SuccessDeleteKeeperState());
      navigateAndRemove(
        context,
        FollowAllKeepersScreen(),
      );
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorDeleteKeeperState());
    });
  }

  /*  Student */

  ///  Add Student ///

  UserModel? studentModel;
  void addStudent(
    context, {
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingAddStudentState());
    DioHelper.postData(
      url: 'auto/students/create',
      dataFromUser: {
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
        'position': 'student',
      },
      token: token,
    ).then((value) {
      studentModel = UserModel.fromJson(value.data);
      getAllStudentsData();
      showToast(
        msg: studentModel!.message!,
        state: ToastStates.SUCCESS,
      );
      emit(SuccessAddStudentState());
      navigateTo(context, FollowAllStudentsScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];

      showToast(
        msg: errorMessage,
        state: ToastStates.ERROR,
      );
      printStatement(error.toString());
      emit(ErrorAddStudentState());
    });
  }

  ///  Get Student ///

  /// /// GET ALL Student ///

  StudentsModel? allStudentModel;
  void getAllStudentsData() {
    emit(LoadingGetAllStudentState());
    DioHelper.getData(
      url: 'auto/students',
      token: token,
    ).then((value) {
      allStudentModel = StudentsModel.fromJson(value.data);
      emit(SuccessGetAllStudentState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());

      emit(ErrorGetAllStudentState());
    });
  }

  //  /// UPDATE Student ///

  void updateStudentData(
    context, {
    required int id,
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingUpdateStudentState());
    DioHelper.putData(
      url: 'auto/students/$id',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
        'position': 'student',
      },
    ).then((value) {
      studentModel = UserModel.fromJson(value.data);
      printStatement('student ${studentModel!.admin!.id} updated');
      getAllStudentsData();
      // showToast(
      //   msg: studentModel!.message!,
      //   state: ToastStates.SUCCESS,
      // );
      showToast(
        msg: 'student updated success',
        state: ToastStates.SUCCESS,
      );
      emit(SuccessUpdateStudentState());
      navigateAndRemove(context, FollowAllStudentsScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorUpdateStudentState());
    });
  }

  /// DELETE Student ///

  deleteStudent(context, {required int id}) {
    emit(LoadingDeleteStudentState());
    DioHelper.deleteData(
      url: 'auto/students/$id',
      token: token,
    ).then((value) {
      printStatement('student $id deleted');
      Map<String, dynamic> responseData = value.data;
      String successMessage = responseData['message'];
      showToast(msg: successMessage, state: ToastStates.SUCCESS);
      getAllStudentsData();
      emit(SuccessDeleteStudentState());
      navigateAndRemove(
        context,
        FollowAllStudentsScreen(),
      );
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorDeleteStudentState());
    });
  }

  /* Groupe Student */

  ///  Add Student in Groupe ///

  UserModel? studentInGroupeModel;
  void addStudentInGroupe(
    context, {
    required String fName,
    required String sName,
    required String tName,
    required String lName,
    required String identityNo,
    required String phone,
    String? email,
    required String gender,
    required String password,
    required String status,
  }) {
    emit(LoadingAddStudentInGroupeState());
    DioHelper.postData(
      url: 'auto/keepers/groups/add-new-student',
      dataFromUser: {
        'fname': fName,
        'sname': sName,
        'tname': tName,
        'lname': lName,
        'identity_no': identityNo,
        'phone': phone,
        'email': email,
        'gender': gender,
        'password': password,
        'status': status,
        'position': 'student',
      },
      token: token,
    ).then((value) {
      studentInGroupeModel = UserModel.fromJson(value.data);
      mapStudentsInGroupe = {};
      getAllStudentsInGroupeData();
      showToast(
        msg: studentInGroupeModel!.message!,
        state: ToastStates.SUCCESS,
      );
      emit(SuccessAddStudentInGroupeState());
      navigateTo(context, FollowAllStudentsInGroupeScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];

      showToast(
        msg: errorMessage,
        state: ToastStates.ERROR,
      );
      printStatement(error.toString());
      emit(ErrorAddStudentInGroupeState());
    });
  }

  /// GET ALL Student ///

  String? jsonMessage;
  StudentsInGroupeModel? studentsInGroupeModel;
  Map<String, int> mapStudentsInGroupe = {};

  void getAllStudentsInGroupeData() {
    emit(LoadingGetAllStudentInGroupeState());
    DioHelper.getData(
      url: 'auto/keepers/groups/get-students',
      token: token,
    ).then((value) {
      if (value.data['status'] == false) {
        showToast(
          msg: value.data['message'],
          state: ToastStates.ERROR,
        );
        jsonMessage = value.data['message'];
      } else if (value.data['status'] == true) {
        studentsInGroupeModel = StudentsInGroupeModel.fromJson(value.data);
        if (mapStudentsInGroupe == {}) {
          studentsInGroupeModel!.group![0].students!.forEach((element) {
            mapStudentsInGroupe.addEntries([MapEntry('${element.id!}', 0)]);
          });
        }
      }
      emit(SuccessGetAllStudentInGroupeState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());

      emit(ErrorGetAllStudentInGroupeState());
    });
  }

  // changeContainerColor(int id) {
  //   mapStudentsInGroupe['$id'] = 1;
  //   emit(SuccessGetAllStudentInGroupeState());
  // }

  /* Register new keep */

  List<String> sura = [];
  Map<String, int> mapSuras = {};

  Surah? juzInformationModel;
  Surah? juzInformationModel1;
  getSpecificJuzInformation({required int id}) {
    emit(LoadingGetSpecificJuzInformationState());
    DioHelper.getData(
      url: 'auto/keep/juz/$id',
      token: token,
    ).then((value) {
      mapSuras = {};
      sura = [];
      value.data['data']['surahs'].keys.forEach((e) {
        juzInformationModel = Surah.fromJson(value.data['data']['surahs'][e]);
        mapSuras.addAll({
          juzInformationModel!.englishName!:
              juzInformationModel!.numberOfAyahs!,
        });
      });
      value.data['data']['surahs'].keys.forEach((e) {
        juzInformationModel1 = Surah.fromJson(value.data['data']['surahs'][e]);
        sura.add('${juzInformationModel1!.number!}');
      });
      emit(SuccessGetSpecificJuzInformationState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());

      emit(ErrorGetSpecificJuzInformationState());
    });
  }

  String? selectedJuz;
  selectedAlJuz({required String? juz}) {
    selectedJuz = juz;
    emit(JuzState());
  }

  String? selectedSura;
  String? suraNo;
  selectedSuras({required String? sura, required String no}) {
    selectedSura = sura;
    suraNo = no;
    emit(SuraState());
  }

  int? selectedFromAyah;
  selectedFromAyahs({required int? ayah}) {
    selectedFromAyah = ayah;
    emit(FromAyahState());
  }

  int? selectedToAyah;
  selectedToAyahs({required int? ayah}) {
    selectedToAyah = ayah;
    emit(ToAyahState());
  }

  registerNewKeep(
    context, {
    required int id,
    required int fromJuz,
    required int fromSurah,
    // required int toSurah,
    required int fromAyah,
    required int toAyah,
    required int faultsNumber,
  }) {
    emit(LoadingRegisterNewKeepState());
    DioHelper.postData(
      url: 'auto/keep/create/student/$id',
      token: token,
      dataFromUser: {
        'from_juz': fromJuz,
        'to_juz': fromJuz,
        'from_surah': fromSurah,
        'to_surah': fromSurah,
        'from_ayah': fromAyah,
        'to_ayah': toAyah,
        'faults_number': faultsNumber,
      },
    ).then((value) {
      printStatement(value.data);
      showToast(msg: value.data['message'], state: ToastStates.SUCCESS);
      emit(SuccessRegisterNewKeepState());
      navigateTo(context, FollowAllStudentsInGroupeScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorRegisterNewKeepState());
    });
  }

  storeStudentAbsence({
    required int studentId,
    required int isAttendance,
  }) {
    emit(LoadingStoreStudentAbsenceState());
    DioHelper.postData(
      url: '/auto/absence/store/student',
      token: token,
      dataFromUser: {
        'student_id': studentId,
        'is_attendance': isAttendance,
      },
    ).then((value) {
      showToast(msg: value.data['message'], state: ToastStates.SUCCESS);

      emit(SuccessStoreStudentAbsenceState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorStoreStudentAbsenceState());
    });
  }

  // Get Question to Test

  // TestModel? testModel;
  // List<TestModel>? testModelList = [];
  TestModel? testModel;

  getQuestion(
    context, {
    int? fromJuz,
    int? toJuz,
    int? questionNo,
    String? type,
    int? studentId,
  }) {
    emit(LoadingGetQuestionState());
    if (position == 'keeper') {
      DioHelper.getData(
        url:
            '/auto/keepers/tests/generate?from=$fromJuz&to=$toJuz&ayahs_no=$questionNo&type=$type&student_id=$studentId',
        token: token,
      ).then((value) {
        // testModelList = [];
        navigateTo(context, QuestionScreen(id: studentId));

        testModel = TestModel.fromJson(value.data[0]);

        emit(SuccessGetQuestionState());
      }).catchError((error) {
        Map<String, dynamic> responseData =
            json.decode(error.response.toString());
        String errorMessage = responseData['message'];
        showToast(msg: errorMessage, state: ToastStates.ERROR);
        printStatement(error.toString());
        emit(ErrorGetQuestionState());
      });
    }
    if (position == 'supervisor') {
      DioHelper.getData(
        url:
            '/auto/supervisors/mng/generate?from=$fromJuz&to=$toJuz&student_id=$studentId&type=$type&ayahs_no=$questionNo',
        token: token,
      ).then((value) {
        // testModelList = [];
        navigateTo(context, QuestionScreen(id: studentId));

        testModel = TestModel.fromJson(value.data[0]);

        emit(SuccessGetQuestionState());
      }).catchError((error) {
        Map<String, dynamic> responseData =
            json.decode(error.response.toString());
        String errorMessage = responseData['message'];
        showToast(msg: errorMessage, state: ToastStates.ERROR);
        printStatement(error.toString());
        emit(ErrorGetQuestionState());
      });
    }
  }

  String selectedTypeQuestion = '';
  selectedTypeQuestions({required String type}) {
    selectedTypeQuestion = type;
    emit(TypeQuestionState());
  }

  sendMarkQuestion(
    context, {
    int? mark,
    int? testId,
  }) {
    emit(LoadingSendMarkState());

    DioHelper.postData(
      url: '/auto/keepers/tests/submit-mark',
      dataFromUser: {
        'mark': mark,
        'test_id': testId,
      },
      token: token,
    ).then((value) {
      if (position == 'keeper') {
        navigateTo(context, FollowAllStudentsInGroupeScreen());
      }
      if (position == 'supervisor') {
        navigateTo(context, FollowAllStudentsScreen());
      }
      showToast(msg: value.data['message'], state: ToastStates.SUCCESS);
      emit(SuccessSendMarkState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorSendMarkState());
    });
  }

  GetMyTestsModel? getMyTestsModel;
  getMyTest() {
    emit(LoadingGetMyTestState());
    DioHelper.getData(
      url: '/auto/students/mng/get-my-tests',
      // url: '/auto/keepers/tests/index',
      token: token,
    ).then((value) {
      // navigateTo(context, MyTestScreen(id: studentId));

      getMyTestsModel = GetMyTestsModel.fromJson(value.data);

      emit(SuccessGetMyTestState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetMyTestState());
    });
  }

  GetKeeperTestsModel? getKeeperTestsModel;
  getKeeperTests() {
    emit(LoadingGetKeeperTestState());
    DioHelper.getData(
      url: '/auto/keepers/tests/index',
      token: token,
    ).then((value) {
      // navigateTo(context, KeeperTestScreen(id: studentId));

      getKeeperTestsModel = GetKeeperTestsModel.fromJson(value.data);

      emit(SuccessGetKeeperTestState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetKeeperTestState());
    });
  }

  AllReportKeeperModel? allReportKeeperModel;
  getAllReportKeeper() {
    emit(LoadingAllReportKeeperState());
    DioHelper.getData(
      url: '/auto/keepers/report/my-reports',
      token: token,
    ).then((value) {
      allReportKeeperModel = AllReportKeeperModel.fromJson(value.data);

      emit(SuccessAllReportKeeperState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorAllReportKeeperState());
    });
  }

  AllReportSupervisorModel? allReportSupervisorModel;
  getAllReportSupervisor() {
    emit(LoadingAllReportSupervisorState());
    DioHelper.getData(
      url: '/auto/supervisors/mng/keepers-report',
      token: token,
    ).then((value) {
      allReportSupervisorModel = AllReportSupervisorModel.fromJson(value.data);

      emit(SuccessAllReportSupervisorState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorAllReportSupervisorState());
    });
  }

  /* Report */

  List<Map<String, dynamic>>? studentInReport = [];
  getReport(context) {
    emit(LoadingGetReportState());
    DioHelper.getData(
      url: '/auto/keepers/report/monthly',
      token: token,
    ).then((value) {
      /*************** */
      /*************** */
      /*************** */
      /*************** */
      /*************** */
      /*************** */
      /*************** */
      /*************** */
      studentInReport = [];
      value.data.forEach((v) {
        studentInReport!.add(v);
      });
      print(studentInReport);
      print('studentInReport');
      emit(SuccessGetReportState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetReportState());
    });
  }

  AttendanceModel? attendanceModel;
  getAttendance() {
    emit(LoadingGetAttendanceState());
    DioHelper.getData(
      url: '/auto/students/mng/absence-attendace-days',
      token: token,
    ).then((value) {
      attendanceModel = AttendanceModel.fromJson(value.data);
      emit(SuccessGetAttendanceState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetAttendanceState());
    });
  }
  /* Student */

  KeepModel? keepModel;
  studentViewKeep() {
    emit(LoadingStudentViewKeepState());
    DioHelper.getData(
      url: 'auto/keep',
      token: token,
    ).then((value) {
      keepModel = KeepModel.fromJson(value.data);
      emit(SuccessStudentViewKeepState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorStudentViewKeepState());
    });
  }

  /* Branch */
  ///  Add Branch ///

  void addBranch(
    context, {
    required String branchName,
    required String branchStatus,
    String? localRegion,
  }) {
    emit(LoadingAddBranchState());
    DioHelper.postData(
      url: 'auto/branches',
      dataFromUser: {
        'name': branchName,
        'status': branchStatus,
        'local_region': localRegion,
      },
      token: token,
    ).then((value) {
      getAllBranchesData();
      showToast(
        msg: value.data['message'],
        state: ToastStates.SUCCESS,
      );
      emit(SuccessAddBranchState());
      navigateTo(context, FollowAllBranchesScreen());
    }).catchError((error) {
      String errorDetails = '';
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      Map<String, dynamic> errors = responseData['errors'];
      errors.forEach((key, value) {
        errorDetails += '${value[0]}\n';
      });
      showToast(
        msg: errorDetails,
        state: ToastStates.ERROR,
      );
      printStatement(error.toString());
      emit(ErrorAddBranchState());
    });
  }

  ///  Get Branch ///

  GetOneBranchModel? getOneBranchModel;
  void getBranchData({required int id}) {
    emit(LoadingGetBranchDataState());
    DioHelper.getData(
      url: 'auto/branches/$id',
      token: token,
    ).then((value) {
      getOneBranchModel = GetOneBranchModel.fromJson(value.data);
      // printStatement(
      //     'only branch is ${getOneBranchModel!.branch!.id} * name: ${getOneBranchModel!.branch!.name}');
      emit(SuccessGetBranchDataState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetBranchDataState());
    });
  }

  /// GET ALL Branches ///

  AllBranchesModel? allBranchesModel;
  void getAllBranchesData() {
    emit(LoadingGetAllBranchesState());
    DioHelper.getData(
      url: 'auto/branches',
      token: token,
    ).then((value) {
      allBranchesModel = AllBranchesModel.fromJson(value.data);
      emit(SuccessGetAllBranchesState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetAllBranchesState());
    });
  }

  /// UPDATE Branch ///

  void updateBranchData(
    context, {
    required int id,
    required String branchName,
    required String branchStatus,
    String? localRegion,
  }) {
    emit(LoadingUpdateBranchState());
    DioHelper.putData(
      url: 'auto/branches/$id',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'name': branchName,
        'status': branchStatus,
        'local_region': localRegion,
      },
    ).then((value) {
      showToast(
        msg: value.data['message'],
        state: ToastStates.SUCCESS,
      );

      getAllBranchesData();

      emit(SuccessUpdateBranchState());
      navigateAndRemove(context, FollowAllBranchesScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorUpdateBranchState());
    });
  }

  /// DELETE Branch ///

  deleteBranch(context, {required int id}) {
    emit(LoadingDeleteBranchState());
    DioHelper.deleteData(
      url: 'auto/branches/$id',
      token: token,
    ).then((value) {
      printStatement('Branch $id deleted');
      Map<String, dynamic> responseData = value.data;
      String successMessage = responseData['message'];
      showToast(msg: successMessage, state: ToastStates.SUCCESS);
      getAllBranchesData();
      emit(SuccessDeleteBranchState());
      navigateAndRemove(
        context,
        FollowAllBranchesScreen(),
      );
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorDeleteBranchState());
    });
  }

  String selectedBranchStatus = '';
  selectBranchStatus({required String status}) {
    selectedBranchStatus = status;
    emit(BranchStatusState());
  }

  /* Center */
  ///  Add Center ///

  void addCenter(
    context, {
    required String centerName,
    required String centerStatus,
    String? localRegion,
    required int? branchId,
  }) {
    emit(LoadingAddCenterState());
    DioHelper.postData(
      url: 'auto/centers',
      dataFromUser: {
        'name': centerName,
        'status': centerStatus,
        'local_region': localRegion,
        'branch_id': branchId,
      },
      token: token,
    ).then((value) {
      getAllCentersData();
      showToast(
        msg: value.data['message'],
        state: ToastStates.SUCCESS,
      );
      emit(SuccessAddCenterState());
      navigateTo(context, FollowAllCentersScreen());
    }).catchError((error) {
      String errorDetails = '';
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      Map<String, dynamic> errors = responseData['errors'];
      errors.forEach((key, value) {
        errorDetails += '${value[0]}\n';
      });
      showToast(
        msg: errorDetails,
        state: ToastStates.ERROR,
      );
      printStatement(error.toString());
      emit(ErrorAddCenterState());
    });
  }

  ///  Get Center ///
  GetOneCenterModel? getOneCenterModel;
  void getCenterData({required int id}) {
    emit(LoadingGetCenterDataState());
    DioHelper.getData(
      url: 'auto/centers/$id',
      token: token,
    ).then((value) {
      getOneCenterModel = GetOneCenterModel.fromJson(value.data);
      emit(SuccessGetCenterDataState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetCenterDataState());
    });
  }

  /// GET ALL Center ///

  AllCenterModel? allCentersModel;
  void getAllCentersData() {
    emit(LoadingGetAllCenterState());
    DioHelper.getData(
      url: 'auto/centers',
      token: token,
    ).then((value) {
      allCentersModel = AllCenterModel.fromJson(value.data);
      emit(SuccessGetAllCenterState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetAllCenterState());
    });
  }

  String selectedCenterStatus = '';
  selectCenterStatus({required String status}) {
    selectedCenterStatus = status;
    emit(CenterStatusState());
  }

  int? selectedBranchId;
  selectBranchId({required int? branch}) {
    selectedBranchId = branch;
    emit(BranchIdState());
  }

  /// UPDATE Center ///

  void updateCenterData(
    context, {
    required int id,
    required String centerName,
    required String centerStatus,
    required String? localRegion,
    required int? branchId,
  }) {
    emit(LoadingUpdateCenterState());
    DioHelper.putData(
      url: 'auto/centers/$id',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'name': centerName,
        'status': centerStatus,
        'local_region': localRegion,
        'branch_id': branchId,
      },
    ).then((value) {
      showToast(
        msg: value.data['message'],
        state: ToastStates.SUCCESS,
      );
      getAllCentersData();
      // getAllBranchesData();
      // getBranchData(id: id);
      emit(SuccessUpdateCenterState());
      navigateAndRemove(context, FollowAllCentersScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorUpdateCenterState());
    });
  }

  /// DELETE Centers ///

  deleteCenter(context, {required int id}) {
    emit(LoadingDeleteCenterState());
    DioHelper.deleteData(
      url: 'auto/centers/$id',
      token: token,
    ).then((value) {
      printStatement('Center $id deleted');
      Map<String, dynamic> responseData = value.data;
      String successMessage = responseData['message'];
      showToast(msg: successMessage, state: ToastStates.SUCCESS);
      getAllCentersData();
      emit(SuccessDeleteCenterState());
      navigateAndRemove(
        context,
        FollowAllCentersScreen(),
      );
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorDeleteCenterState());
    });
  }

  /* Groupe */
  ///  Add Groupe ///

  void addGroupe(
    context, {
    required String groupeName,
    required String groupeStatus,
    String? localRegion,
    required int? keeperId,
    required int? centerId,
  }) {
    emit(LoadingAddGroupeState());
    DioHelper.postData(
      url: 'auto/groups',
      dataFromUser: {
        'name': groupeName,
        'status': groupeStatus,
        'local_region': localRegion,
        'keeper_id': keeperId,
        'center_id': centerId,
      },
      token: token,
    ).then((value) {
      getAllGroupsData();
      showToast(
        msg: value.data['message'],
        state: ToastStates.SUCCESS,
      );
      emit(SuccessAddGroupeState());
      navigateTo(context, FollowAllGroupsScreen());
    }).catchError((error) {
      String errorDetails = '';
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      Map<String, dynamic> errors = responseData['errors'];
      errors.forEach((key, value) {
        errorDetails += '${value[0]}\n';
      });
      showToast(
        msg: errorDetails,
        state: ToastStates.ERROR,
      );
      printStatement(error.toString());
      emit(ErrorAddGroupeState());
    });
  }

  ///  Get Groupe ///

  GetOneGroupeModel? getOneGroupeModel;
  void getGroupeData({required int id}) {
    emit(LoadingGetGroupeDataState());
    DioHelper.getData(
      url: 'auto/groups/$id',
      token: token,
    ).then((value) {
      getOneGroupeModel = GetOneGroupeModel.fromJson(value.data);

      emit(SuccessGetGroupeDataState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetGroupeDataState());
    });
  }

  /// GET ALL Groupe ///

  AllGroupsModel? allGroupsModel;
  void getAllGroupsData() {
    emit(LoadingGetAllGroupeState());
    DioHelper.getData(
      url: 'auto/groups',
      token: token,
    ).then((value) {
      allGroupsModel = AllGroupsModel.fromJson(value.data);
      emit(SuccessGetAllGroupeState());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorGetAllGroupeState());
    });
  }

  int? selectedCenterId;
  selectCenterId({required int? center}) {
    selectedCenterId = center;
    emit(CenterIdState());
  }

  int? selectedKeeperId;
  selectKeeperId({required int? keeper}) {
    selectedKeeperId = keeper;
    emit(KeeperIdState());
  }

  /// UPDATE Groupe ///

  void updateGroupeData(
    context, {
    required int id,
    required String groupeName,
    required String groupeStatus,
    String? localRegion,
    required int? keeperId,
    required int? centerId,
  }) {
    emit(LoadingUpdateGroupeState());
    DioHelper.putData(
      url: 'auto/groups/$id',
      token: token,
      dataFromUser: {
        '_method': 'PUT',
        'name': groupeName,
        'status': groupeStatus,
        'local_region': localRegion,
        'keeper_id': keeperId,
        'center_id': centerId,
      },
    ).then((value) {
      showToast(
        msg: value.data['message'],
        state: ToastStates.SUCCESS,
      );
      getAllGroupsData();
      emit(SuccessUpdateGroupeState());
      navigateAndRemove(context, FollowAllGroupsScreen());
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorUpdateGroupeState());
    });
  }

  /// DELETE Groupe ///

  deleteGroupe(context, {required int id}) {
    emit(LoadingDeleteGroupeState());
    DioHelper.deleteData(
      url: 'auto/groups/$id',
      token: token,
    ).then((value) {
      printStatement('Groupe $id deleted');
      Map<String, dynamic> responseData = value.data;
      String successMessage = responseData['message'];
      showToast(msg: successMessage, state: ToastStates.SUCCESS);
      getAllGroupsData();
      emit(SuccessDeleteGroupeState());
      navigateAndRemove(
        context,
        FollowAllGroupsScreen(),
      );
    }).catchError((error) {
      Map<String, dynamic> responseData =
          json.decode(error.response.toString());
      String errorMessage = responseData['message'];
      showToast(msg: errorMessage, state: ToastStates.ERROR);
      printStatement(error.toString());
      emit(ErrorDeleteGroupeState());
    });
  }

  /* Change Language */

  // String? changeLanguageTxt;
  changeLanguage({required String? language}) {
    lang = language;
    emit(ChangeLanguageState());
  }
}
