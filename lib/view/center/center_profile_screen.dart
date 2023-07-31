import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';
import '../../models/all_centers_model.dart';
import '../../models/get_one_branch_model.dart';
import '../components/drawer_component.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';
import 'update_center_data_screen.dart';

class CenterProfileScreen extends StatelessWidget {
  CenterProfileScreen({required this.data, super.key});
  CenterData data;
  GetOneBranchModel? getOneBranchModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).getOneBranchModel == null ||
            AppCubit.get(context).getOneBranchModel!.branch!.id !=
                data.branchId) {
          AppCubit.get(context).getBranchData(id: data.branchId!);
          return Scaffold(body: Container());
        } else {
          getOneBranchModel = AppCubit.get(context).getOneBranchModel;
          return Scaffold(
            appBar: AppBar(
              title: Text('${getLang(context, "centerProfile")}'),
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
                            '${getLang(context, "userData")} ',
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
                                nameFixed:
                                    '${getLang(context, "centerName")}: ',
                                nameDynamic: '${data.name}',
                              ),
                              item(
                                context,
                                nameFixed:
                                    '${getLang(context, "centerStatus")}: ',
                                nameDynamic: data.status,
                              ),
                              item(
                                context,
                                nameFixed:
                                    '${getLang(context, "localRegion")}: ',
                                nameDynamic: data.localRegion ?? '',
                              ),
                              item(
                                context,
                                nameFixed: '${getLang(context, "branch")}: ',
                                nameDynamic:
                                    getOneBranchModel!.branch!.name ?? '',
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
                                          '${getLang(context, "updateCenterPage")}',
                                      height: 60.0,
                                      onPressedFunction: () {
                                        navigateTo(
                                          context,
                                          UpdateCenterScreen(
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
                                          '${getLang(context, "deleteCenter")}',
                                      color: redColor,
                                      height: 60.0,
                                      onPressedFunction: () {
                                        deleteMessageDialog(
                                          context,
                                          function: () {
                                            AppCubit.get(context).deleteCenter(
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
