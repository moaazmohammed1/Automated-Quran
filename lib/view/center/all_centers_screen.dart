import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/all_centers_model.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/view/components/drawer_component.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';
import '../user/follow_links_screen.dart';
import 'center_profile_screen.dart';

class FollowAllCentersScreen extends StatelessWidget {
  FollowAllCentersScreen({super.key});
  AllCenterModel? allCentersModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).allCentersModel == null) {
          AppCubit.get(context).getAllCentersData();
          return Scaffold(
            appBar: AppBar(
              title: Text('${getLang(context, "allCenters")}'),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          allCentersModel = AppCubit.get(context).allCentersModel;
          if (allCentersModel!.centers!.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: Text('${getLang(context, "allCenters")}'),
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
                    if (allCentersModel!.centers![index].deletedAt == null) {
                      return builderWidget(
                          allCentersModel!.centers![index], context);
                    } else {
                      return Container();
                    }
                  },
                  separatorBuilder: (context, index) => Container(),
                  itemCount: allCentersModel!.centers!.length,
                ),
              ),
              drawer: DrawerComponent(),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('${getLang(context, "allCenters")}'),
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
                  children: [
                    const Icon(
                      Icons.person_off_sharp,
                      color: Colors.grey,
                      size: 150.0,
                    ),
                    const SizedBox(height: 50.0),
                    Text(
                      '${getLang(context, "centersNotFound")}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              drawer: DrawerComponent(),
            );
          }
        }
      },
    );
  }

  Widget builderWidget(CenterData model, context) {
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
                        CenterProfileScreen(
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
