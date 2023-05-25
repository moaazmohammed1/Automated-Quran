import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/cubit/app_cubit.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../shared/cubit/app_states.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  List<Map<String, dynamic>>? data;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        data = AppCubit.get(context).studentInReport;
        if (state is LoadingGetReportState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: defaultAppBar(context: context, title: 'Report'),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 130.0,
                          child: text('Student \nName'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide.none,
                              vertical: BorderSide(),
                            ),
                          ),
                          width: 140.0,
                          child: text('Memorization'),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 55.0,
                          child: text(
                            'Absence\nDays',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final studentData = data![index].values.first;
                        final studentName = data![index].keys.first;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 130.0,
                                    child: text(studentName),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                        horizontal: BorderSide.none,
                                        vertical: BorderSide(),
                                      ),
                                    ),
                                    width: 140.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        text(
                                            'من: ${studentData['from_surah_name']}'),
                                        text(
                                            'الأية: ${studentData['from_ayah'].toString()}'),
                                        const SizedBox(height: 15.0),
                                        text(
                                            'الى: ${studentData['to_surah_name']}'),
                                        text(
                                            'الأية: ${studentData['to_ayah'].toString()}'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 55.0,
                                    child: text(
                                      studentData['absence_days'].toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: data!.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  text(tx) => Text(
        tx,
        style: const TextStyle(
          fontSize: 15.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
}
