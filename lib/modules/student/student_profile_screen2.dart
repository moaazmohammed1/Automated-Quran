// import 'package:flutter/material.dart';
// import 'package:quran_automated/modules/student/save_and_review_screen.dart';
// import 'package:quran_automated/shared/components/components.dart';

// import '../user/attendance_screen.dart';

// class StudentProfileScreen extends StatelessWidget {
//   StudentProfileScreen({super.key});

//   double radius = 5.0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('student profile'),
//         centerTitle: true,
//         leading: drawerIcon(context),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_forward),
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Card(
//               margin: const EdgeInsets.only(
//                   top: 15.0, bottom: 20.0, right: 20.0, left: 20.0),
//               elevation: 50,
//               shadowColor: const Color(0xFFE4E4E4),
//               // color: const Color(0xFFF1F1F1),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(60.0),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(top: 10.0),
//                     width: 150.0,
//                     height: 150.0,
//                     decoration: BoxDecoration(
//                       color: const Color(0x73C4C4C4),
//                       borderRadius: BorderRadius.circular(100.0),
//                     ),
//                   ),
//                   const SizedBox(height: 30.0),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.only(right: 30.0),
//                     child: Text(
//                       'Student Data',
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText2!
//                           .copyWith(color: Colors.grey[500]),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 5.0, horizontal: 30.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Student Name:',
//                           style: Theme.of(context).textTheme.subtitle2,
//                         ),
//                         const SizedBox(height: 10.0),
//                         Text(
//                           'Student ID:',
//                           style: Theme.of(context).textTheme.subtitle2,
//                         ),
//                         const SizedBox(height: 10.0),
//                         Text(
//                           'Birth Day:',
//                           style: Theme.of(context).textTheme.subtitle2,
//                         ),
//                         const SizedBox(height: 10.0),
//                         Text(
//                           'Phone Number:',
//                           style: Theme.of(context).textTheme.subtitle2,
//                         ),
//                         const SizedBox(height: 35.0),
//                       ],
//                     ),
//                   ),
//                   const Spacer(),
//                   Container(
//                     margin: const EdgeInsets.only(
//                         right: 20.0, left: 20.0, bottom: 40.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: defaultButton(
//                                 text: 'memorization',
//                                 onPressedFunction: () {
//                                   navigateAndRemove(
//                                       context, SaveAndReviewScreen());
//                                 },
//                                 width: 120.0,
//                               ),
//                             ),
//                             const SizedBox(width: 15.0),
//                             Expanded(
//                               child: defaultButton(
//                                 text: 'attends',
//                                 onPressedFunction: () {
//                                   navigateAndRemove(
//                                       context, AttendanceScreen());
//                                 },
//                                 width: 120.0,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 15.0),
//                         defaultButton(
//                           text: 'update profile',
//                           onPressedFunction: () {},
//                           color: Colors.transparent,
//                           colorText: Colors.black,
//                           border: Border.all(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       drawer: defaultDrawer(context),
//     );
//   }
// }
