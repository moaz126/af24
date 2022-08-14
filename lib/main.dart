import 'package:af24/Screens/dashBoard.dart';
import 'package:af24/Screens/login.dart';
import 'package:af24/Screens/navBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        theme: ThemeData(
          fontFamily: "Myriad",
        ),
        debugShowCheckedModeBanner: false,
        home: Login(),
      );
    });
  }
}
