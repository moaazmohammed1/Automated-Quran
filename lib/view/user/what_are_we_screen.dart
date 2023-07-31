import 'package:flutter/material.dart';
import 'package:quran_automated/view/components/components.dart';
import 'package:quran_automated/view/components/drawer_component.dart';

class WhatAreWeScreen extends StatelessWidget {
  const WhatAreWeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('We Are ?'),
        centerTitle: true,
        leading: drawerIcon(context),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_forward),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: defaultButton(
                text: 'back',
                onPressedFunction: () {
                  Navigator.pop(context);
                }),
          )
        ],
      ),
      drawer:   DrawerComponent(),
    );
  }
}
