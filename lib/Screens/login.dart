import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/signUp.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/localization/languages/languages.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';
import 'forgotPassword.dart';

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
  bool view = true;
  bool getvalue = false;
  bool rememberMe = false;
  var storedCreds;
  List<String> creds = [];
  String? _email, _pass;

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

  bool status = false;
  @override
  void initState() {
    // TODO: implement initState
    StatusCode = '403';
    firstTimeDashboard = true;
    getStoredCredsList();
    /*  emailcontroller.text = email;
    passcontroller.text = password; */
    super.initState();
  }

  bool data = false;
  getStoredCredsList() async {
    storedCreds = await getCredsList();
    setState(() {
      data = true;
    });
    print(storedCreds);
  }

  matchPassword() {
    if (data) {
      if (storedCreds.isNotEmpty) {
        for (int i = 0; i < storedCreds.length; i++) {
          if (storedCreds[i].split(',')[0] == _email) {
            setState(() {
              passcontroller.text = storedCreds[i].split(',')[1];
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    matchPassword();
    return Scaffold(
        body: Column(
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
        Form(
          key: _formKey,
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(Languages.of(context)!.EMAIL),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  /*  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontStyle: FontStyle.italic),
                        decoration:
                            InputDecoration(border: OutlineInputBorder())),
                    suggestionsCallback: (pattern) async {
                      return await BackendService.getSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(suggestion['name']),
                        subtitle: Text('\$${suggestion['price']}'),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      /*  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductPage(product: suggestion)
    )); */
                    },
                  ), */
                  Container(
                    width: 88.w,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Languages.of(context)!.VALIDATOR;
                        }
                      },
                      onChanged: (text) {
                        setState(() {
                          _email = text;
                        });
                      },
                      controller: emailcontroller,
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
                    margin: EdgeInsets.fromLTRB(0, 1.h, 0, 0),
                    alignment: Alignment.topLeft,
                    child: Text(Languages.of(context)!.PASSWORD),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Container(
                    width: 88.w,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return Languages.of(context)!.VALIDATOR;
                        }
                      },
                      onChanged: (text) {
                        setState(() {
                          _pass = text;
                        });
                        print(_pass);
                      },
                      obscureText: view,
                      controller: passcontroller,
                      decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  view = !view;
                                });
                              },
                              child: Icon(view
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
                  ListTileTheme(
                    horizontalTitleGap: 0,
                    child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(Languages.of(context)!.REMEBER_ME),
                        value: rememberMe,
                        onChanged: (newValue) {
                          setState(() {
                            rememberMe = newValue!;
                            if (rememberMe) {
                              if (creds.isEmpty) {
                                creds.add(_email! + "," + _pass!);
                                creds = creds + storedCreds;
                                print(creds);
                              }
                            }
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ForgotPassword());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Languages.of(context)!.FORGOT_PASSWORD,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
                              StatusCode = '403';
                              setState(() {
                                loader = true;
                              });
                              Map<String, dynamic> loginToMap = {
                                "email": emailcontroller.text,
                                "password": passcontroller.text,
                              };
                              status = await DataApiService.instance
                                  .getlogintoken(loginToMap, context);
                              setState(() {
                                loader = false;
                              });
                              if (status) {
                                await DataApiService.instance.getDashboard();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        navBar(index: 0, see: 1)));
                                DataApiService.instance
                                    .getCategoryList(context);
                                DataApiService.instance.getShippingCost();
                                DataApiService.instance.getBrand();
                                DataApiService.instance.getshopinfo();
                                DataApiService.instance.getcolorlist();
                                DataApiService.instance.getsizelist();
                                DataApiService.instance.getsizelist();
                                DataApiService.instance
                                    .getSellerOrderList(context);

                                await DataApiService.instance.updateFcmToken();
                                if (rememberMe) {
                                  saveCredsList(creds);
                                }
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
                            }
                          }
                        },
                        child: loader == true
                            ? spinkit
                            : Text(
                                Languages.of(context)!.LOGIN,
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
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => signup()));
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Languages.of(context)!.NO_ACCOUNT,
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              Languages.of(context)!.SIGNUP,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
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
          ),
        ),
      ],
    ));
  }

  _isCancelable() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "Rememeber Me",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Switch(
              onChanged: (value) {
                setState(
                  () {
                    getvalue = value;

                    print(getvalue);
                  },
                );
              },
              value: getvalue)
        ],
      ),
    );
  }
}
