import 'package:flutter/material.dart';
import 'package:quran_automated/view/branch/add_branch_screen.dart';
import 'package:quran_automated/view/center/add_center_screen.dart';
import 'package:quran_automated/view/groupe/add_groupe_screen.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/view/components/components.dart';
import '../style/style.dart';
import '../../controllers/network/end_point.dart';
import 'add_new_user_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: '${getLang(context, "registerPageButton")}',
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
                    text: '${getLang(context, "admins")}',
                    function: () {
                      navigateTo(
                        context,
                        AddUserScreen(type: 'admin'),
                      );
                    },
                  ),

                //
                if (position == 'admin' || position == 'manager')
                  textButtonApp(
                    text: '${getLang(context, "dss")}',
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
                    position == 'supervisor')
                  textButtonApp(
                    text: '${getLang(context, "keepers")}',
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
                    text: '${getLang(context, "students")}',
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
                    text: '${getLang(context, "branches")}',
                    function: () {
                      navigateTo(
                        context,
                        AddBranchScreen(),
                      );
                    },
                  ),

                //
                if (position == 'admin' ||
                    position == 'manager' ||
                    position == 'supervisor')
                  textButtonApp(
                    text: '${getLang(context, "centers")}',
                    function: () {
                      navigateTo(
                        context,
                        const AddCenterScreen(),
                      );
                    },
                  ),

                //
                if (position == 'admin' ||
                    position == 'manager' ||
                    position == 'supervisor')
                  textButtonApp(
                    text: '${getLang(context, "groups")}',
                    function: () {
                      navigateTo(
                        context,
                        AddGroupeScreen(),
                      );
                    },
                  ),
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
