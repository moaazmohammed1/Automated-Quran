import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/my_data_model.dart';
import 'package:quran_automated/modules/manage_account/update_my_account_screen.dart';
import 'package:quran_automated/modules/student/attendance_scree.dart';
import 'package:quran_automated/modules/student/memorization_screen.dart';
import 'package:quran_automated/modules/student/my_test_mark_screen.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/cubit/app_cubit.dart';
import 'package:quran_automated/shared/network/end_point.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../shared/cubit/app_states.dart';
import '../user/follow_links_screen.dart';
import '../user/registration_links_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  MyDataModel? data;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).myData == null) {
          AppCubit.get(context).getMyData();
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          data = AppCubit.get(context).myData;
          return Scaffold(
            appBar: AppBar(
              title: const Text('My profile'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Card(
                    margin: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, right: 20.0, left: 20.0),
                    elevation: 50,
                    shadowColor: const Color(0xFFE4E4E4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.only(left: 30.0, bottom: 10.0),
                            child: Text(
                              'User Data:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                    fontSize: 20.0,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                item(
                                  context,
                                  nameFixed: 'Name: ',
                                  nameDynamic:
                                      '${data!.fName} ${data!.sName ?? ''} ${data!.tName ?? ''} ${data!.lName}',
                                ),
                                item(
                                  context,
                                  nameFixed: '$position ID: ',
                                  nameDynamic: data!.identityNo,
                                ),
                                item(
                                  context,
                                  nameFixed: 'Phone Number: ',
                                  nameDynamic: data!.phone ?? '----',
                                ),
                                item(
                                  context,
                                  nameFixed: 'Email: ',
                                  nameDynamic: data!.email ?? '----',
                                ),
                                item(
                                  context,
                                  nameFixed: 'Position: ',
                                  nameDynamic: data!.position,
                                ),
                                item(
                                  context,
                                  nameFixed: 'Account status: ',
                                  nameDynamic: data!.status,
                                ),
                                const SizedBox(height: 35.0),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50.0),
                          if (position != 'student')
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20.0, left: 20.0, bottom: 60.0),
                              child: Column(
                                children: [
                                  if (position != 'student')
                                    Row(
                                      children: [
                                        Expanded(
                                          child: defaultButton(
                                            text: 'Follow page',
                                            height: 50.0,
                                            onPressedFunction: () {
                                              navigateTo(
                                                context,
                                                const FollowScreen(),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 15.0),
                                        Expanded(
                                          child: defaultButton(
                                            text: 'register page',
                                            height: 50.0,
                                            onPressedFunction: () {
                                              navigateTo(context,
                                                  const RegistrationScreen());
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: defaultButton(
                                          text: 'update my Data',
                                          height: 50.0,
                                          onPressedFunction: () {
                                            navigateTo(
                                                context,
                                                UpdateMyAccountScreen(
                                                    data: data!));
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                      Expanded(
                                        child: defaultButton(
                                          text: 'Delete Account',
                                          height: 50.0,
                                          color: redColor,
                                          onPressedFunction: () {
                                            deleteMessageDialog(
                                              context,
                                              function: () {
                                                AppCubit.get(context)
                                                    .deleteMyAccount(context);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          if (position == 'student')
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20.0, left: 20.0, bottom: 10.0),
                              child: defaultButton(
                                text: 'View My Keep',
                                height: 50.0,
                                onPressedFunction: () {
                                  navigateTo(context, SaveAndReviewScreen());
                                },
                              ),
                            ),
                          if (position == 'student')
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20.0, left: 20.0, bottom: 10.0),
                              child: defaultButton(
                                text: 'View Attendance Day',
                                height: 50.0,
                                onPressedFunction: () {
                                  AppCubit.get(context).getAttendance();
                                  navigateTo(context, AttendanceScreen());
                                },
                              ),
                            ),
                          if (position == 'student')
                            Container(
                              margin: const EdgeInsets.only(
                                  right: 20.0, left: 20.0, bottom: 60.0),
                              child: defaultButton(
                                text: 'View My Test Mark',
                                height: 50.0,
                                onPressedFunction: () {
                                  navigateTo(context, MyTestMarkScreen());
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            drawer: defaultDrawer(context),
          );
        }
      },
    );
  }

  item(context, {nameFixed, nameDynamic}) => Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 170.0,
              child: Text(
                nameFixed,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                    ),
              ),
            ),
            Flexible(
              child: Text(
                nameDynamic ?? '',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
