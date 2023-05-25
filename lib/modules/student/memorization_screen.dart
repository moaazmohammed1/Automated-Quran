import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/keep_model.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';
import 'package:intl/intl.dart';

class SaveAndReviewScreen extends StatelessWidget {
  SaveAndReviewScreen({super.key});
  KeepModel? keepModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).keepModel == null) {
          AppCubit.get(context).studentViewKeep();
          return Scaffold(
            appBar: AppBar(
              title: const Text('Student Memorization'),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          keepModel = AppCubit.get(context).keepModel;
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Memorization',
            ),
            body: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (keepModel!.keeps!.data!.isNotEmpty) {
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
                          'Day is :  ${keepModel!.keeps!.data![index].dayEnName ?? 'null'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          // DateFormat.yMd().format(
                          'Date is : ${DateFormat.yMMMd().format(
                            DateTime.parse(
                                keepModel!.keeps!.data![index].createdAt!),
                          )}',
                          // '',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(color: Colors.black),
                        const SizedBox(height: 10),
                        const Text(
                          'The Keep:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Surah: ${keepModel!.keeps!.data![index].fromSurah}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'From Ayah: ${keepModel!.keeps!.data![index].fromAyah}  To Ayah: ${keepModel!.keeps!.data![index].toAyah}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Faults number: ${keepModel!.keeps!.data![index].faults}',
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
              separatorBuilder: (context, index) => Container(),
              itemCount: keepModel!.keeps!.data!.length,
            ),
          );
        }
      },
    );
  }
}
