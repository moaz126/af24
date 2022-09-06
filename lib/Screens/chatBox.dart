import 'dart:convert';

import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../Model/chatNotificationList.dart';
import '../Model/getChatModel.dart';
import '../api/urls.dart';
import 'package:cron/cron.dart';

class chatBox extends StatefulWidget {
  final String imagePath;
  chatBox({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<chatBox> createState() => _chatBoxState();
}

class _chatBoxState extends State<chatBox> {
  TextEditingController messageController = TextEditingController();
  List<String> messages = [];
  getmessages() {
    for (var i = 0; i < getChatList.length; i++) {
      messages.add(getChatList[i].message);
    }
  }

  final cron = Cron();
  delay() async {
    final cron = Cron();

    try {
      cron.schedule(Schedule.parse('*/2 * * * * *'), () async {
        Map<String, dynamic> userdata1 = {
          'user_id': '3',
          'seller_id': '1',
        };

        await DataApiService.instance.getChat(userdata1, context);
        setState(() {});
      });

      await Future.delayed(Duration(hours: 30));
      await cron.close();
    } on ScheduleParseException {
      // "ScheduleParseException" is thrown if cron parsing is failed.
      await cron.close();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delay();
  }

  var containerKey = GlobalKey();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(Duration(milliseconds: 100), () {
      Scrollable.ensureVisible(
        containerKey.currentContext!,
        duration: const Duration(milliseconds: 0),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              cron.close();
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        /* actions: [
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
        ], */
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 18, top: 8.0, bottom: 2),
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
                      /*  Container(
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
                      ), */
                      for (int index = 0; index < getChatList.length; index++)
                      
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          alignment: getChatList[index].sentByCustomer == 1
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          height: 50,
                          child: Container(
                            child: Row(
                                mainAxisAlignment:
                                    getChatList[index].sentByCustomer == 1
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                children: getChatList[index].sentByCustomer == 1
                                    ? [
                                        Image.asset(
                                          'assets/icons/Seller app icon (8).png',
                                          height: 5.h,
                                        ),
                                        Flexible(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: getChatList[index]
                                                          .sentByCustomer ==
                                                      1
                                                  ? Colors.grey[300]
                                                  : Colors.blue,
                                            ),
                                            child: Text(
                                              '${getChatList[index].message}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 10,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: getChatList[index]
                                                            .sentByCustomer ==
                                                        1
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    : [
                                        Flexible(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: getChatList[index]
                                                          .sentByCustomer ==
                                                      1
                                                  ? Colors.grey[300]
                                                  : Colors.blue,
                                            ),
                                            child: Text(
                                              '${getChatList[index].message}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 10,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: getChatList[index]
                                                            .sentByCustomer ==
                                                        1
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ClipOval(
                                            child: Image.network(
                                          'https://becknowledge.com/af24/public/storage/shop/' +
                                              shopinfoContent.image,
                                          height: 5.h,
                                          width: 5.h,
                                          fit: BoxFit.fill,
                                        ))
                                      ]),
                          ),
                        ),
                      Container(
                        key: containerKey,
                      ),
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
                      controller: messageController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black26.withOpacity(0.04),
                        suffixIcon: InkWell(
                            onTap: () async {
                              Map<String, dynamic> sendmessage = {
                                'user_id': '3',
                                'message': messageController.text,
                              };
                             
                              await DataApiService.instance
                                  .sendMessage(sendmessage, context);

                              messageController.clear();
                              Scrollable.ensureVisible(
                                containerKey.currentContext!,
                                duration: const Duration(milliseconds: 0),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Icon(Icons.send, size: 20)),
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
