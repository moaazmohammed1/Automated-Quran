import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/all_branches_model.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class AddCenterScreen extends StatefulWidget {
  const AddCenterScreen({super.key});

  @override
  State<AddCenterScreen> createState() => _AddCenterScreenState();
}

class _AddCenterScreenState extends State<AddCenterScreen> {
  TextEditingController branchNameController = TextEditingController();

  TextEditingController localRegionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  AllBranchesModel? allBranchesModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).allBranchesModel == null) {
          AppCubit.get(context).getAllBranchesData();
          return Scaffold(body: Container());
        } else {
          allBranchesModel = AppCubit.get(context).allBranchesModel;
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: '${getLang(context, "addCenter")}',
                centerTitle: true),
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
                            return '${getLang(context, "centerNameRequired")}';
                          }
                          return null;
                        },
                        label: '${getLang(context, "centerName")}',
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
                                                groupValue:
                                                    AppCubit.get(context)
                                                        .selectedCenterStatus,
                                                onChanged: (val) {
                                                  AppCubit.get(context)
                                                      .selectCenterStatus(
                                                          status: 'active');
                                                },
                                              ),
                                              Text(
                                                '${getLang(context, "active")}',
                                                style: const TextStyle(
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: 'pending',
                                                groupValue:
                                                    AppCubit.get(context)
                                                        .selectedCenterStatus,
                                                onChanged: (val) {
                                                  AppCubit.get(context)
                                                      .selectCenterStatus(
                                                          status: 'pending');
                                                },
                                              ),
                                              Text(
                                                '${getLang(context, "pending")}',
                                                style: const TextStyle(
                                                    fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Radio(
                                                value: 'inactive',
                                                groupValue:
                                                    AppCubit.get(context)
                                                        .selectedCenterStatus,
                                                onChanged: (val) {
                                                  AppCubit.get(context)
                                                      .selectCenterStatus(
                                                          status: 'inactive');
                                                },
                                              ),
                                              Text(
                                                '${getLang(context, "inactive")}',
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
                                AppCubit.get(context).selectedCenterStatus != ''
                                    ? AppCubit.get(context).selectedCenterStatus
                                    : '${getLang(context, "centerStatus")}',
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
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.all(5),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      AppCubit.get(context)
                                                          .allBranchesModel!
                                                          .branches!
                                                          .length;
                                                  i++)
                                                Row(
                                                  children: [
                                                    Radio(
                                                      value: i,
                                                      groupValue:
                                                          AppCubit.get(context)
                                                              .selectedBranchId,
                                                      onChanged: (val) {
                                                        AppCubit.get(context)
                                                            .selectBranchId(
                                                          branch: i,
                                                        );
                                                      },
                                                    ),
                                                    Text(
                                                      '${allBranchesModel!.branches![i].name}',
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
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
                                AppCubit.get(context).selectedBranchId != null
                                    ? '${getLang(context, "branch")} : ${allBranchesModel!.branches![AppCubit.get(context).selectedBranchId!].name}'
                                    : '${getLang(context, "branches")}',
                                style: const TextStyle(
                                  fontSize: 18.0,
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
                      const SizedBox(height: 30),
                      defaultButton(
                        text: '${getLang(context, "create")}',
                        height: 60.0,
                        fontSizeText: 18.0,
                        onPressedFunction: () {
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context).addCenter(
                              context,
                              centerName: branchNameController.text,
                              centerStatus:
                                  AppCubit.get(context).selectedCenterStatus,
                              localRegion: localRegionController.text,
                              branchId: AppCubit.get(context)
                                  .allBranchesModel!
                                  .branches![
                                      AppCubit.get(context).selectedBranchId!]
                                  .id,
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
        }
      },
    );
  }
}
