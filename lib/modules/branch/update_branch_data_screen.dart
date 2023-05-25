import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../models/all_branches_model.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

class UpdateBranchScreen extends StatelessWidget {
  BranchData data;
  UpdateBranchScreen({required this.data, super.key});
  TextEditingController branchNameController = TextEditingController();
  TextEditingController localRegionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        branchNameController.text = data.name!;
        localRegionController.text = data.localRegion ?? '';
        return Scaffold(
          appBar: defaultAppBar(
              context: context, title: 'Update Branch', centerTitle: true),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextFormField(
                      controller: branchNameController,
                      keyboard: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Branch Name is required';
                        }
                        return null;
                      },
                      label: 'Branch Name',
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
                                            const Text(
                                              'active',
                                              style: TextStyle(fontSize: 18.0),
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
                                            const Text(
                                              'pending',
                                              style: TextStyle(fontSize: 18.0),
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
                                            const Text(
                                              'inactive',
                                              style: TextStyle(fontSize: 18.0),
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
                                  : 'Branch Status',
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
                      label: 'Local region (option)',
                    ),
                    const SizedBox(height: 30),
                    defaultButton(
                      text: 'update',
                      height: 60.0,
                      fontSizeText: 18.0,
                      onPressedFunction: () {
                        if (formKey.currentState!.validate()) {
                          AppCubit.get(context).updateBranchData(
                            context,
                            id: data.id!,
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
        );
      },
    );
  }
}
