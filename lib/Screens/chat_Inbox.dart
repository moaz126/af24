import 'dart:convert';

import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/shopInfo.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

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

  int templenth = 0;
  final cron = Cron();
  bool showtempMessage = false;
  String tempMessage = '';
  Map<String, dynamic>? userdata1;
  delay() {
    cron.schedule(Schedule.parse('*/5 * * * * *'), () async {
      await DataApiService.instance.getChat(userdata1!, context);
      print(getChatList.length);
      /*   showtempMessage = false;
      print('dfgfdg');
      print(showtempMessage); */
      // if (templenth == getChatList.length) {
      setState(() {});
      // }
    });
  }

  bool loader = false;
  callApi() async {
    setState(() {
      loader = true;
      userdata1 = {
        'user_id': getUserList[widget.index].customer!.id.toString(),
        'seller_id': shopinfoContent.sellerId.toString(),
      };
    });

    await DataApiService.instance.getChat(userdata1!, context);

    setState(() {
      loader = false;
    });
  }

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  final spinkitimg = SpinKitSpinningLines(
    size: 2.h,
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
  Widget build(BuildContext context) {
    print('index');
    print(widget.index);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () async {
              cron.close();
              Get.off(() => navBar(index: 3, see: 0));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          getUserList[widget.index].customer!.fName.toString(),
          style: TextStyle(color: Colors.black, fontSize: 15.sp),
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
                            Container(
                              height: 10.h,
                              width: 10.h,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://becknowledge.com/af24/public/storage/profile/' +
                                          widget.imagePath,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/icons/Seller app icon (8).png',
                                    height: 5.h,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    'assets/icons/Seller app icon (8).png',
                                    height: 5.h,
                                  ),
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
                    /*  getChatList.isNotEmpty
                        ? Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              getChatList[widget.index].updatedAt.toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : SizedBox(), */
                    SizedBox(
                      height: 53.5.h,
                      child: getChatList.isEmpty
                          ? Center(child: Text('No Messages found'))
                          : ListView.builder(
                              itemCount: getChatList.length,
                              reverse: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  alignment:
                                      getChatList[index].sentByCustomer == 1
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                getChatList[index]
                                                            .sentByCustomer ==
                                                        1
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
                                                        child: ClipOval(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                'https://becknowledge.com/af24/public/storage/profile/' +
                                                                    widget
                                                                        .imagePath,
                                                            fit: BoxFit.fill,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Image.asset(
                                                              'assets/icons/Seller app icon (8).png',
                                                              height: 5.h,
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Image.asset(
                                                              'assets/icons/Seller app icon (8).png',
                                                              height: 5.h,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 9),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: getChatList[
                                                                          index]
                                                                      .sentByCustomer ==
                                                                  1
                                                              ? Colors.grey[300]
                                                              : Colors.blue,
                                                        ),
                                                        child: Text(
                                                          '${getChatList[index].message}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: getChatList[
                                                                            index]
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 9),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: getChatList[
                                                                          index]
                                                                      .sentByCustomer ==
                                                                  1
                                                              ? Colors.grey[300]
                                                              : Colors.blue,
                                                        ),
                                                        child: Text(
                                                          '${getChatList[index].message}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 10,
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                            color: getChatList[
                                                                            index]
                                                                        .sentByCustomer ==
                                                                    1
                                                                ? Colors.black
                                                                : Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                      width: 5.h,
                                                      child: ClipOval(
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              'https://becknowledge.com/af24/public/storage/shop/${shopinfoContent.image}',
                                                          fit: BoxFit.fill,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Image.asset(
                                                            'assets/icons/Seller app icon (8).png',
                                                            height: 5.h,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            'assets/icons/Seller app icon (8).png',
                                                            height: 5.h,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: getChatList[index]
                                                            .sentByCustomer ==
                                                        1
                                                    ? 7.h
                                                    : 0,
                                                right: getChatList[index]
                                                            .sentByCustomer ==
                                                        1
                                                    ? 0
                                                    : 7.h),
                                            alignment: getChatList[index]
                                                        .sentByCustomer ==
                                                    1
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                            child: Text(getChatList[index]
                                                .sentTime
                                                .toString()))
                                      ],
                                    ),
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
                                  if (messageController.text.isNotEmpty) {
                                    getChatList.insert(
                                        0,
                                        GetChatModel(
                                          userId: getUserList[widget.index].id,
                                          sellerId: shopinfoContent.id,
                                          sentByCustomer: 0,
                                          sentBySeller: 1,
                                          sentTime: DateFormat("h:mma")
                                              .format(DateTime.now()),
                                          message: messageController.text,
                                        ));
                                    // chatMessages.add();
                                    print(getChatList.length);

                                    setState(() {
                                      showtempMessage = true;
                                      tempMessage = messageController.text;
                                      templenth = getChatList.length;
                                    });
                                    Map<String, dynamic> sendmessage = {
                                      'user_id': getUserList[widget.index]
                                          .customer!
                                          .id
                                          .toString(),
                                      'message': messageController.text,
                                    };

                                    DataApiService.instance
                                        .sendMessage(sendmessage, context);
                                    messageController.clear();
                                  }
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
