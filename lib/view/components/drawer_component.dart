import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/controllers/network/end_point.dart';
import '../style/style.dart';
import '../../controllers/cubit/app_cubit.dart';
import '../../controllers/cubit/app_states.dart';

class DrawerComponent extends StatelessWidget {
  DrawerComponent({super.key});
  double? radius150;
  double? radius0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (lang == 'en') {
          radius150 = 150.0;
          radius0 = 0.0;
        } else {
          radius150 = 0.0;
          radius0 = 150.0;
        }

        return ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(radius0!),
            topLeft: Radius.circular(radius0!),
            bottomRight: Radius.circular(radius150!),
            topRight: Radius.circular(radius150!),
          ),
          child: SizedBox(
            width: 250,
            child: Drawer(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(100.0),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/image.jpg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    Text('${getLang(context, "loginTitle")}'),
                    const SizedBox(height: 80.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .changeLanguage(language: 'ar');
                          },
                          child: SizedBox(
                            width: 140.0,
                            child: Text(
                              '${getLang(context, "arabicLanguage")}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                        if (lang == 'ar') const Icon(Icons.check),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            AppCubit.get(context)
                                .changeLanguage(language: 'en');
                          },
                          child: SizedBox(
                            width: 140.0,
                            child: Text(
                              '${getLang(context, "englishLanguage")}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                        if (lang == 'en') const Icon(Icons.check),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    const Divider(
                      color: Colors.black38,
                    ),
                    TextButton(
                      onPressed: () {
                        signOut(context);
                      },
                      child: Text(
                        '${getLang(context, "logout")}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: redColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
