import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/my_data_model.dart';
import 'package:quran_automated/view/manage_account/update_my_account_screen.dart';
import 'package:quran_automated/view/student/attendance_scree.dart';
import 'package:quran_automated/view/student/memorization_screen.dart';
import 'package:quran_automated/view/student/my_test_mark_screen.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/controllers/cubit/app_cubit.dart';
import 'package:quran_automated/controllers/network/end_point.dart';
import '../style/style.dart';
import '../components/drawer_component.dart';
import '../../controllers/cubit/app_states.dart';
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
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  signOut(context);
                },
                child: Text(
                  '${getLang(context, "out")}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          data = AppCubit.get(context).myData;
          return Scaffold(
            appBar: AppBar(
              title: Text('${getLang(context, "myProfileTitle")}'),
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
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, bottom: 10.0),
                            child: Text(
                              '${getLang(context, "userData")}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38,
                                    fontSize: 17.0,
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
                                  nameFixed: '${getLang(context, "name")}',
                                  nameDynamic:
                                      '${data!.fName} ${data!.sName ?? ''} ${data!.tName ?? ''} ${data!.lName}',
                                ),
                                item(
                                  context,
                                  nameFixed:
                                      '${getLang(context, "identityNo")}',
                                  nameDynamic: data!.identityNo,
                                ),
                                item(
                                  context,
                                  nameFixed: '${getLang(context, "phoneNo")}',
                                  nameDynamic: data!.phone ?? '----',
                                ),
                                item(
                                  context,
                                  nameFixed: '${getLang(context, "email")}',
                                  nameDynamic: data!.email ?? '----',
                                ),
                                item(
                                  context,
                                  nameFixed: '${getLang(context, "position")}',
                                  nameDynamic: data!.position,
                                ),
                                item(
                                  context,
                                  nameFixed:
                                      '${getLang(context, "accountStatus")}',
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
                                            text:
                                                '${getLang(context, "followPageButton")}',
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
                                            text:
                                                '${getLang(context, "registerPageButton")}',
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
                                          text:
                                              '${getLang(context, "updateMyAccountButton")}',
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
                                          text:
                                              '${getLang(context, "deleteMyAccountButton")}',
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
            drawer: DrawerComponent(),
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
