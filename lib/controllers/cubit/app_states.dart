import '../../models/user_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

// **

class LoadingGetMyDataState extends AppStates {}

class SuccessGetMyDataState extends AppStates {}

class ErrorGetMyDataState extends AppStates {}

// **

class LoadingUpdateMyAccountState extends AppStates {}

class SuccessUpdateMyAccountState extends AppStates {}

class ErrorUpdateMyAccountState extends AppStates {}

// **

class LoadingChangeMyPasswordState extends AppStates {}

class SuccessChangeMyPasswordState extends AppStates {}

class ErrorChangeMyPasswordState extends AppStates {}

// **

class LoadingDeleteMyAccountState extends AppStates {}

class SuccessDeleteMyAccountState extends AppStates {}

class ErrorDeleteMyAccountState extends AppStates {}

// **

class AddAdminLoadingState extends AppStates {}

class AddAdminSuccessState extends AppStates {}

class AddAdminErrorState extends AppStates {
  final String error;
  AddAdminErrorState(this.error);
}

// **

class LoadingGetAdminDataState extends AppStates {}

class SuccessGetAdminDataState extends AppStates {
  UserModel? userData;
  SuccessGetAdminDataState(this.userData);
}

class ErrorGetAdminDataState extends AppStates {}

// **

class LoadingUpdateAdminState extends AppStates {}

class SuccessUpdateAdminState extends AppStates {
  UserModel? adminData;
  SuccessUpdateAdminState(this.adminData);
}

class ErrorUpdateAdminState extends AppStates {}

// **

class LoadingGetAllAdminState extends AppStates {}

class SuccessGetAllAdminState extends AppStates {}

class ErrorGetAllAdminState extends AppStates {}

// **

class LoadingDeleteAdminState extends AppStates {}

class SuccessDeleteAdminState extends AppStates {}

class ErrorDeleteAdminState extends AppStates {}

// **

class ChangePasswordVisibilityState extends AppStates {}

// **

class GenderState extends AppStates {}

class StatusState extends AppStates {}

//
/* Direct Supervisor States */

class LoadingAddDirectSupervisorState extends AppStates {}

class SuccessAddDirectSupervisorState extends AppStates {}

class ErrorAddDirectSupervisorState extends AppStates {}

///

class LoadingGetAllDirectSupervisorState extends AppStates {}

class SuccessGetAllDirectSupervisorState extends AppStates {}

class ErrorGetAllDirectSupervisorState extends AppStates {}

///

class LoadingDeleteDirectSupervisorState extends AppStates {}

class SuccessDeleteDirectSupervisorState extends AppStates {}

class ErrorDeleteDirectSupervisorState extends AppStates {}

///

class LoadingUpdateDirectSupervisorState extends AppStates {}

class SuccessUpdateDirectSupervisorState extends AppStates {}

class ErrorUpdateDirectSupervisorState extends AppStates {}

/* Keeper States */

class LoadingAddKeeperState extends AppStates {}

class SuccessAddKeeperState extends AppStates {}

class ErrorAddKeeperState extends AppStates {}

///

class LoadingGetKeeperDataState extends AppStates {}

class SuccessGetKeeperDataState extends AppStates {}

class ErrorGetKeeperDataState extends AppStates {}

///

class LoadingGetAllKeeperState extends AppStates {}

class SuccessGetAllKeeperState extends AppStates {}

class ErrorGetAllKeeperState extends AppStates {}

///

class LoadingUpdateKeeperState extends AppStates {}

class SuccessUpdateKeeperState extends AppStates {}

class ErrorUpdateKeeperState extends AppStates {}

///

class LoadingDeleteKeeperState extends AppStates {}

class SuccessDeleteKeeperState extends AppStates {}

class ErrorDeleteKeeperState extends AppStates {}

///

class LoadingUpdateKeepersState extends AppStates {}

class SuccessUpdateKeepersState extends AppStates {}

class ErrorUpdateKeepersState extends AppStates {}

/* Student States */

class LoadingAddStudentState extends AppStates {}

class SuccessAddStudentState extends AppStates {}

class ErrorAddStudentState extends AppStates {}

///

class LoadingGetAllStudentState extends AppStates {}

class SuccessGetAllStudentState extends AppStates {}

class ErrorGetAllStudentState extends AppStates {}

///

// class LoadingUpdateKeeperState extends AppStates {}

// class SuccessUpdateKeeperState extends AppStates {}

// class ErrorUpdateKeeperState extends AppStates {}

///

class LoadingDeleteStudentState extends AppStates {}

class SuccessDeleteStudentState extends AppStates {}

class ErrorDeleteStudentState extends AppStates {}

///

class LoadingUpdateStudentState extends AppStates {}

class SuccessUpdateStudentState extends AppStates {}

class ErrorUpdateStudentState extends AppStates {}

/* Groupe Student States */

class LoadingAddStudentInGroupeState extends AppStates {}

class SuccessAddStudentInGroupeState extends AppStates {}

class ErrorAddStudentInGroupeState extends AppStates {}

///

class LoadingGetAllStudentInGroupeState extends AppStates {}

class SuccessGetAllStudentInGroupeState extends AppStates {}

class ErrorGetAllStudentInGroupeState extends AppStates {}

//
/* Juz States */

