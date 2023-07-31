import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/tests_model.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen({this.id, super.key});
  int? id;
  TextEditingController markController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  TestModel? testModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        testModel = AppCubit.get(context).testModel!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: '${getLang(context, "testQuestions")}',
          ),
          body: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => container(
                          testModel!.questions![index].surah!.name!,
                          testModel!.questions![index].text!),
                      itemCount: testModel!.questions!.length,
                    ),
                  ),
                  const Divider(thickness: 5),
                  Container(
                    height: 60.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    margin: const EdgeInsets.all(15.0),
                    child: defaultTextFormField(
                      label: '${getLang(context, "enterStudentMark")}',
                      controller: markController,
                      keyboard: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '${getLang(context, "RequiredStudentMark")}';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15.0),
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: defaultButton(
                      height: 60.0,
                      fontSizeText: 17.0,
                      text: '${getLang(context, "submitMark")}',
                      onPressedFunction: () {
                        AppCubit.get(context).sendMarkQuestion(
                          context,
                          mark: int.parse(markController.text),
                          testId: testModel!.testId,
                        );
                      },
                    ),
                  ),
                ],
              ),
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
