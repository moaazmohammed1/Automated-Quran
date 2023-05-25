import 'package:flutter/material.dart';
import 'package:quran_automated/modules/branch/add_branch_screen.dart';
import 'package:quran_automated/modules/center/add_center_screen.dart';
import 'package:quran_automated/modules/groupe/add_groupe_screen.dart';
import 'package:quran_automated/shared/components/components.dart';
import 'package:quran_automated/shared/style/style.dart';
import '../../shared/network/end_point.dart';
import 'add_new_user_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Registration Screen',
        centerTitle: true,
      ),
      body: Container(
        height: 600.0,
        margin: const EdgeInsets.all(30.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: defaultColor, width: 1.5),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //
                if (position == 'admin' || position == 'manager')
                  textButtonApp(
                    text: 'Admin',
                    function: () {
                      navigateTo(
                        context,
                        AddUserScreen(type: 'admin'),
                      );
                    },
                  ),

                //
                if (position == 'admin' || position == 'manager'
                // ||
                // position == 'supervisor'
                )
                  textButtonApp(
                    text: 'DS',
                    function: () {
                      navigateTo(
                        context,
                        AddUserScreen(type: 'supervisor'),
                      );
                    },
                  ),

                //
                if (position == 'admin' ||
                    position == 'manager' ||
                    position == 'supervisor'
                // ||
                // position == 'keeper'
                )
                  textButtonApp(
                    text: 'Keeper',
                    function: () {
                      navigateTo(
                        context,
                        AddUserScreen(type: 'keeper'),
                      );
                    },
                  ),

                //
                if (position == 'admin' ||
                    position == 'manager' ||
                    position == 'supervisor' ||
                    position == 'keeper')
                  textButtonApp(
                    text: 'Student',
                    function: () {
                      navigateTo(
                        context,
                        AddUserScreen(type: 'student'),
                      );
                    },
                  ),

                //
                if (position == 'admin' || position == 'manager')
                  textButtonApp(
                    text: 'Branch',
                    function: () {
                      navigateTo(
                        context,
                        AddBranchScreen(),
                      );
                    },
                  ),

                //
                // if (position == 'admin' || position == 'manager')
                // textButtonApp(
                //   text: 'GCS',
                //   function: () {},
                // ),

                //
                if (position == 'admin' ||
                    position == 'manager' ||
                    position == 'supervisor')
                  textButtonApp(
                    text: 'Center',
                    function: () {
                      navigateTo(
                        context,
                        const AddCenterScreen(),
                      );
                    },
                  ),

                //
                //
                if (position == 'admin' ||
                    position == 'manager' ||
                    position == 'supervisor')
                  textButtonApp(
                    text: 'Groupe',
                    function: () {
                      navigateTo(
                        context,
                        AddGroupeScreen(),
                      );
                    },
                  ),
                // if (position == 'admin' ||
                //     position == 'manager' ||
                //     position == 'supervisor' ||
                //     position == 'keeper')
                //   textButtonApp(
                //     text: 'Add Student in Groupe',
                //     function: () {
                //       navigateTo(
                //         context,
                //         AddStudentInGroupeScreen(),
                //       );
                //     },
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

textButtonApp({text, function}) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        border: Border.all(color: defaultColor, width: 1.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Center(
          child: TextButton(
        onPressed: function,
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      )),
    );
