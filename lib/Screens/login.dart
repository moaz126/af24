import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/signUp.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loader = false;
  // callApi() async {
  //   setState(() {
  //     loader = true;
  //   });
  //   await DataApiService.instance.getlogintoken();
  //
  //   setState(() {
  //     loader = false;
  //   });
  //
  // }
  final spinkit = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.white,
  );
  @override
  void initState() {
    // TODO: implement initState
    StatusCode = '403';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 22.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/Seller app icon (11).png',
                    height: 6.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(3.h, 0, 0, 0),
              alignment: Alignment.topLeft,
              child: Text("Email"),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              width: 88.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(6)),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                },
                controller: emailcontroller,
                decoration: InputDecoration(
                    hintText: "Your email address",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(3.h, 1.h, 0, 0),
              alignment: Alignment.topLeft,
              child: Text("Password"),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              width: 88.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(6)),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                },
                controller: passcontroller,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      size: 20,
                    ),
                    hintText: "Your Password",
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 15)),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              //color: Colors.red,
              width: 88.w,
              height: 6.h,

              child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      StatusCode = '403';
                      setState(() {
                        loader = true;
                      });
                      Map<String, dynamic> loginToMap = {
                        "email": emailcontroller.text,
                        "password": passcontroller.text,
                      };
                      await DataApiService.instance
                          .getlogintoken(loginToMap, context);
                      DataApiService.instance.getCategoryList();
                      DataApiService.instance.getShippingCost();
                      DataApiService.instance.getBrand();
                      DataApiService.instance.getshopinfo();
                      DataApiService.instance.getcolorlist();
                      DataApiService.instance.getsizelist();
                      DataApiService.instance.getSellerOrderList();
                      await DataApiService.instance.getDashboard();
                      
                      setState(() {
                        loader = false;
                      });
                      // GlobalSnackBar.show(context, LoginSnackMessage);
                      StatusCode == '200'
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => navBar(index: 0, see: 1)))
                          : AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Error',
                              desc: SnackMessage,
                              btnOkOnPress: () {},
                            ).show();
                    } else {
                      StatusCode = '403';
                    }

                    // setState(() async {
                    //   Emaillogin = emailcontroller.text;
                    //   PassLogin = passcontroller.text;
                    //   await callApi();
                    //   GlobalSnackBar.show(context, LoginSnackMessage);
                    /* StatusCode == '200'
                        ? AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Success',
                            desc: SnackMessage,
                            btnOkOnPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      navBar(index: 0, see: 1)));
                            },
                          ).show()
                        : AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Error',
                            desc: SnackMessage,
                            btnOkOnPress: () {},
                          ).show(); */
                    // });
                  },
                  child: loader == true
                      ? spinkit
                      : Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        ),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
            ),
            SizedBox(
              height: 3.h,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => signup()));
                    },
                    child: Container(
                      child: Text(
                        " Sign Up",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            /* Container(
              //color: Colors.red,
              width: 88.w,
              height: 6.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(6)),

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/google.png', height: 18),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Continue with Facebook",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                color: Colors.grey.withOpacity(0.01),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              //color: Colors.red,
              width: 88.w,
              height: 6.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(6)),

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icons/google.png', height: 18),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Continue with Google",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                color: Colors.grey.withOpacity(0.01),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              //color: Colors.red,
              width: 88.w,
              height: 6.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(6)),

              child: FlatButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.apple_outlined),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Continue with Apple",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                color: Colors.grey.withOpacity(0.01),
              ),
            ), */
          ],
        ),
      ),
    ));
    Container();
  }
}
