import 'package:af24/api/global_variable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../api/auth_af24.dart';
import 'login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  final _formKey = GlobalKey<FormState>();
  final FNameController = TextEditingController();
  final LNameController = TextEditingController();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final PhoneController = TextEditingController();
  final TitleController = TextEditingController();
  final DOBController = TextEditingController();
  final NewsLetterController = TextEditingController();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: loader == false ? Colors.black : Colors.white,
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
                    /*  Container(
                      child: Row(
                        children: [
                          Text(
                            "Guest",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                              maxRadius: 18,
                              child: Icon(
                                Icons.person,
                                color: Colors.white.withOpacity(0.7),
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) */
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
                          margin: EdgeInsets.fromLTRB(3.h, 0, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Email *",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          width: 88.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                            },
                            controller: EmailController,
                            decoration: InputDecoration(
                                hintText: "Your email address",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password *",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          width: 88.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                            },
                            controller: PasswordController,
                            decoration: InputDecoration(
                                hintText: "Your password",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 5, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Your password must have atleast 8 characters",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.9)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Confirm Password *",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          width: 88.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
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
                            "First name *",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          width: 88.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                            },
                            controller: FNameController,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Last name *",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          width: 88.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                            },
                            controller: LNameController,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Shop name",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          width: 88.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6)),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                            },
                            controller: ShopNameController,
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Shop Address",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          width: 88.w,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6)),
                          child: TextFormField(
                            controller: shopAddressController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field is required";
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 15)),
                          ),
                        ),
                        /*  Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Birthday ",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                          width: 88.w,
                          height: 7.2.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                              borderRadius: BorderRadius.circular(6)),
                          child: InkWell(
                            onTap: () {
                              // _selectDate(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(fontSize: 2.h),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.calendar_today_rounded,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ), */
                        Container(
                          margin: EdgeInsets.fromLTRB(3.h, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Mobile number *",
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Row(
                          children: [
                            // Container(
                            //   decoration: BoxDecoration(
                            //       border: Border.all(
                            //           color: Colors.grey.withOpacity(0.2)),
                            //       borderRadius: BorderRadius.circular(6)),
                            //   margin: EdgeInsets.fromLTRB(3.h, 0.h, 0, 0),
                            //   child: DropdownButton(
                            //
                            //     underline: Container(),
                            //     value: dropdownvalue,
                            //     icon: Padding(
                            //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            //       child: Icon(Icons.keyboard_arrow_down),
                            //     ),
                            //     items: items.map((String items) {
                            //       return DropdownMenuItem(
                            //         value: items,
                            //         child: Padding(
                            //           padding:
                            //               const EdgeInsets.fromLTRB(2, 10, 0, 10),
                            //           child: Text(
                            //             items,
                            //             style: TextStyle(fontSize: 15),
                            //           ),
                            //         ),
                            //       );
                            //     }).toList(),
                            //     onChanged: (String? newValue) {
                            //       setState(() {
                            //         dropdownvalue = newValue!;
                            //       });
                            //     },
                            //   ),
                            // ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                              width: 88.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(6)),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field is required";
                                  }
                                },
                                keyboardType: TextInputType.phone,
                                controller: PhoneController,
                                decoration: InputDecoration(
                                    hintText: "12345678",
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ],
                        ),
                        /*  Padding(
                          padding: const EdgeInsets.fromLTRB(21, 5, 0, 0),
                          child: Text(
                            "This number will be used to contact you in case of a problem with your order",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.withOpacity(0.9)),
                          ),
                        ), */

                        Container(
                          width: 96.w,
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "This number will be used to contact you in case of a problem with your order",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.9)),
                          ),
                        ),
                        /* Container(
                          width: 96.w,
                          padding: EdgeInsets.fromLTRB(15, 2.h, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Receive our Newsletter",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                        ),
                        Container(
                          width: 96.w,
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Discover our latest collections, news and inspirations before anyone else.",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.withOpacity(0.9)),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Row(
                                children: [
                                  /*   Transform.scale(
                                      scale: 0.7,
                                      child: Radio(
                                        value: '1',
                                        groupValue: NewsLetter,
                                        onChanged: (value) {
                                          setState(() {
                                            NewsLetter = value.toString();});
                                        },  ),
                                  ), */
                                  Text(
                                    "Yes.",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Row(
                                children: [
                                  /*  Transform.scale(
                                    scale: 0.7,
                                    child: Radio(
                                      value: '0',
                                      groupValue: NewsLetter,
                                      onChanged: (value) {
                                        setState(() { NewsLetter = value.toString(); });
                                      },
                                    ),
                                  ), */
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(9, 0, 0, 0),
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 0.7,
                                child: Radio(
                                  value: 'Yes',
                                  groupValue: TaC,
                                  onChanged: (value) {
                                    setState(() {
                                      TaC = value.toString();
                                    });
                                  },
                                ),
                              ),
                              Text(
                                "I have read and agreed to Term and condition",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.7)),
                              )
                            ],
                          ),
                        ), */
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
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loader = true;
                                    });
                                    Map<String, dynamic> signupToMap = {
                                      'email': EmailController.text,
                                      'shop_address':
                                          shopAddressController.text,
                                      'f_name': FNameController.text,
                                      'l_name': LNameController.text,
                                      'shop_name': ShopNameController.text,
                                      'phone': PhoneController.text,
                                      'password': PasswordController.text
                                    };
                                    await DataApiService.instance
                                        .getSignUptoken(signupToMap, context);
                                    setState(() {
                                      loader = false;
                                    });
                                    // GlobalSnackBar.show(context, SnackMessage);

                                    // setState(() async {
                                    //   FName = FNameController.text;
                                    //   LName=LNameController.text;
                                    //   Email=EmailController.text;
                                    //   Phone = dropdownvalue+PhoneController.text;
                                    //   Password=PasswordController.text;
                                    //   // title = gender;
                                    //   //await DataApiService.instance.getSignUptoken();
                                    //   await callApi();
                                    //   GlobalSnackBar.show(context, SnackMessage);
                                    // });
                                    StatusCode == '200'
                                        ? AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.SUCCES,
                                            animType: AnimType.BOTTOMSLIDE,
                                            title: 'Success',
                                            desc: SnackMessage,
                                            btnOkOnPress: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                            },
                                          ).show()
                                        : AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.ERROR,
                                            animType: AnimType.BOTTOMSLIDE,
                                            title: 'Error',
                                            desc: SnackMessage,
                                            btnOkOnPress: () {},
                                          ).show();
                                  }
                                },
                                child: loader == true
                                    ? spinkit
                                    : Text(
                                        "Register",
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
                          padding: const EdgeInsets.fromLTRB(22, 30, 0, 0),
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
                                "Back to Login",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7)),
                              )
                            ],
                          ),
                        ),
                        Padding(
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