class LoadingGetSpecificJuzInformationState extends AppStates {}

class SuccessGetSpecificJuzInformationState extends AppStates {}

class ErrorGetSpecificJuzInformationState extends AppStates {}

///

class JuzState extends AppStates {}

class SuraState extends AppStates {}

class FromAyahState extends AppStates {}

class ToAyahState extends AppStates {}

///

class LoadingRegisterNewKeepState extends AppStates {}

class SuccessRegisterNewKeepState extends AppStates {}

class ErrorRegisterNewKeepState extends AppStates {}

///

class LoadingStoreStudentAbsenceState extends AppStates {}

class SuccessStoreStudentAbsenceState extends AppStates {}

class ErrorStoreStudentAbsenceState extends AppStates {}

///

class LoadingGetQuestionState extends AppStates {}

class SuccessGetQuestionState extends AppStates {}

class ErrorGetQuestionState extends AppStates {}

//

class LoadingGetMyTestState extends AppStates {}

class SuccessGetMyTestState extends AppStates {}

class ErrorGetMyTestState extends AppStates {}

//

class LoadingGetKeeperTestState extends AppStates {}

class SuccessGetKeeperTestState extends AppStates {}

class ErrorGetKeeperTestState extends AppStates {}

//

class LoadingAllReportKeeperState extends AppStates {}

class SuccessAllReportKeeperState extends AppStates {}

class ErrorAllReportKeeperState extends AppStates {}

//

class LoadingAllReportSupervisorState extends AppStates {}

class SuccessAllReportSupervisorState extends AppStates {}

class ErrorAllReportSupervisorState extends AppStates {}

//

class LoadingSendMarkState extends AppStates {}

class SuccessSendMarkState extends AppStates {}

class ErrorSendMarkState extends AppStates {}

//

class LoadingGetReportState extends AppStates {}

class SuccessGetReportState extends AppStates {}

class ErrorGetReportState extends AppStates {}

//

class LoadingGetAttendanceState extends AppStates {}

class SuccessGetAttendanceState extends AppStates {}

class ErrorGetAttendanceState extends AppStates {}

//
class TypeQuestionState extends AppStates {}

//
/* Student Keep States */

class LoadingStudentViewKeepState extends AppStates {}

class SuccessStudentViewKeepState extends AppStates {}

class ErrorStudentViewKeepState extends AppStates {}

//
/* Branch States */

class LoadingAddBranchState extends AppStates {}

class SuccessAddBranchState extends AppStates {}

class ErrorAddBranchState extends AppStates {}

///

class LoadingGetBranchDataState extends AppStates {}

class SuccessGetBranchDataState extends AppStates {}

class ErrorGetBranchDataState extends AppStates {}

///

class LoadingGetAllBranchesState extends AppStates {}

class SuccessGetAllBranchesState extends AppStates {}

class ErrorGetAllBranchesState extends AppStates {}

///

class LoadingUpdateBranchState extends AppStates {}

class SuccessUpdateBranchState extends AppStates {}

class ErrorUpdateBranchState extends AppStates {}

///

class LoadingDeleteBranchState extends AppStates {}

class SuccessDeleteBranchState extends AppStates {}

class ErrorDeleteBranchState extends AppStates {}

///

class BranchStatusState extends AppStates {}

//
/* Center States */

class LoadingAddCenterState extends AppStates {}

class SuccessAddCenterState extends AppStates {}

class ErrorAddCenterState extends AppStates {}

///

class LoadingGetCenterDataState extends AppStates {}

class SuccessGetCenterDataState extends AppStates {}

class ErrorGetCenterDataState extends AppStates {}

///

class LoadingGetAllCenterState extends AppStates {}

class SuccessGetAllCenterState extends AppStates {}

class ErrorGetAllCenterState extends AppStates {}

///

class LoadingUpdateCenterState extends AppStates {}

class SuccessUpdateCenterState extends AppStates {}

class ErrorUpdateCenterState extends AppStates {}

///

class LoadingDeleteCenterState extends AppStates {}

class SuccessDeleteCenterState extends AppStates {}

class ErrorDeleteCenterState extends AppStates {}

///
class CenterStatusState extends AppStates {}

class BranchIdState extends AppStates {}

//
/* Groupe States */

class LoadingAddGroupeState extends AppStates {}

class SuccessAddGroupeState extends AppStates {}

class ErrorAddGroupeState extends AppStates {}

///

class LoadingGetGroupeDataState extends AppStates {}

class SuccessGetGroupeDataState extends AppStates {}

class ErrorGetGroupeDataState extends AppStates {}

//

class LoadingGetAllGroupeState extends AppStates {}

class SuccessGetAllGroupeState extends AppStates {}

class ErrorGetAllGroupeState extends AppStates {}

///

class LoadingUpdateGroupeState extends AppStates {}

class SuccessUpdateGroupeState extends AppStates {}

class ErrorUpdateGroupeState extends AppStates {}

///

class LoadingDeleteGroupeState extends AppStates {}

class SuccessDeleteGroupeState extends AppStates {}

class ErrorDeleteGroupeState extends AppStates {}

///

class GroupeStatusState extends AppStates {}

class CenterIdState extends AppStates {}

class KeeperIdState extends AppStates {}

//

class ChangeLanguageState extends AppStates {}
