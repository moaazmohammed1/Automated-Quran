import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/controllers/cubit/app_cubit.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_states.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  List<Map<String, dynamic>>? data;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).studentInReport == null) {
          AppCubit.get(context).getReport(context);
        }
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
            appBar: defaultAppBar(
                context: context, title: '${getLang(context, "report")}'),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  if (data != null)
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
                            child: text(
                                '${getLang(context, "studentNameReport")}'),
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
                            child: text(
                                '${getLang(context, "monthlyMemorization")}'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                alignment: Alignment.center,
                                width: 55.0,
                                child: text(
                                  '${getLang(context, "absenceDays")}',
                                  // Absence\nDays',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  if (data != null)
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
                                              '${getLang(context, "from")}: ${studentData['from_surah_name']}'),
                                          text(
                                              '${getLang(context, "ayah")}: ${studentData['from_ayah'].toString()}'),
                                          const SizedBox(height: 15.0),
                                          text(
                                              '${getLang(context, "to")}: ${studentData['to_surah_name']}'),
                                          text(
                                              '${getLang(context, "ayah")}: ${studentData['to_ayah'].toString()}'),
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
                  if (data == null)
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
                      child: Text('msg'),
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
