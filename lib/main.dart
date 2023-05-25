import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_automated/modules/manage_account/home_screen.dart';
import 'package:quran_automated/modules/user/login/login_screen.dart';
import 'package:quran_automated/modules/user/splash_screen.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/cubit/app_cubit.dart';
import 'package:quran_automated/shared/cubit/app_states.dart';
import 'package:quran_automated/shared/network/end_point.dart';
import 'package:quran_automated/shared/network/local/cache_helper.dart';
import 'package:quran_automated/shared/style/style.dart';
import 'shared/network/remote/dio_helper.dart';

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
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Automated Quran Memorization System',
            theme: lightMode,
            // home: Demo(),
            // home: AllPages(),
            // home: TestScreen(),
            home: startWidget,
          );
        },
      ),
    );
  }
}
