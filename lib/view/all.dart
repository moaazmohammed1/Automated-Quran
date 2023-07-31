import 'package:flutter/material.dart';
import 'package:quran_automated/view/components/components.dart';
import 'admin/all_admin_screen.dart';
import 'student/memorization_screen.dart';
import 'user/login/login_screen.dart';
import 'user/on_boarding_screen.dart';
import 'user/splash_screen.dart';
import 'user/what_are_we_screen.dart';

// List<String> textItem = [
//   'SplashScreen',
// ];

// List<Widget> widgetItem = [
//   const SplashScreen(),
// ];

class AllPages extends StatelessWidget {
  const AllPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  signOut(context);
                },
                child: const Text('Sign Out'),
              ),
              TextButton(
                onPressed: () {
                  removeOnBoarding(context);
                },
                child: const Text('On Boarding'),
              ),
              TextButton(
                onPressed: () {
                  navigateTo(context, const SplashScreen());
                },
                child: const Text('SplashScreen'),
              ),
              TextButton(
                onPressed: () {
                  navigateTo(context, const OnBoardingScreen());
                },
                child: const Text('OnBoardingScreen'),
              ),
              TextButton(
                onPressed: () {
                  navigateTo(context, LoginScreen());
                },
                child: const Text('LoginScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, LoginScreen());
                },
                child: const Text('.........................'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, AddAdminScreen());
                },
                child: const Text('Add Manager'),
              ),
              TextButton(
                onPressed: () {
                  navigateTo(context, FollowAllAdminScreen());
                },
                child: const Text('Admins'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, UpdateAdminScreen());
                },
                child: const Text('Update Manager  '),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, AttendanceScreen());
                },
                child: const Text('AttendanceScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, const MyQuranScreen());
                },
                child: const Text('MyQuranScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, RegisterSaveAndReviewScreen());
                },
                child: const Text('RegisterSaveAndReviewScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, StudentProfileScreen());
                },
                child: const Text('StudentProfileScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, KeeperProfileScreen());
                },
                child: const Text('TeacherProfileScreen'),
              ),
              TextButton(
                onPressed: () {
                  navigateTo(context, const WhatAreWeScreen());
                },
                child: const Text('WhatAreWeScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, const AddBranchScreen());
                },
                child: const Text('AddBranchScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context,   RegistrationScreen());
                },
                child: const Text('RegistrationScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, FollowScreen());
                },
                child: const Text('FollowScreen'),
              ),
              TextButton(
                onPressed: () {
                  navigateTo(context, SaveAndReviewScreen());
                },
                child: const Text('SaveAndReviewScreen'),
              ),
              TextButton(
                onPressed: () {
                  // navigateTo(context, const UserListScreen());
                },
                child: const Text('UserListScreen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
