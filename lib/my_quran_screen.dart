// import 'package:flutter/material.dart';
// import 'package:quran_automated/modules/student/memorization_screen.dart';
// import 'package:quran_automated/shared/components/components.dart';
// import 'package:quran_automated/shared/style/style.dart';

// class MyQuranScreen extends StatefulWidget {
//   const MyQuranScreen({super.key});

//   @override
//   State<MyQuranScreen> createState() => _MyQuranScreenState();
// }

// class _MyQuranScreenState extends State<MyQuranScreen> {
//   int pageIndex = 0;
//   double paddingVer = 40.0;
//   double paddingHor = 10.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('قرءاني'),
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
//           Container(
//             width: double.infinity,
//             height: 150.0,
//             // color: Colors.grey[200],
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/cover.jpg'),
//               ),
//             ),
//           ),
//           IntrinsicHeight(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                       child: Text(
//                         'الطلاب',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.subtitle2,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           pageIndex = 0;
//                           print(pageIndex);
//                         });
//                       },
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(top: 7.0),
//                     child: VerticalDivider(
//                       thickness: 0.5,
//                       color: Colors.black,
//                     ),
//                   ),
//                   Expanded(
//                     child: TextButton(
//                       child: Text(
//                         'آخر أية لكل طالب',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.subtitle2,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           pageIndex = 1;
//                           print(pageIndex);
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Stack(
//             children: [
//               const Divider(
//                 thickness: 0.14,
//                 height: 0.5,
//                 color: Colors.black,
//               ),
//               if (pageIndex == 0)
//                 const SizedBox(
//                   width: 205,
//                   child: Divider(
//                     color: defaultColor,
//                     thickness: 3,
//                     height: 1,
//                   ),
//                 ),
//               if (pageIndex == 1)
//                 Container(
//                   margin: const EdgeInsets.only(right: 205),
//                   child: const Divider(
//                     color: defaultColor,
//                     thickness: 3,
//                     height: 1,
//                   ),
//                 ),
//             ],
//           ),
//           if (pageIndex == 0) Expanded(child: student(context)),
//           if (pageIndex == 1) Expanded(child: studentLastAya(context)),
//         ],
//       ),
//       drawer: defaultDrawer(context),
//       floatingActionButton: Container(
//         padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
//         color: Colors.white,
//         width: double.infinity,
//         child: const Text('عدد الطلبة : 10'),
//       ),
//     );
//   }

//   student(context) => Container(
//         width: double.infinity,
//         padding:
//             EdgeInsets.symmetric(vertical: paddingVer, horizontal: paddingHor),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               studentItem(),
//               studentItem(),
//               studentItem(),
//               studentItem(),
//               studentItem(),
//             ],
//           ),
//         ),
//       );

//   studentItem() => Row(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 // navigateAndRemove(context,   StudentProfileScreen());
//               },
//               child: item(context, text: 'معاذ أبو ظريفة'),
//             ),
//           ),
//           const SizedBox(width: 10.0),
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 // navigateAndRemove(context,   StudentProfileScreen());
//               },
//               child: item(context, text: 'عبدالعزيز النجار'),
//             ),
//           ),
//         ],
//       );

//   studentLastAya(context) => Container(
//         padding:
//             EdgeInsets.symmetric(vertical: paddingVer, horizontal: paddingHor),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               lastAya(),
//               lastAya(),
//               lastAya(),
//             ],
//           ),
//         ),
//       );

//   lastAya() => Row(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 navigateAndRemove(context, SaveAndReviewScreen());
//               },
//               child: itemLastAya(
//                 context,
//                 text: 'معاذ أبو ظريفة',
//                 suraAndAya: 'سورة الملك : آية 20',
//               ),
//             ),
//           ),
//           const SizedBox(width: 10.0),
//           Expanded(
//             child: InkWell(
//               onTap: () {
//                 navigateAndRemove(context, SaveAndReviewScreen());
//               },
//               child: itemLastAya(
//                 context,
//                 text: 'عبدالعزيز النجار',
//                 suraAndAya: 'سورة الملك : آية 20',
//               ),
//             ),
//           ),
//         ],
//       );

//   item(context, {required text}) => Container(
//         margin: const EdgeInsets.only(bottom: 20.0),
//         padding: const EdgeInsets.symmetric(vertical: 10.0),
//         decoration: BoxDecoration(
//           border: Border.all(),
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: Theme.of(context).textTheme.subtitle2,
//           ),
//         ),
//       );

//   itemLastAya(context, {required text, required suraAndAya}) => Container(
//         margin: const EdgeInsets.only(bottom: 20.0),
//         padding: const EdgeInsets.symmetric(vertical: 6.0),
//         decoration: BoxDecoration(
//           border: Border.all(),
//           borderRadius: BorderRadius.circular(40.0),
//         ),
//         child: Column(
//           children: [
//             Center(
//               child: Text(
//                 text,
//                 style: Theme.of(context).textTheme.subtitle2,
//               ),
//             ),
//             const Divider(
//               thickness: 0.3,
//               color: Colors.black,
//             ),
//             Text(
//               suraAndAya,
//               style: Theme.of(context)
//                   .textTheme
//                   .subtitle2!
//                   .copyWith(fontSize: 16.0),
//             ),
//           ],
//         ),
//       );
// }
