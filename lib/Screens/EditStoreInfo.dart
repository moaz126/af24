import 'dart:io';

import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../api/auth_af24.dart';

class EditStoreInfo extends StatefulWidget {
  const EditStoreInfo({Key? key}) : super(key: key);

  @override
  State<EditStoreInfo> createState() => _EditStoreInfoState();
}

class _EditStoreInfoState extends State<EditStoreInfo> {
  final _formKey = GlobalKey<FormState>();
  final Namecontroller = TextEditingController();
  final Contactcontroller = TextEditingController();
  final Addresscontroller = TextEditingController();
  late File file;
  bool loader = false;
  final spinkit = SpinKitDancingSquare(
    size: 3.h,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.white : Colors.white,
        ),
      );
    },
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            'Edit Store Info',
            style: TextStyle(color: Colors.black, fontSize: 20.sp),
          ),
        ),
        leading: InkWell(
            onTap: Get.back,
            child: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: Center(
        key: _formKey,
        child: Form(
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipOval(
                      child: Image.asset(
                    'assets/Bag0.jpg',
                    height: 20.h,
                    width: 20.h,
                  )),
                  ClipOval(
                    child: Container(
                      height: 3.h,
                      width: 3.h,
                      decoration: BoxDecoration(color: Colors.orangeAccent),
                      child: Icon(
                        Icons.edit_note_rounded,
                        color: Colors.white,
                        size: 2.5.h,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Expanded(
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.h),
                        topRight: Radius.circular(5.h)),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 50.0, bottom: 20.0, right: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            width: 70.w,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: Namecontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            width: 70.w,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: Contactcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Contact",
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 15)),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            width: 70.w,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: Addresscontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "Address",
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
                            width: 28.w,
                            height: 6.h,

                            child: FlatButton(
                                onPressed: () async {
                                  Map<String, dynamic> loginToMap = {
                                    "image": file,
                                    "name": Namecontroller.text,
                                    "contact": Contactcontroller.text,
                                    "address": Addresscontroller.text,
                                  };
                                  /* await DataApiService.instance
                                      .updateStoreInfo(loginToMap, context); */
                                  GlobalSnackBar.show(context, snackmessage);
                                  /*  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loader = true;
                                    });
                                    Map<String, dynamic> loginToMap = {
                                      "image": "",
                                      "name": Namecontroller.text,
                                      "contact": Contactcontroller.text,
                                      "address": Addresscontroller.text,
                                    };
                                    await DataApiService.instance
                                        .updateStoreInfo(loginToMap, context);
                                    setState(() {
                                      loader = false;
                                    });
                                    GlobalSnackBar.show(context, SnackMessage);
                                    StatusCode != '200'
                                        ? AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.ERROR,
                                            animType: AnimType.BOTTOMSLIDE,
                                            title: 'Error',
                                            desc: SnackMessage,
                                            btnOkOnPress: () {},
                                          ).show()
                                        : Container();
                                  } else {
                                    StatusCode = '403';
                                  }

                                  /* setState(() async {
                                    Emaillogin = emailcontroller.text;
                                    PassLogin = passcontroller.text;
                                    await callApi();
                                    GlobalSnackBar.show(context, LoginSnackMessage), */ */
                                },
                                child: loader == true
                                    ? spinkit
                                    : Text(
                                        "Update",
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }
}
