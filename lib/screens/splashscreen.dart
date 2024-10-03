import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:weatherapp/main.dart';

import 'homescreen.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});

  @override 
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () => Get.offAll(() => HoimeScreen()));
    return Scaffold(
      body: Center(
        child: Column(children: [Spacer(),Image.asset("assets/meteorology.png",width:Get.width*0.5,),
        const Text("Designed by Shourya Pandey"),Spacer()],),
      ),
    );
  }
}
