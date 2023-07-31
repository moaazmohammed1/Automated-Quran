// import 'package:flutter/material.dart';
// import 'package:quran_automated/shared/components/components.dart';

// class UserListScreen extends StatelessWidget {
//   const UserListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: defaultAppBar(
//         context: context,
//         title: 'GCS, DS, keeper',
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           keeperList(),
//           keeperList(),
//           keeperList(),
//           keeperList(),
//         ],
//       ),
//       bottomNavigationBar: Container(
//           margin: const EdgeInsets.all(20.0),
//           child: const Text('keeper number : 10')),
//     );
//   }
// }

// keeperList() => Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//       margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//       decoration: BoxDecoration(
//         border: Border.all(),
//         borderRadius: BorderRadius.circular(40.0),
//       ),
//       child: Row(
//         children: [
//           const Text('Moaaz Abu Zarifa'),
//           const SizedBox(
//             height: 40.0,
//             child: VerticalDivider(
//               thickness: 2,
//               color: Colors.black45,
//             ),
//           ),
//           Expanded(
//             child: defaultButton(
//               text: 'profile',
//               onPressedFunction: () {},
//             ),
//           ),
//           const SizedBox(width: 5.0),
//           Expanded(
//             child: defaultButton(
//               text: 'follow',
//               onPressedFunction: () {},
//             ),
//           ),
//         ],
//       ),
//     );
