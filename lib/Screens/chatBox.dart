import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../Model/chatNotificationList.dart';

class chatBox extends StatefulWidget {
  final String imagePath;
  chatBox({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<chatBox> createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Image.asset(
                  'assets/icons/Seller app icon (6).png',
                  height: 3.7.h,
                ),
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                      color: Colors.orange[700],
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  padding: EdgeInsets.only(right: 1, bottom: 1),
                  //color: Colors.blue,
                  child: Text(
                    "23",
                    style: TextStyle(color: Colors.black, fontSize: 8),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 18,right:18,top: 8.0,bottom: 2),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Card(
                          elevation: 1,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 90,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Madam Queen Shop",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "A quick answer, usually in a few minutes",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "AM 09:09",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        height: 15.h,
                        width: 40.h,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Image.asset(
                                widget.imagePath,
                                height: 90,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Louis Vuition",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "VYNJVFXFCE618471",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "5,509,000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      for (int index = 0; index < msgsList.length; index++)
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          alignment: msgsList[index].left == true
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          height: 50,
                          child: Container(
                            child: Row(
                                mainAxisAlignment: msgsList[index].left
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.end,
                                children: msgsList[index].left
                                    ? [
                                        Image.asset(
                                          'assets/icons/Seller app icon (8).png',
                                          height: 5.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: msgsList[index].left == true
                                                ? Colors.grey[300]
                                                : Colors.blue,
                                          ),
                                          child: Text(
                                            '${msgsList[index].msg}',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: msgsList[index].left == true
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ]
                                    : [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: msgsList[index].left == true
                                                ? Colors.grey[300]
                                                : Colors.blue,
                                          ),
                                          child: Text(
                                            '${msgsList[index].msg}',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: msgsList[index].left == true
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/icons/Seller app icon (7).png',
                                          height: 5.h,
                                        )
                                      ]),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0.5),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  child: Center(
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black26.withOpacity(0.04),
                        suffixIcon: Icon(Icons.send, size: 20),
                        hintText: "Write a message",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
