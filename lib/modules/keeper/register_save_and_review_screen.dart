import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../models/data_model.dart';

import '../../shared/cubit/app_cubit.dart';
import '../../shared/cubit/app_states.dart';

class RegisterSaveAndReviewScreen extends StatelessWidget {
  RegisterSaveAndReviewScreen({required this.data, super.key});
  Data data;
  int juzNumbers = 30;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Register New Save'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              )
            ],
          ),
          drawer: defaultDrawer(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 35.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student Name:',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                        ),
                        Text(
                          '${data.fName!} ${data.sName ?? ''} ${data.tName ?? ''} ${data.lName!}',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    width: double.infinity,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: greyColor,
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
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                for (int i = 1;
                                                    i <= juzNumbers;
                                                    i++)
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        value: '$i',
                                                        groupValue:
                                                            '${AppCubit.get(context).selectedJuz}',
                                                        onChanged: (val) {
                                                          AppCubit.get(context)
                                                              .selectedAlJuz(
                                                                  juz: '$i');
                                                        },
                                                      ),
                                                      Text(
                                                        '$i',
                                                        style: const TextStyle(
                                                            fontSize: 20.0),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        defaultButton(
                                          text: 'select',
                                          onPressedFunction: () {
                                            AppCubit.get(context)
                                                .getSpecificJuzInformation(
                                                    id: int.parse(
                                                        AppCubit.get(context)
                                                            .selectedJuz!));
                                            // print(int.parse(
                                            //     AppCubit.get(context)
                                            //         .selectedAyah!));
                                          },
                                          height: 60.0,
                                          fontSizeText: 18.0,
                                        ),
                                      ],
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
                            AppCubit.get(context).selectedJuz != ''
                                ? 'Juz : ${AppCubit.get(context).selectedJuz ?? '--'}'
                                : 'Al-Juz',
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
                  const SizedBox(height: 20.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    width: double.infinity,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: greyColor,
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
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  AppCubit.get(context)
                                                      .mapSuras
                                                      .length;
                                              i++)
                                            Row(
                                              children: [
                                                Radio(
                                                  value: AppCubit.get(context)
                                                      .mapSuras
                                                      .keys
                                                      .elementAt(i),
                                                  groupValue:
                                                      '${AppCubit.get(context).selectedSura}',
                                                  onChanged: (val) {
                                                    AppCubit.get(context)
                                                        .selectedSuras(
                                                      sura:
                                                          AppCubit.get(context)
                                                              .mapSuras
                                                              .keys
                                                              .elementAt(i),
                                                      no: AppCubit.get(context)
                                                          .sura[i],
                                                    );
                                                  },
                                                ),
                                                Text(
                                                  AppCubit.get(context)
                                                      .mapSuras
                                                      .keys
                                                      .elementAt(i),
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
                            AppCubit.get(context).selectedSura != ''
                                ? 'Surah : ${AppCubit.get(context).selectedSura ?? '--'}'
                                : 'Al-Surah',
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          width: double.infinity,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: greyColor,
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
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                for (int i = 1;
                                                    i <=
                                                        int.parse(
                                                            '${AppCubit.get(context).mapSuras[AppCubit.get(context).selectedSura]}');
                                                    i++)
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        value: i,
                                                        groupValue: AppCubit
                                                                .get(context)
                                                            .selectedFromAyah,
                                                        onChanged: (val) {
                                                          AppCubit.get(context)
                                                              .selectedFromAyahs(
                                                            ayah: i,
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        '$i',
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
                                  AppCubit.get(context)
                                              .selectedFromAyah
                                              .toString() !=
                                          ''
                                      ? 'From Aya : ${AppCubit.get(context).selectedFromAyah ?? '--'}'
                                      : 'Al-Aya',
                                  style: const TextStyle(
                                    fontSize: 17.0,
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
                      ),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          width: double.infinity,
                          height: 60.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: greyColor,
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
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                for (int i = 1;
                                                    i <=
                                                        int.parse(
                                                            '${AppCubit.get(context).mapSuras[AppCubit.get(context).selectedSura]}');
                                                    i++)
                                                  Row(
                                                    children: [
                                                      Radio(
                                                        value: i,
                                                        groupValue:
                                                            AppCubit.get(
                                                                    context)
                                                                .selectedToAyah,
                                                        onChanged: (val) {
                                                          AppCubit.get(context)
                                                              .selectedToAyahs(
                                                            ayah: i,
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        '$i',
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
                                  AppCubit.get(context)
                                              .selectedToAyah
                                              .toString() !=
                                          ''
                                      ? 'To Aya : ${AppCubit.get(context).selectedToAyah ?? '--'}'
                                      : 'Al-Aya',
                                  style: const TextStyle(
                                    fontSize: 17.0,
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  defaultButton(
                      text: 'save',
                      onPressedFunction: () {
                        AppCubit.get(context).registerNewKeep(
                          context,
                          id: data.id!,
                          fromJuz:
                              int.parse(AppCubit.get(context).selectedJuz!),
                          fromSurah: int.parse(AppCubit.get(context).suraNo!),
                          fromAyah: AppCubit.get(context).selectedFromAyah!,
                          toAyah: AppCubit.get(context).selectedToAyah!,
                          faultsNumber: 2,
                        );
                      },
                      height: 60.0,
                      fontSizeText: 19.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
