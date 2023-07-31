import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/all_centers_model.dart';
import 'package:quran_automated/models/all_groups_model.dart';
import 'package:quran_automated/models/all_keepers_model.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class UpdateGroupeScreen extends StatelessWidget {
  GroupeData data;
  UpdateGroupeScreen({required this.data, super.key});
  TextEditingController groupeNameController = TextEditingController();
  TextEditingController localRegionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AllCenterModel? allCentersModel;
  KeepersModel? allKeeperModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).allKeeperModel == null ||
            AppCubit.get(context).allCentersModel == null) {
          AppCubit.get(context).getAllKeepersData();
          AppCubit.get(context).getAllCentersData();
          return Scaffold(body: Container());
        } else {
          allCentersModel = AppCubit.get(context).allCentersModel;
          allKeeperModel = AppCubit.get(context).allKeeperModel;
          groupeNameController.text = data.name!;
          localRegionController.text = data.localRegion ?? '';
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: '${getLang(context, "updateGropePage")}',
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
                        controller: groupeNameController,
                        keyboard: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return '${getLang(context, "groupNameRequired")}';
                          }
                          return null;
                        },
                        label: '${getLang(context, "groupName")}',
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
                                    : (data.status ??
                                        '${getLang(context, "groupeStatus")}'),
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
                                                          .allCentersModel!
                                                          .centers!
                                                          .length;
                                                  i++)
                                                if (allCentersModel!.centers![i]
                                                        .deletedAt ==
                                                    null)
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        value: i,
                                                        groupValue: AppCubit
                                                                .get(context)
                                                            .selectedCenterId,
                                                        onChanged: (val) {
                                                          AppCubit.get(context)
                                                              .selectCenterId(
                                                            center: i,
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        '${allCentersModel!.centers![i].name}',
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
                                AppCubit.get(context).selectedCenterId != null
                                    ? '${getLang(context, "center")} : ${allCentersModel!.centers![AppCubit.get(context).selectedCenterId!].name}'
                                    : AppCubit.get(context)
                                        .getOneCenterModel!
                                        .center!
                                        .name!,
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
                                                          .allKeeperModel!
                                                          .keepers!
                                                          .length;
                                                  i++)
                                                if (allKeeperModel!.keepers![i]
                                                        .deletedAt ==
                                                    null)
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        value: i,
                                                        groupValue: AppCubit
                                                                .get(context)
                                                            .selectedKeeperId,
                                                        onChanged: (val) {
                                                          AppCubit.get(context)
                                                              .selectKeeperId(
                                                            keeper: i,
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        '${allKeeperModel!.keepers![i].fName} ${allKeeperModel!.keepers![i].lName}',
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
                                AppCubit.get(context).selectedKeeperId != null
                                    ? '${getLang(context, "keeper")} : ${allKeeperModel!.keepers![AppCubit.get(context).selectedKeeperId!].fName} ${allKeeperModel!.keepers![AppCubit.get(context).selectedKeeperId!].lName}'
                                    : '${AppCubit.get(context).getOneKeeperModel!.keeper!.fName!} ${AppCubit.get(context).getOneKeeperModel!.keeper!.lName!}',
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
                        text: '${getLang(context, "updateButton")}',
                        height: 60.0,
                        fontSizeText: 18.0,
                        onPressedFunction: () {
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context).updateGroupeData(
                              context,
                              id: data.id!,
                              groupeName: groupeNameController.text,
                              groupeStatus:
                                  AppCubit.get(context).selectedCenterStatus,
                              localRegion: localRegionController.text,
                              keeperId: AppCubit.get(context)
                                  .allKeeperModel!
                                  .keepers![
                                      AppCubit.get(context).selectedKeeperId!]
                                  .id,
                              centerId: AppCubit.get(context)
                                  .allCentersModel!
                                  .centers![
                                      AppCubit.get(context).selectedCenterId!]
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
