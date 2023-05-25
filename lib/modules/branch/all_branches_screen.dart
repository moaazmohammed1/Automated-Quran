import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../models/all_branches_model.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';
import '../user/follow_links_screen.dart';
import 'branch_profile_screen.dart';

class FollowAllBranchesScreen extends StatelessWidget {
  FollowAllBranchesScreen({super.key});
  AllBranchesModel? allBranchesModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).allBranchesModel == null) {
          AppCubit.get(context).getAllBranchesData();
          return Scaffold(
            appBar: AppBar(
              title: const Text('All Branch\'es'),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          allBranchesModel = AppCubit.get(context).allBranchesModel;
          if (allBranchesModel!.branches!.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('All Branch\'es'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      navigateTo(context, const FollowScreen());
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (allBranchesModel!.branches![index].deletedAt == null) {
                      return builderWidget(
                          allBranchesModel!.branches![index], context);
                    } else {
                      return Container();
                    }
                  },
                  separatorBuilder: (context, index) => Container(),
                  itemCount: allBranchesModel!.branches!.length,
                ),
              ),
              drawer: defaultDrawer(context),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('All Admin\'s'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person_off_sharp,
                      color: Colors.grey,
                      size: 150.0,
                    ),
                    SizedBox(height: 50.0),
                    Text(
                      'Branches Not Found',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              drawer: defaultDrawer(context),
            );
          }
        }
      },
    );
  }

  Widget builderWidget(BranchData model, context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                model.name!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    iconSize: 25.0,
                    onPressed: () {
                      navigateTo(
                        context,
                        BranchProfileScreen(
                          data: model,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.person,
                      color: defaultColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
