import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quran_automated/view/user/login/login_screen.dart';
import 'package:quran_automated/view/user/splash_screen.dart';
import 'package:quran_automated/controllers/applocal.dart';
import 'package:quran_automated/controllers/network/end_point.dart';
import 'package:quran_automated/controllers/network/local/cache_helper.dart';
import '../style/style.dart';

defaultTextFormField({
  String? label,
  IconData? prefixIcon,
  image,
  Function()? onTap,
  Function(String)? onChange,
  Function(String)? onSubmitted,
  IconData? suffixIcon,
  TextInputType? keyboard,
  bool obscurePassword = false,
  bool isClickable = true,
  Function()? onPressedSuffix,
  TextEditingController? controller,
  FormFieldValidator<String>? validate,
  bool readOnly = false,
  Color? color,
  double fontLabel = 18.0,
  EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
}) =>
    TextFormField(
      readOnly: readOnly,
      cursorColor: defaultColor,
      controller: controller,
      keyboardType: keyboard,
      validator: validate,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      enabled: isClickable,
      obscureText: obscurePassword,
      style: TextStyle(fontSize: fontLabel, fontFamily: 'Tajawal'),
      scrollPadding: scrollPadding,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Noto Sans Arabic',
          fontSize: fontLabel = 18.0,
          color: color,
        ),
        hintText: label,
        hintStyle: TextStyle(
          fontFamily: 'Noto Sans Arabic',
          fontSize: fontLabel,
        ),
        helperStyle: TextStyle(
          fontFamily: 'Noto Sans Arabic',
          fontSize: fontLabel,
        ),
        errorStyle: TextStyle(
          fontFamily: 'Noto Sans Arabic',
          fontSize: fontLabel,
        ),
        suffixIcon: image != null
            ? Image.asset(image!)
            : (suffixIcon != null
                ? IconButton(onPressed: onPressedSuffix, icon: Icon(suffixIcon))
                : null),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor),
        ),
        floatingLabelStyle: const TextStyle(
          color: defaultColor,
        ),
      ),
    );

signOut(context) => CacheHelper.removeData(
      key: 'token',
    ).then(
      (value) {
        CacheHelper.removeData(
          key: 'position',
        );
        if (value) {
          navigateAndRemove(context, LoginScreen());
        }
      },
    );

removeOnBoarding(context) => CacheHelper.removeData(
      key: 'onBoarding',
    ).then(
      (value) {
        if (value) {
          CacheHelper.removeData(
            key: 'token',
          ).then(
            (value) {
              if (value) {
                navigateAndRemove(context, const SplashScreen());
              }
            },
          );
        }
      },
    );

drawerIcon(context) => IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () => Scaffold.of(context).openDrawer(),
    );

defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
  bool? centerTitle,
  Widget? leading,
}) =>
    AppBar(
      leading: leading,
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: defaultColor,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
    );

deleteMessageDialog(context, {required function}) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Text(
              '${getLang(context, "msgConfirmDelete")}',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: defaultButton(
                      text: '${getLang(context, "yes")}',
                      width: 70.0,
                      color: redColor,
                      onPressedFunction: function,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: defaultButton(
                      text: '${getLang(context, "no")}',
                      width: 70.0,
                      onPressedFunction: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

defaultButton({
  required String text,
  required Function()? onPressedFunction,
  double width = double.infinity,
  Color color = defaultColor,
  border,
  double height = 40,
  double fontSizeText = 15.0,
  Color colorText = Colors.white,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        border: border,
      ),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: onPressedFunction,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: fontSizeText,
            color: colorText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

defaultTextButton(context,
        {required Function() function, required String text}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndRemove(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

void showToast({required String msg, required ToastStates? state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(state) {
  late Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

// ignore: avoid_print
printStatement(text) => print(text);
