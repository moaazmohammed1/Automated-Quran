import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/test_model.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({super.key});
  List<Question> tests = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        tests = AppCubit.get(context).tests!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Test Questions',
          ),
          body: Center(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  container(tests[index].surah!.name!, tests[index].text!),
              itemCount: tests.length,
            ),
          ),
        );
      },
    );
  }

  container(surahName, surahText) => Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        width: double.infinity,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$surahName :',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              alignment: Alignment.centerRight,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              decoration: BoxDecoration(
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '"$surahText"',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      );
}
