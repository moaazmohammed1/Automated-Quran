import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/view/components/drawer_component.dart';
import '../style/style.dart';
import '../../models/all_student_in_groupe_model.dart';
import '../../models/data_model.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';
import '../user/follow_links_screen.dart';

class StoreStudentAttendanceScreen extends StatefulWidget {
  const StoreStudentAttendanceScreen({super.key});

  @override
  State<StoreStudentAttendanceScreen> createState() =>
      _StoreStudentAttendanceScreenState();
}

class _StoreStudentAttendanceScreenState
    extends State<StoreStudentAttendanceScreen> {
  StudentsInGroupeModel? studentsInGroupeModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).studentsInGroupeModel == null &&
            AppCubit.get(context).jsonMessage == null) {
          AppCubit.get(context).getAllStudentsInGroupeData();
          return Scaffold(
            appBar: AppBar(
              title: Text('${getLang(context, "storeAttendanceAbsence")}'),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          if (AppCubit.get(context).studentsInGroupeModel != null) {
            studentsInGroupeModel = AppCubit.get(context).studentsInGroupeModel;
            if (studentsInGroupeModel!.group != null ||
                studentsInGroupeModel!.group!.isNotEmpty) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('${getLang(context, "storeAttendanceAbsence")}'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        navigateTo(context, const FollowScreen());
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (studentsInGroupeModel!
                              .group![0].students![index].deletedAt ==
                          null) {
                        return builderWidget(
                            studentsInGroupeModel!.group![0].students![index],
                            context);
                      } else {
                        return Container();
                      }
                    },
                    separatorBuilder: (context, index) => Container(),
                    itemCount:
                        studentsInGroupeModel!.group![0].students!.length,
                  ),
                ),
                drawer:   DrawerComponent(),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    '${getLang(context, "allStudentsInGroup")}',
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ],
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_off_sharp,
                        color: Colors.grey,
                        size: 150.0,
                      ),
                      const SizedBox(height: 50.0),
                      Text(
                        '${getLang(context, "studentsNotFounds")}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                drawer:   DrawerComponent(),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  '${getLang(context, "allStudentsInGroup")}',
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_off_sharp,
                      color: Colors.grey,
                      size: 150.0,
                    ),
                    const SizedBox(height: 50.0),
                    Text(
                      AppCubit.get(context).jsonMessage ?? 'null',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              drawer:   DrawerComponent(),
            );
          }
        }
      },
    );
  }

  Widget builderWidget(Data model, context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${model.fName!} ${model.sName ?? ''} ${model.tName ?? ''} ${model.lName!}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 200.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        AppCubit.get(context)
                                    .mapStudentsInGroupe['${model.id}'] ==
                                0
                            ? AppCubit.get(context)
                                .mapStudentsInGroupe['${model.id}'] = 1
                            : AppCubit.get(context)
                                .mapStudentsInGroupe['${model.id}'] = 0;
                      });
                      AppCubit.get(context).storeStudentAbsence(
                          studentId: model.id!,
                          isAttendance: AppCubit.get(context)
                              .mapStudentsInGroupe['${model.id}']!);
                      printStatement(AppCubit.get(context)
                          .mapStudentsInGroupe['${model.id}']!);
                      printStatement(AppCubit.get(context).mapStudentsInGroupe);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppCubit.get(context)
                                      .mapStudentsInGroupe['${model.id}'] ==
                                  0
                              ? Colors.red
                              : Colors.green),
                      // padding: MaterialStateProperty.all(
                      //     const EdgeInsets.symmetric(
                      //         vertical: 10.0, horizontal: 10.0)),
                    ),
                    child: AppCubit.get(context)
                                .mapStudentsInGroupe['${model.id}'] ==
                            0
                        ? Text('${getLang(context, "clickToAbsence")}')
                        : Text('${getLang(context, "clickToAttendance")}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
