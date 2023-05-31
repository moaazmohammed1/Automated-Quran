import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/models/get_mark_model.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

class MyTestMarkScreen extends StatelessWidget {
  MyTestMarkScreen({super.key});
  GetMyTestsModel? getMyTestsModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (AppCubit.get(context).getMyTestsModel == null) {
          AppCubit.get(context).getMyTest();
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Mark'),
              centerTitle: true,
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          );
        } else {
          getMyTestsModel = AppCubit.get(context).getMyTestsModel;
          if (getMyTestsModel!.tests!.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('My Mark'),
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
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return builderWidget(
                        getMyTestsModel!.tests![index], context);
                  },
                  separatorBuilder: (context, index) => Container(),
                  itemCount: getMyTestsModel!.tests!.length,
                ),
              ),
              drawer: defaultDrawer(context),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('My Mark'),
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
                      'Mark\'s Not Found',
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

  Widget builderWidget(TestDataModel model, context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Test Info. ',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                        fontSize: 18.0,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'From Juz ',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: defaultColor,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${model.from}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ' To Juz ',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: defaultColor,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${model.to}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Type Test: ',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold, color: defaultColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${model.type}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Test Mark: ',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold, color: defaultColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  ' ${model.mark}',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}