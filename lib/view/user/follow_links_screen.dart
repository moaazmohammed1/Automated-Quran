import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/view/DS/all_report_supervisor_screen.dart';
import 'package:quran_automated/view/admin/all_admin_screen.dart';
import 'package:quran_automated/view/branch/all_branches_screen.dart';
import 'package:quran_automated/view/center/all_centers_screen.dart';
import 'package:quran_automated/view/groupe/all_groups_screen.dart';
import 'package:quran_automated/view/keeper/all_report_keeper_screen.dart';
import 'package:quran_automated/view/keeper/my_all_tests_screen.dart';
import 'package:quran_automated/view/keeper/report_screen.dart';
import 'package:quran_automated/view/manage_account/home_screen.dart';
import 'package:quran_automated/view/student/all_student_screen.dart';
import 'package:quran_automated/view/student/student_attendance_screen.dart';
import 'package:quran_automated/view/user/registration_links_screen.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';
import '../../controllers/network/end_point.dart';
import '../DS/all_ds_screen.dart';
import '../keeper/all_keeper_screen.dart';
import '../student/all_student_in_groupe_screen.dart';

class FollowScreen extends StatelessWidget {
  const FollowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            leading: IconButton(
                onPressed: () {
                  navigateTo(context, HomeScreen());
                },
                icon: const Icon(Icons.arrow_back)),
            context: context,
            title: '${getLang(context, "followPageButton")}',
            centerTitle: true,
          ),
          body: Container(
            height: 600.0,
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(color: defaultColor, width: 1.5),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //
                    if (position == 'manager' || position == 'admin')
                      textButtonApp(
                        text: '${getLang(context, "admins")}',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllAdminScreen(),
                          );
                        },
                      ),

                    //
                    if (position == 'manager' || position == 'admin'
                    // ||
                    // position == 'supervisor'
                    )
                      textButtonApp(
                        text: '${getLang(context, "dss")}',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllDSScreen(),
                          );
                        },
                      ),

                    //
                    if (position == 'manager' ||
                        position == 'admin' ||
                        position == 'supervisor')
                      textButtonApp(
                        text: '${getLang(context, "keepers")}',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllKeepersScreen(),
                          );
                        },
                      ),

                    //
                    if (position == 'manager' ||
                        position == 'admin' ||
                        position == 'supervisor')
                      textButtonApp(
                        text: '${getLang(context, "students")}',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllStudentsScreen(),
                          );
                        },
                      ),

                    if (position == 'keeper')
                      textButtonApp(
                        text: '${getLang(context, "students")}',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllStudentsInGroupeScreen(),
                          );
                        },
                      ),
                    if (position == 'keeper')
                      textButtonApp(
                        text: '${getLang(context, "storeStudentAbsence")}',
                        function: () {
                          navigateTo(
                            context,
                            const StoreStudentAttendanceScreen(),
                          );
                        },
                      ),
                    if (position == 'keeper')
                      textButtonApp(
                        text: '${getLang(context, "report")}',
                        function: () {
                          // AppCubit.get(context).getReport(context);

                          AppCubit.get(context).studentInReport = null;
                          navigateTo(context, ReportScreen());
                        },
                      ),
                    if (position == 'keeper')
                      textButtonApp(
                        text: '${getLang(context, "testRepresented")}',
                        function: () {
                          navigateTo(context, AllTestsScreen());
                        },
                      ),
                    if (position == 'keeper')
                      textButtonApp(
                        text: '${getLang(context, "allReports")}',
                        function: () {
                          navigateTo(context, AllReportsKeeperScreen());
                        },
                      ),
                    //
                    if (position == 'admin' || position == 'manager')
                      textButtonApp(
                        text: '${getLang(context, "branches")}',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllBranchesScreen(),
                          );
                        },
                      ),

                    //
                    if (position == 'admin' ||
                        position == 'manager' ||
                        position == 'supervisor')
                      textButtonApp(
                        text: '${getLang(context, "centers")}',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllCentersScreen(),
                          );
                        },
                      ),

                    //
                    if (position == 'admin' ||
                        position == 'manager' ||
                        position == 'supervisor')
                      textButtonApp(
                        text: '${getLang(context, "groups")}',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllGroupsScreen(),
                          );
                        },
                      ),
                    if (position == 'supervisor')
                      textButtonApp(
                        text: '${getLang(context, "allReports")}',
                        function: () {
                          navigateTo(
                            context,
                            AllReportsSupervisorScreen(),
                          );
                        },
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
