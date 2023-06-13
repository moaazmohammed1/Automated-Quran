import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/modules/student/update_student_data_screen.dart';
import 'package:quran_automated/shared/components/applocal.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/components/drawer_component.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../models/data_model.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

class StudentProfileScreen extends StatelessWidget {
  StudentProfileScreen({required this.data, super.key});
  Data? data;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${getLang(context, "studentProfile")}'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Card(
                  margin: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, right: 20.0, left: 20.0),
                  elevation: 50,
                  shadowColor: const Color(0xFFE4E4E4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                            right: 30.0, left: 30.0, bottom: 10.0),
                        child: Text(
                          '${getLang(context, "userData")}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                        ),
                      ),
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
                              nameFixed: '${getLang(context, "identityNo")}',
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
                              nameFixed: '${getLang(context, "accountStatus")}',
                              nameDynamic: data!.status,
                            ),
                            const SizedBox(height: 35.0),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 20.0, left: 20.0, bottom: 80.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: defaultButton(
                                    text:
                                        '${getLang(context, "updateUserButton")}',
                                    height: 60.0,
                                    onPressedFunction: () {
                                      navigateTo(
                                          context,
                                          UpdateStudentScreen(
                                            data: data!,
                                          ));
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15.0),
                                Expanded(
                                  child: defaultButton(
                                    text:
                                        '${getLang(context, "deleteUserButton")}',
                                    color: redColor,
                                    height: 60.0,
                                    onPressedFunction: () {
                                      deleteMessageDialog(
                                        context,
                                        function: () {
                                          AppCubit.get(context).deleteStudent(
                                            context,
                                            id: data!.id!,
                                          );
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          drawer:   DrawerComponent(),
        );
        // }
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
                nameDynamic ?? '----',
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
