import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/get_one_center_model.dart';
import 'package:quran_automated/models/get_one_keeper_model.dart';
import 'package:quran_automated/view/groupe/update_groupe_data_screen.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/view/components/drawer_component.dart';
import '../style/style.dart';
import '../../models/all_centers_model.dart';
import '../../models/all_groups_model.dart';
import '../../models/all_keepers_model.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class GroupeProfileScreen extends StatelessWidget {
  GroupeProfileScreen({required this.data, super.key});
  GroupeData data;
  GetOneCenterModel? getOneCenterModel;
  GetOneKeeperModel? getOneKeeperModel;
  AllCenterModel? allCenterModel;
  KeepersModel? allKeeperModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).allKeeperModel == null ||
            AppCubit.get(context).allCentersModel == null) {
          AppCubit.get(context).getAllCentersData();
          AppCubit.get(context).getAllKeepersData();
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          if (AppCubit.get(context).getOneCenterModel == null ||
              AppCubit.get(context).getOneCenterModel!.center!.id !=
                  data.centerId ||
              AppCubit.get(context).getOneKeeperModel == null ||
              AppCubit.get(context).getOneKeeperModel!.keeper!.id !=
                  data.keeperId) {
            AppCubit.get(context).getCenterData(id: data.centerId!);
            AppCubit.get(context).getKeeperData(id: data.keeperId!);
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: defaultColor,
                ),
              ),
            );
          } else {
            getOneKeeperModel = AppCubit.get(context).getOneKeeperModel;
            getOneCenterModel = AppCubit.get(context).getOneCenterModel;
            allCenterModel = AppCubit.get(context).allCentersModel;
            allKeeperModel = AppCubit.get(context).allKeeperModel;
            return Scaffold(
              appBar: AppBar(
                title: Text('${getLang(context, "groupProfile")}'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  )
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, right: 20.0, left: 20.0),
                      elevation: 50,
                      shadowColor: const Color(0xFFE4E4E4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.only(left: 30.0, bottom: 10.0),
                            child: Text(
                              '${getLang(context, "userData")}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                item(
                                  context,
                                  nameFixed: '${getLang(context, "name")} ',
                                  nameDynamic: '${data.name}',
                                ),
                                item(
                                  context,
                                  nameFixed:
                                      '${getLang(context, "accountStatus")} ',
                                  nameDynamic: data.status,
                                ),
                                item(
                                  context,
                                  nameFixed:
                                      '${getLang(context, "localRegion")}: ',
                                  nameDynamic: data.localRegion ?? '------',
                                ),
                                item(
                                  context,
                                  nameFixed: '${getLang(context, "center")}: ',
                                  nameDynamic:
                                      getOneCenterModel!.center!.name ?? '',
                                ),
                                item(
                                  context,
                                  nameFixed: '${getLang(context, "keeper")}: ',
                                  nameDynamic:
                                      getOneKeeperModel!.keeper!.fName ?? '',
                                ),
                                const SizedBox(height: 35.0),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.only(
                                right: 20.0, left: 20.0, bottom: 80.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: defaultButton(
                                        text:
                                            '${getLang(context, "updateGropePage")}',
                                        height: 60.0,
                                        onPressedFunction: () {
                                          navigateTo(
                                            context,
                                            UpdateGroupeScreen(
                                              data: data,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 15.0),
                                    Expanded(
                                      child: defaultButton(
                                        text:
                                            '${getLang(context, "deleteGrope")}',
                                        color: redColor,
                                        height: 60.0,
                                        onPressedFunction: () {
                                          deleteMessageDialog(
                                            context,
                                            function: () {
                                              AppCubit.get(context)
                                                  .deleteGroupe(
                                                context,
                                                id: data.id!,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              drawer: DrawerComponent(),
            );
          }
        }
      },
    );
  }

  item(context, {nameFixed, nameDynamic}) => Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120.0,
              child: Text(
                nameFixed,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: defaultColor,
                    ),
              ),
            ),
            Flexible(
              child: Text(
                nameDynamic ?? '----',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
