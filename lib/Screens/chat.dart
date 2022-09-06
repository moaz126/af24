import 'dart:convert';

import 'package:af24/Screens/shopInfo.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final int index;
  chatBox({Key? key, required this.imagePath, required this.index})
      : super(key: key);

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
    cron.schedule(Schedule.parse('*/3 * * * * *'), () async {
      Map<String, dynamic> userdata1 = {
        'user_id': getUserList[widget.index].customer!.id.toString(),
        'seller_id': '1',
      };

      await DataApiService.instance.getChat(userdata1, context);
      print(getChatList.length);
      setState(() {});
    });
  }

  bool loader = false;
  callApi() async {
    setState(() {
      loader = true;
    });

    Map<String, dynamic> userdata1 = {
      'user_id': getUserList[widget.index].customer!.id.toString(),
      'seller_id': '1',
    };

    await DataApiService.instance.getChat(userdata1, context);

    setState(() {
      loader = false;
    });
  }

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  @override
  void initState() {
    // TODO: implement initState
    callApi();
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
        title: Text(
          getUserList[widget.index].customer!.fName!,
          style: TextStyle(color: Colors.black, fontSize: 10.sp),
        ),
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
      body: loader
          ? spinkit
          : SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.h,
                      child: Card(
                        elevation: 1,
                        child: Column(
                          children: [
                            ClipOval(
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 90,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              child: Text(
                                getUserList[widget.index].customer!.fName! +
                                    ' ' +
                                    getUserList[widget.index].customer!.lName,
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
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "AM 09:09",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 53.5.h,
                      child: ListView.builder(
                          itemCount: getChatList.length,
                          reverse: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              alignment: getChatList[index].sentByCustomer == 1
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                child: Row(
                                    mainAxisAlignment:
                                        getChatList[index].sentByCustomer == 1
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.end,
                                    children: getChatList[index]
                                                .sentByCustomer ==
                                            1
                                        ? [
                                            ClipOval(
                                              child: Container(
                                                height: 5.h,
                                                width: 5.h,
                                                child: Image.asset(
                                                  'assets/icons/Seller app icon (8).png',
                                                  height: 5.h,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 9),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 3),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    horizontal: 20,
                                                    vertical: 9),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 3),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 5.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 7.h,
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: messageController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            filled: true,
                            fillColor: Colors.black26.withOpacity(0.04),
                            suffixIcon: InkWell(
                                onTap: () async {
                                  getChatList.insert(
                                      0,
                                      GetChatModel(
                                        userId: 3,
                                        sellerId: shopinfoContent.id,
                                        sentByCustomer: 0,
                                        sentBySeller: 1,
                                        message: messageController.text,
                                      ));
                                  // chatMessages.add();
                                  print(getChatList.length);
                                  setState(() {});
                                  Map<String, dynamic> sendmessage = {
                                    'user_id': getUserList[widget.index]
                                        .customer!
                                        .id
                                        .toString(),
                                    'message': messageController.text,
                                  };

                                  await DataApiService.instance
                                      .sendMessage(sendmessage, context);

                                  messageController.clear();
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
