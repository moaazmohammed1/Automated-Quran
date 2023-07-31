import 'package:flutter/material.dart';
import 'package:quran_automated/view/user/login/login_screen.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/controllers/network/local/cache_helper.dart';
import '../style/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  String? image;
  String? title;
  String? body;

  OnBoardingModel({this.image, this.title, this.body});
}

String _image = 'assets/images/image.jpg';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  bool isLast = false;

  skipOnBoarding() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndRemove(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<OnBoardingModel> boarding = [
      OnBoardingModel(
        image: _image,
        title: '${getLang(context, "title1")}',
        body: '${getLang(context, "body1")}',
      ),
      OnBoardingModel(
        image: _image,
        title: '${getLang(context, "title2")}',
        body: '${getLang(context, "body2")}',
      ),
      OnBoardingModel(
        image: _image,
        title: '${getLang(context, "title3")}',
        body: '${getLang(context, "body3")}',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: defaultTextButton(
                context,
                function: skipOnBoarding,
                text: '${getLang(context, "skip")}',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) =>
                    buildOnBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            const SizedBox(height: 110.0),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(right: 5.0, left: 40.0),
        child: Row(
          children: [
            SmoothPageIndicator(
              controller: pageController,
              textDirection: TextDirection.ltr,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 12,
                dotColor: Colors.grey,
                activeDotColor: defaultColor,
                spacing: 4,
                expansionFactor: 3,
              ),
              count: boarding.length,
            ),
            const Spacer(),
            FloatingActionButton(
              onPressed: () {
                if (isLast) {
                  skipOnBoarding();
                } else {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 750),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              child: const Icon(Icons.arrow_forward_ios_outlined),
            ),
          ],
        ),
      ),
    );
  }

  buildOnBoardingItem(OnBoardingModel boardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150.0),
                  image: DecorationImage(
                    image: AssetImage(boardingModel.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Text(
            boardingModel.title!,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 20.0),
          Text(
            boardingModel.body!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
