import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../models/all_supervisor_model.dart';
import '../../models/data_model.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';
import '../user/follow_links_screen.dart';
import 'ds_profile_screen.dart';

class FollowAllDSScreen extends StatelessWidget {
  FollowAllDSScreen({super.key});
  SupervisorModel? allDirectSupervisorModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).allDirectSupervisorModel == null) {
          AppCubit.get(context).getAllDirectSupervisorData();
          return Scaffold(
            appBar: AppBar(
              title: const Text('All Direct Supervisor\'s'),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          allDirectSupervisorModel =
              AppCubit.get(context).allDirectSupervisorModel;
          if (allDirectSupervisorModel!.supervisors!.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('All Direct Supervisor\'s'),
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
                    if (allDirectSupervisorModel!
                            .supervisors![index].deletedAt ==
                        null) {
                      return builderWidget(
                          allDirectSupervisorModel!.supervisors![index],
                          context);
                    } else {
                      return Container();
                    }
                  },
                  separatorBuilder: (context, index) => Container(),
                  itemCount: allDirectSupervisorModel!.supervisors!.length,
                ),
              ),
              drawer: defaultDrawer(context),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('All Direct Supervisor\'s'),
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
                      'Direct Supervisor\'s Not Found',
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

  Widget builderWidget(Data model, context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${model.fName!} ${model.sName ?? ''} ${model.tName ?? ''} ${model.lName!}',
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
                        DSProfileScreen(
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
