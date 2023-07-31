import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class TestScreen extends StatelessWidget {
  TestScreen({this.id, super.key});
  int? id;
  TextEditingController fromJuzController = TextEditingController();
  TextEditingController toJuzController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController questionNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: '${getLang(context, "generateQuestions")}',
              centerTitle: true),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 15.0),
                    defaultTextFormField(
                      controller: fromJuzController,
                      keyboard: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '${getLang(context, "placeEnterYourFromJuz")}';
                        }
                        return null;
                      },
                      label: '${getLang(context, "fromJuzTest")}',
                    ),
                    const SizedBox(height: 15.0),
                    defaultTextFormField(
                      controller: toJuzController,
                      keyboard: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '${getLang(context, "placeEnterYourToJuz")}';
                        }
                        return null;
                      },
                      label: '${getLang(context, "toJuzTest")}',
                    ),
                    const SizedBox(height: 15.0),
                    defaultTextFormField(
                      controller: questionNumberController,
                      keyboard: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '${getLang(context, "placeEnterYourQuestionNumber")}';
                        }
                        return null;
                      },
                      label: '${getLang(context, "questionNumber")}',
                    ),
                    const SizedBox(height: 15.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      width: double.infinity,
                      height: 60.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: grey100Color,
                            width: 1.5,
                          )),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(5),
                                content: StatefulBuilder(
                                  builder: (context, setState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: 'single',
                                              groupValue: AppCubit.get(context)
                                                  .selectedTypeQuestion,
                                              onChanged: (val) {
                                                AppCubit.get(context)
                                                    .selectedTypeQuestions(
                                                        type: 'single');
                                              },
                                            ),
                                            Text(
                                              '${getLang(context, "single")}',
                                              style: const TextStyle(
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: 'group',
                                              groupValue: AppCubit.get(context)
                                                  .selectedTypeQuestion,
                                              onChanged: (val) {
                                                AppCubit.get(context)
                                                    .selectedTypeQuestions(
                                                        type: 'group');
                                              },
                                            ),
                                            Text(
                                              '${getLang(context, "group")}',
                                              style: const TextStyle(
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              AppCubit.get(context).selectedTypeQuestion != ''
                                  ? AppCubit.get(context).selectedTypeQuestion
                                  : '${getLang(context, "typeQuestion")}',
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: greyColor,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 25.0,
                              color: greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 35.0),
                    // defaultButton(text: 'text', onPressedFunction: (){}),
                    SizedBox(
                      width: 200.0,
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: () {
                          AppCubit.get(context).testModel = null;
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context).getQuestion(
                              context,
                              studentId: id,
                              fromJuz: int.parse(fromJuzController.text),
                              toJuz: int.parse(toJuzController.text),
                              questionNo:
                                  int.parse(questionNumberController.text),
                              type: AppCubit.get(context)
                                          .selectedTypeQuestion ==
                                      ''
                                  ? 'single'
                                  : AppCubit.get(context).selectedTypeQuestion,
                            );
                          }
                        },
                        child: Text(
                          '${getLang(context, "generateQuestions")}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
