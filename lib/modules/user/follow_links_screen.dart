import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/modules/DS/all_report_supervisor_screen.dart';
import 'package:quran_automated/modules/admin/all_admin_screen.dart';
import 'package:quran_automated/modules/branch/all_branches_screen.dart';
import 'package:quran_automated/modules/center/all_centers_screen.dart';
import 'package:quran_automated/modules/groupe/all_groups_screen.dart';
import 'package:quran_automated/modules/keeper/all_report_keeper_screen.dart';
import 'package:quran_automated/modules/keeper/my_all_tests_screen.dart';
import 'package:quran_automated/modules/keeper/report_screen.dart';
import 'package:quran_automated/modules/manage_account/home_screen.dart';
import 'package:quran_automated/modules/student/all_student_screen.dart';
import 'package:quran_automated/modules/student/student_attendance_screen.dart';
import 'package:quran_automated/modules/user/registration_links_screen.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';
import '../../shared/network/end_point.dart';
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
            title: 'Follow Screen',
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
                        text: 'Admins',
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
                        text: 'Supervisors',
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
                        text: 'Keeper',
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
                        text: 'Students',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllStudentsScreen(),
                          );
                        },
                      ),

                    if (position == 'keeper')
                      textButtonApp(
                        text: 'Students',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllStudentsInGroupeScreen(),
                          );
                        },
                      ),
                    if (position == 'keeper')
                      textButtonApp(
                        text: 'Store Student Absence',
                        function: () {
                          navigateTo(
                            context,
                            const StoreStudentAttendanceScreen(),
                          );
                        },
                      ),
                    if (position == 'keeper')
                      textButtonApp(
                        text: 'Report',
                        function: () {
                          AppCubit.get(context).getReport(context);
                          navigateTo(context, ReportScreen());
                        },
                      ),
                    if (position == 'keeper')
                      textButtonApp(
                        text: 'Tests Represented',
                        function: () {
                          navigateTo(context, AllTestsScreen());
                        },
                      ),
                    if (position == 'keeper')
                      textButtonApp(
                        text: 'All Reports',
                        function: () {
                          navigateTo(context, AllReportsKeeperScreen());
                        },
                      ),
                    //
                    if (position == 'admin' || position == 'manager')
                      textButtonApp(
                        text: 'Branch',
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
                        text: 'Center',
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
                        text: 'Groupe',
                        function: () {
                          navigateTo(
                            context,
                            FollowAllGroupsScreen(),
                          );
                        },
                      ),
                    if (position == 'supervisor')
                      textButtonApp(
                        text: 'All Reports',
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
