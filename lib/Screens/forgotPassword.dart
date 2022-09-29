import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../api/auth_af24.dart';
import '../constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loader = false;

  final spinkit = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              // Get.offAll((navBar(index: 0, see: 1)));
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
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
                alignment: Alignment.center,
                // margin: EdgeInsets.fromLTRB(3.h, 0, 0, 0),
                child: Text(
                  "You will receive a reset password link on your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
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
                width: 88.w,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field is required";
                    }
                  },
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      hintText: "Your email address",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(6)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(6)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(6)),
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
                      if (loader == false) {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loader = true;
                          });
                          var status;
                          status = await DataApiService.instance
                              .forgotPassword(emailcontroller.text);
                          setState(() {
                            loader = false;
                          });
                          GlobalSnackBar.show(context, status['message']);
                          if (status['success']) {
                            print("changed");
                          } else {
                            print("not changed");
                          }
                        }
                      }
                    },
                    child: loader == true
                        ? spinkit
                        : Text(
                            "Send",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
