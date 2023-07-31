import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/attendance_model.dart';
import 'package:quran_automated/controllers/applocal.dart';
import '../style/style.dart';
import '../components/components.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({super.key});
  AttendanceModel? attendanceModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        attendanceModel = AppCubit.get(context).attendanceModel;

        if (state is LoadingGetAttendanceState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: '${getLang(context, "attendanceAbsence")}',
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (attendanceModel!.all!.isNotEmpty) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 30.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: defaultColor, width: 1.5),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${getLang(context, "dayIs")} ${attendanceModel!.all![index].dayEnName ?? 'null'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          '${getLang(context, "dateIs")} ${attendanceModel!.all![index].absenceDate!}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(color: Colors.black),
                        const SizedBox(height: 10),
                        Text(
                          attendanceModel!.all![index].status == 1
                              ? '${getLang(context, "attendance")}'
                              : '${getLang(context, "absence")}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: attendanceModel!.all!.length,
            ),
          );
        }
      },
    );
  }
}
