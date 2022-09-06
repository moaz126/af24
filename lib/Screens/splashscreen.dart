import 'package:af24/Screens/dashBoard.dart';
import 'package:af24/Screens/login.dart';
import 'package:af24/Screens/navBar.dart';
import 'package:af24/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/auth_af24.dart';
import '../api/global_variable.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getState() async {
    var isLogin = await getUserLoggedIn();
    if (isLogin) {
      String? token = await getUserDataToken();
      CUSTOMER_TOKEN.value = token!;
      bool checkSession = await DataApiService.instance.getDashboard();
      if (checkSession) {
        DataApiService.instance.getShippingCost();
        DataApiService.instance.getCategoryList();
        DataApiService.instance.getBrand();
        DataApiService.instance.getshopinfo();
        DataApiService.instance.getcolorlist();
        DataApiService.instance.getsizelist();
        DataApiService.instance.getSellerOrderList();
        Get.offAll(() => navBar(index: 0, see: 1));
      } else {
        setUserLoggedIn(false);
        GlobalSnackBar(message: 'Session expired');
        Get.offAll(() => Login());
      }
    } else {
      Get.offAll(() => Login());
    }
  }

  @override
  void initState() {
    getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset('assets/Seller app icon (11).png'),
        ),
      ),
    );
  }
}
