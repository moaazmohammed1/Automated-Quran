import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../models/all_branches_model.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';
import 'update_branch_data_screen.dart';

class BranchProfileScreen extends StatelessWidget {
  BranchProfileScreen({required this.data, super.key});
  BranchData data;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Branch profile'),
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
                          'User Data.',
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
                              nameFixed: 'Name: ',
                              nameDynamic: '${data.name}',
                            ),
                            item(
                              context,
                              nameFixed: 'Status: ',
                              nameDynamic: data.status,
                            ),
                            item(
                              context,
                              nameFixed: 'Local Region: ',
                              nameDynamic: data.localRegion ?? '',
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
                                    text: 'Update data',
                                    height: 60.0,
                                    onPressedFunction: () {
                                      navigateTo(
                                        context,
                                        UpdateBranchScreen(
                                          data: data,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15.0),
                                Expanded(
                                  child: defaultButton(
                                    text: 'Delete Groupe',
                                    color: redColor,
                                    height: 60.0,
                                    onPressedFunction: () {
                                      deleteMessageDialog(
                                        context,
                                        function: () {
                                          AppCubit.get(context).deleteBranch(
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
          drawer: defaultDrawer(context),
        );
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