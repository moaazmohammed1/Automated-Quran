import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';

import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class AddBranchScreen extends StatelessWidget {
  AddBranchScreen({super.key});

  TextEditingController branchNameController = TextEditingController();
  TextEditingController localRegionController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: defaultAppBar(
            context: context,
            title: '${getLang(context, "addBranch")}',
            centerTitle: true),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultTextFormField(
                    controller: branchNameController,
                    keyboard: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return '${getLang(context, "branchNameRequired")}';
                      }
                      return null;
                    },
                    label: '${getLang(context, "branchName")}',
                  ),
                  const SizedBox(height: 20),
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
                                            value: 'active',
                                            groupValue: AppCubit.get(context)
                                                .selectedBranchStatus,
                                            onChanged: (val) {
                                              AppCubit.get(context)
                                                  .selectBranchStatus(
                                                      status: 'active');
                                            },
                                          ),
                                          Text(
                                            '${getLang(context, "active")}',
                                            style:
                                                const TextStyle(fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: 'pending',
                                            groupValue: AppCubit.get(context)
                                                .selectedBranchStatus,
                                            onChanged: (val) {
                                              AppCubit.get(context)
                                                  .selectBranchStatus(
                                                      status: 'pending');
                                            },
                                          ),
                                          Text(
                                            '${getLang(context, "pending")}',
                                            style:
                                                const TextStyle(fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                            value: 'inactive',
                                            groupValue: AppCubit.get(context)
                                                .selectedBranchStatus,
                                            onChanged: (val) {
                                              AppCubit.get(context)
                                                  .selectBranchStatus(
                                                      status: 'inactive');
                                            },
                                          ),
                                          Text(
                                            '${getLang(context, "inactive")}',
                                            style:
                                                const TextStyle(fontSize: 18.0),
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
                            AppCubit.get(context).selectedBranchStatus != ''
                                ? AppCubit.get(context).selectedBranchStatus
                                : '${getLang(context, "branchStatus")}',
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
                  const SizedBox(height: 20),
                  defaultTextFormField(
                    controller: localRegionController,
                    keyboard: TextInputType.text,
                    label: '${getLang(context, "localRegion")}',
                  ),
                  const SizedBox(height: 30),
                  defaultButton(
                    text: '${getLang(context, "create")}',
                    height: 60.0,
                    fontSizeText: 18.0,
                    onPressedFunction: () {
                      if (formKey.currentState!.validate()) {
                        AppCubit.get(context).addBranch(
                          context,
                          branchName: branchNameController.text,
                          branchStatus:
                              AppCubit.get(context).selectedBranchStatus,
                          localRegion: localRegionController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
