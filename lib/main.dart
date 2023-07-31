import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quran_automated/view/manage_account/home_screen.dart';
import 'package:quran_automated/view/user/login/login_screen.dart';
import 'package:quran_automated/view/user/splash_screen.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/controllers/cubit/app_cubit.dart';
import 'package:quran_automated/controllers/cubit/app_states.dart';
import 'package:quran_automated/controllers/network/end_point.dart';
import 'package:quran_automated/controllers/network/local/cache_helper.dart';
import 'controllers/network/remote/dio_helper.dart';
import 'view/style/style.dart';

void main() async {
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();

  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');
  position = CacheHelper.getData(key: 'position');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  Widget startWidget;

  if (onBoarding != null) {
    if (token != null) {
      startWidget = HomeScreen();
      printStatement('Widget is Home');
      printStatement(token);
    } else {
      startWidget = LoginScreen();
      printStatement('Widget is Login');
    }
  } else {
    startWidget = const SplashScreen();
    printStatement('Widget is OnBoarding');
  }
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp(this.startWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        ChangeNotifierProvider(create: (context) => ChangeLang()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Automated Quran Memorization System',
            theme: lightMode,
            home: startWidget,
            localizationsDelegates: const [
              AppLocale.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("ar", ""),
              Locale("en", ""),
            ],
            locale: const Locale("ar", ""),

            // /* Translation by phone language */
            localeResolutionCallback: (currentLang, supportLang) {
              //   if (currentLang != null) {
              //   for (Locale locale in supportLang) {
              //     if (locale.languageCode == currentLang.languageCode) {
              //       CacheHelper.sharedPreferences!
              //           .setString("lang", currentLang.languageCode);
              //       return currentLang;
              //     }
              //   }
              //   }

              CacheHelper.sharedPreferences!.setString("lang", lang!);

              return Locale(lang!, "");

              // return supportLang.first;
            },
          );
        },
      ),
    );
  }
}

class ChangeLang with ChangeNotifier {}
