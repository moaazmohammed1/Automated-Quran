import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quran_automated/view/user/on_boarding_screen.dart';
import 'package:quran_automated/view/components/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  String image = 'assets/images/image.jpg';

  _startDelay() {
    _timer = Timer(const Duration(seconds: 5), _goNext);
  }

  _goNext() {
    navigateAndRemove(context, const OnBoardingScreen());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F3F0),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150.0),
                // border: Border.all(),
                image: DecorationImage(
                  image: AssetImage(image),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            // Text(
            //   'أهل القرءان هم أهل الله وخاصته',
            //   // 'خيركم من تعلم القرءان وعلمه',
            //   style: TextStyle(
            //     fontSize: 20.0,
            //     color: Colors.blue[900],
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            // Text(
            //   'دار القرءان الكريم',
            //   style: Theme.of(context).textTheme.subtitle1,
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
