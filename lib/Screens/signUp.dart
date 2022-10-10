import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../api/auth_af24.dart';
import '../localization/languages/languages.dart';
import 'login.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  int val = -1;
  bool _value = false;
  String gender = '';
  String? TaC;
  bool view1 = true;
  bool view2 = true;
  bool validEmail = false;
  final _formKey = GlobalKey<FormState>();
  final FNameController = TextEditingController();
  final LNameController = TextEditingController();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final PhoneController = TextEditingController();
  final TitleController = TextEditingController();
  final DOBController = TextEditingController();
  final NewsLetterController = TextEditingController();
  final confirmPasswordContoller = TextEditingController();
  final shopAddressController = TextEditingController();
  final ShopNameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TextEditingController _textEditingController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool loader = false;
  // callApi() async {
  //   setState(() {
  //     loader = true;
  //   });
  //   await DataApiService.instance.getSignUptoken();
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

  String dropdownvalue = '0300';
  var items = [
    '0300',
    '0301',
    '0302',
    '0303',
    '0304',
  ];

  @override
  Widget build(BuildContext context) {
    // loader = false;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              width: MediaQuery.of(context).size.width,
              height: 9.h,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/icons/Seller app icon (11).png',
                      height: 4.5.h,
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.arrow_back, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.FIRST_NAME,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 88.w,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Languages.of(context)!.VALIDATOR;
                              }
                            },
                            controller: FNameController,
                            decoration: InputDecoration(
                                hintText: Languages.of(context)!.FIRST_NAME,
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
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.LAST_NAME,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 88.w,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Languages.of(context)!.VALIDATOR;
                              }
                            },
                            controller: LNameController,
                            decoration: InputDecoration(
                                hintText: Languages.of(context)!.LAST_NAME,
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
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.MOBILE_NUMBER,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 6.w,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              width: 88.w,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return Languages.of(context)!.VALIDATOR;
                                  }
                                },
                                keyboardType: TextInputType.phone,
                                controller: PhoneController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(15)
                                ],
                                decoration: InputDecoration(
                                    hintText:
                                        Languages.of(context)!.NUMBER_HINT,
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
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 0, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.EMAIL,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 88.w,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Languages.of(context)!.VALIDATOR;
                              }
                            },
                            controller: EmailController,
                            decoration: InputDecoration(
                                hintText: Languages.of(context)!.EMAIL_HINT,
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
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.PASSWORD,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 88.w,
                          child: TextFormField(
                            obscureText: view1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Languages.of(context)!.VALIDATOR;
                              }
                            },
                            controller: PasswordController,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        view1 = !view1;
                                      });
                                    },
                                    child: Icon(view1
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                hintText: Languages.of(context)!.PASSWORD,
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
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 5, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.PASSWORD_MSG,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.9)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.CONFIRM_PASS,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 88.w,
                          child: TextFormField(
                            controller: confirmPasswordContoller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Languages.of(context)!.VALIDATOR;
                              }
                            },
                            obscureText: view2,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        view2 = !view2;
                                      });
                                    },
                                    child: Icon(view2
                                        ? Icons.visibility_off
                                        : Icons.visibility)),
                                hintText: Languages.of(context)!.CONFIRM_PASS,
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
                        /*  Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Title *",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ), */
                        SizedBox(
                          height: 0.5.h,
                        ),
                        /*    Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.7,
                                    child: Radio(
                                      value: 'MS',
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Ms.",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.7,
                                    child: Radio(
                                      value: 'MR',
                                      groupValue: gender,
                                      onChanged: (value) {
                                        setState(() {
                                          gender = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    "Mr.",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ), */

                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.SHOP_NAME,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 88.w,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Languages.of(context)!.VALIDATOR;
                              }
                            },
                            controller: ShopNameController,
                            decoration: InputDecoration(
                                hintText: Languages.of(context)!.SHOP_NAME,
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
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            Languages.of(context)!.SHOP_ADDRESS,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 88.w,
                          child: TextFormField(
                            controller: shopAddressController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Languages.of(context)!.VALIDATOR;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: Languages.of(context)!.SHOP_ADDRESS,
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
                        Stack(children: [
                          Container(
                            //color: Colors.red,
                            width: 88.w,
                            height: 6.h,
                            child: FlatButton(
                                onPressed: () async {
                                  bool status = false;
                                  if (loader == false) {
                                    if (_formKey.currentState!.validate()) {
                                      if (PasswordController.text ==
                                          confirmPasswordContoller.text) {
                                        if (PasswordController.text.length >=
                                            8) {
                                          if (EmailValidator.validate(
                                              EmailController.text)) {
                                            setState(() {
                                              loader = true;
                                            });
                                            Map<String, dynamic> signupToMap = {
                                              'email': EmailController.text,
                                              'shop_address':
                                                  shopAddressController.text,
                                              'f_name': FNameController.text,
                                              'l_name': LNameController.text,
                                              'shop_name':
                                                  ShopNameController.text,
                                              'phone': PhoneController.text,
                                              'password':
                                                  PasswordController.text
                                            };
                                            status = await DataApiService
                                                .instance
                                                .getSignUptoken(
                                                    signupToMap, context);
                                            setState(() {
                                              loader = false;
                                            });
                                            if (status) {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.SUCCES,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: Languages.of(context)!.SUCCESS,
                                                desc: SnackMessage,
                                                btnOkOnPress: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Login()));
                                                },
                                              ).show();
                                            } else {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.ERROR,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: Languages.of(context)!.ERROR,
                                                desc: SnackMessage,
                                                btnOkOnPress: () {},
                                              ).show();
                                            }
                                          } else {
                                            GlobalSnackBar.show(context,
                                                Languages.of(context)!.ENTER_EMAIL);
                                          }
                                        } else {
                                          GlobalSnackBar.show(context,
                                              Languages.of(context)!.PASS_ERROR);
                                        }
                                      } else {
                                        GlobalSnackBar.show(
                                            context, Languages.of(context)!.PASS_NOMATCH);
                                      }
                                    }
                                  }
                                },
                                child: loader == true
                                    ? spinkit
                                    : Text(
                                        Languages.of(context)!.REGISTER,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6))),
                          ),
                        ]),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Languages.of(context)!.ALREADY,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  Languages.of(context)!.LOGIN,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*    Padding(
                          padding: const EdgeInsets.fromLTRB(22, 5, 0, 0),
                          child: Row(
                            children: [
                              Text(
                                "⚈",
                                style: TextStyle(
                                    fontSize: 7,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                              SizedBox(
                                width: 2.h,
                              ),
                              Text(
                                "Required fields",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7)),
                              )
                            ],
                          ),
                        ),
                     */
                        SizedBox(
                          height: 25.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  /* _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      if(picked.isBefore(selectedDate))
      {
        setState(() {
          selectedDate = picked;
          DOB = picked.toString();
        });
      }
      else{
       GlobalSnackBar.show(context, 'Invalid date');
      }
  }
 */

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
