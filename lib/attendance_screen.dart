// import 'package:flutter/material.dart';

// class AttendanceScreen extends StatelessWidget {
//   const AttendanceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.only(top: 40.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 item(
//                   context,
//                   text: 'حضور',
//                   date: 'السبت 25-9-2000',
//                 ),
//                 const SizedBox(width: 10.0),
//                 item(
//                   context,
//                   text: 'حضور',
//                   date: 'السبت 25-9-2000',
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 item(
//                   context,
//                   text: 'حضور',
//                   date: 'السبت 25-9-2000',
//                 ),
//                 const SizedBox(width: 10.0),
//                 item(
//                   context,
//                   text: 'غياب',
//                   date: 'السبت 25-9-2000',
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 item(
//                   context,
//                   text: 'غياب',
//                   date: 'السبت 25-9-2000',
//                 ),
//                 const SizedBox(width: 10.0),
//                 item(
//                   context,
//                   text: 'حضور',
//                   date: 'السبت 25-9-2000',
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30.0),
//             // Container(
//             //   margin: const EdgeInsets.symmetric(horizontal: 10.0),
//             //   child: Row(
//             //     children: [
//             //         Expanded(
//             //         child: StudentProfileScreen(),
//             //       ),
//             //       const SizedBox(width: 5.0),
//             //       Expanded(
//             //         child: KeeperProfileScreen(),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   item(context, {required text, required date}) => Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
//         width: 190.0,
//         height: 205.0,
//         decoration: BoxDecoration(
//           border: Border.all(),
//           borderRadius: BorderRadius.circular(50.0),
//         ),
//         child: Column(
//           children: [
//             textItem(
//               context,
//               text: date,
//             ),
//             const Divider(color: Colors.black),
//             Expanded(
//               child: Center(
//                 child: Container(
//                   width: 120.0,
//                   height: 50.0,
//                   decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.circular(50.0),
//                   ),
//                   child: Center(
//                     child: Text(
//                       text,
//                       style: Theme.of(context).textTheme.subtitle2,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10.0),
//           ],
//         ),
//       );

//   textItem(context, {text}) => Container(
//         padding: const EdgeInsets.only(left: 5.0),
//         child: Text(
//           text,
//           style: Theme.of(context)
//               .textTheme
//               .bodyText1!
//               .copyWith(color: Colors.black),
//         ),
//       );
// }

/*********************************************** */
/*********************************************** */
/*********************************************** */
/*********************************************** */
/*********************************************** */
/*********************************************** */
/*********************************************** */

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // Define the Cubit state to manage the checkbox values
// class CheckBoxCubit extends Cubit<List<bool>> {
//   CheckBoxCubit(List<bool> initialState) : super(initialState);

//   void toggleCheckBox(int index) {
//     state[index] = !state[index];
//     emit(List.from(state));
//   }
// }

// class StoreStudentAbsenceScreen extends StatelessWidget {
//   final List<String> items;
//   StoreStudentAbsenceScreen({required this.items});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = CheckBoxCubit(List.filled(items.length, false));
//     return BlocProvider.value(
//       value: cubit,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Checkbox List Example'),
//         ),
//         body: ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (BuildContext context, int index) {
//             return CheckboxListTile(
//               title: Text(items[index]),
//               value: context.select((CheckBoxCubit cubit) => cubit.state[index]),
//               onChanged: (bool? value) {
//                 cubit.toggleCheckBox(index);
//               },
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Generate the list from the Cubit state
//             List<String> selectedItems = [];
//             for (int i = 0; i < items.length; i++) {
//               if (cubit.state[i]) {
//                 selectedItems.add(items[i]);
//               }
//             }
//             // Send the list to the API
//             // ...
//           },
//           child: Icon(Icons.check),
//         ),
//       ),
//     );
//   }
// }
