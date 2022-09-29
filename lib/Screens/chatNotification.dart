import 'package:af24/Screens/chat_Inbox.dart';
import 'package:af24/Screens/dashBoard.dart';
import 'package:af24/Screens/orderDetail.dart';
import 'package:af24/Screens/productDetail.dart';
import 'package:af24/Screens/uploadProduct.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

//
import 'navBar.dart';
import 'newBar.dart';

class chatNotification extends StatefulWidget {
  const chatNotification({Key? key}) : super(key: key);

  @override
  State<chatNotification> createState() => _chatNotificationState();
}

class _chatNotificationState extends State<chatNotification> {
  bool buttonstatus1 = true;
  bool buttonstatus2 = false;
  bool loader = true;
  bool MainScreenStatus = false;
  final List<String> secrets = <String>[
    'The Seller is ready to drop their price to W930984. Make an offer now!',
    'The Price of the item Mach & Mach Mules has just been reduced.',
  ];

  final List<String> Entries = <String>[
    'The Seller is ready to drop their price to W930984. Make an offer now!',
    'The Price of the item Mach & Mach Mules has just been reduced.',
    'The price of the item Mach & Mach Mules has just been reduced.',
    'The price of the item Mach & Mach Mules has just been reduced.',
    'The price of the item Mach & Mach Mules has just been reduced.',
    'The price of the item Mach & Mach Mules has just been reduced.',
    'The price of the item Mach & Mach Mules has just been reduced.',
    'The price of the item Mach & Mach Mules has just been reduced.',
    'The price of the item Mach & Mach Mules has just been reduced.',
    'The price of the item Mach & Mach Mules has just been reduced.',
  ];
  final List<Image> Images = <Image>[
    Image.asset("assets/Bag1.jpg"),
    Image.asset("assets/Bag2.jpg"),
    Image.asset("assets/Bag2.jpg")
  ];
  final cron = Cron();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<void> _pullRefreshChats() async {
    callApi();
    _refreshController.refreshCompleted();
  }

  Future<void> _pullRefreshNotifications() async {
    callApi2();
    _refreshController.refreshCompleted();
  }

  delay() async {
    cron.schedule(Schedule.parse('*/3 * * * * *'), () async {
      await DataApiService.instance.getUserChat(context);
      setState(() {});
    });
  }

  callApi() async {
    setState(() {
      loader = true;
    });

    await DataApiService.instance.getUserChat(context);

    setState(() {
      loader = false;
    });
  }

  callApi2() async {
    setState(() {
      loader = true;
    });

    await DataApiService.instance
        .getNotification(shopinfoContent.sellerId.toString(), context);

    setState(() {
      loader = false;
    });
  }

  Future<dynamic> _onBackPressed() async {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Exit',
      desc: 'Are you sure you want to Exit?',
      btnCancelOnPress: () {},
      btnCancelText: 'No',
      btnOkText: 'Yes',
      btnOkOnPress: () async {
        SystemNavigator.pop();
      },
    ).show();
  }

  @override
  void initState() {
    callApi();
    super.initState();
    // delay();
  }

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return loader
        ? spinkit
        : WillPopScope(
            onWillPop: () async {
              bool? result = await _onBackPressed();
              if (result == null) {
                result = false;
              }
              return result;
            },
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: InkWell(
                      onTap: () {
                        cron.close();
                        Get.offAll(navBar(index: 0, see: 1));
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                  title: const Text("My Messages",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  actions: [
                    InkWell(
                      onTap: () async {
                        /*   FirebaseMessaging.instance
                            .getToken()
                            .then((value) async {
                          print(value);
                        }); */
                        print('hello');
                        chatNavigate = true;
                        Get.to(uploadProduct());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: 6.w,
                          child: Image.asset(
                            'assets/icons/Seller app icon (5).png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    /*  InkWell(
                onTap: () async {
                  print('in function');
                  Firebase.initializeApp();
                  AndroidNotificationDetails androidPlatformChannelSpecifics =
                      const AndroidNotificationDetails('high_importance_channel',
                          'High Importance Notifications',
                          importance: Importance.high,
                          priority: Priority.high,
                          icon: "@mipmap/ic_launcher");
                  NotificationDetails platformChannelSpecifics =
                      NotificationDetails(
                          android: androidPlatformChannelSpecifics);
                  await FlutterLocalNotificationsPlugin().show(
                      123,
                      "Order Placed",
                      "Your order has been placed. Thank you for choosing us",
                      platformChannelSpecifics,
                      payload: 'data');
                },
                child: Padding(
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
              ), */
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                body: SmartRefresher(
                  enablePullDown: getUserList.isEmpty ? true : false,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: buttonstatus2
                      ? _pullRefreshNotifications
                      : _pullRefreshChats,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  buttonstatus2 = false;
                                  buttonstatus1 = true;
                                  MainScreenStatus = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 50),
                                  primary: (buttonstatus1 == false)
                                      ? Colors.white54
                                      : Colors.white,
                                  shadowColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(),
                                  textStyle: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  )),
                              child: (buttonstatus2 == false)
                                  ? Image.asset(
                                      'assets/icons/Seller app icon (1).png',
                                      height: 20.sp,
                                    )
                                  : Image.asset(
                                      'assets/icons/Seller app icon (2).png',
                                      height: 20.sp),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  buttonstatus2 = true;
                                  buttonstatus1 = false;
                                  MainScreenStatus = true;
                                });
                                cron.close();
                                callApi2();
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 50),
                                  primary: (buttonstatus2 == false)
                                      ? Colors.white54
                                      : Colors.white,
                                  padding: const EdgeInsets.symmetric(),
                                  shadowColor: Colors.white,
                                  textStyle: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  )),
                              child: (buttonstatus2 == false)
                                  ? Image.asset(
                                      'assets/icons/Seller app icon (4).png',
                                      height: 20.sp,
                                    )
                                  : Image.asset(
                                      'assets/icons/Seller app icon (3).png',
                                      height: 20.sp),
                            ),
                          ],
                        ),
                        MainScreenStatus == true
                            ? getNotifiationList.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 30.0.h),
                                      child: const Text('No Notification'),
                                    ),
                                  )
                                : Expanded(
                                    child: SmartRefresher(
                                      enablePullDown: true,
                                      /* getUserList.isNotEmpty ? true : false, */
                                      enablePullUp: false,
                                      controller: _refreshController,
                                      onRefresh: _pullRefreshNotifications,
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(8),
                                          itemCount: getNotifiationList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () async {
                                                await DataApiService.instance
                                                    .seenNotification(
                                                        getNotifiationList[
                                                                index]
                                                            .id
                                                            .toString(),
                                                        context);
                                                if (getNotifiationList[index]
                                                        .title ==
                                                    'Order Placed') {
                                                  Get.to(orderDetail(
                                                      getNotifiationList[index]
                                                          .orderId));
                                                } else if (getNotifiationList[
                                                            index]
                                                        .title ==
                                                    'Secret comment posted') {
                                                  await DataApiService.instance
                                                      .getmainproductlist();
                                                  for (var i = 0;
                                                      i <
                                                          productlistContent
                                                              .length;
                                                      i++) {
                                                    if (getNotifiationList[
                                                                index]
                                                            .productId ==
                                                        productlistContent[i]
                                                            .id
                                                            .toString()) {
                                                      Get.to(products(i));
                                                    }
                                                  }
                                                } else if (getNotifiationList[
                                                            index]
                                                        .title ==
                                                    'Order Cancelled') {
                                                  Get.to(orderDetail(
                                                      getNotifiationList[index]
                                                          .orderId));
                                                } else if (getNotifiationList[
                                                            index]
                                                        .title ==
                                                    'Payment Completed') {
                                                  Get.to(orderDetail(
                                                      getNotifiationList[index]
                                                          .orderId));
                                                } else if (getNotifiationList[
                                                            index]
                                                        .title ==
                                                    'Payment Request Link') {
                                                  await DataApiService.instance
                                                      .getmainproductlist();
                                                  for (var i = 0;
                                                      i <
                                                          productlistContent
                                                              .length;
                                                      i++) {
                                                    if (getNotifiationList[
                                                                index]
                                                            .productId ==
                                                        productlistContent[i]
                                                            .id
                                                            .toString()) {
                                                      Get.to(products(i));
                                                    }
                                                  }
                                                } else {
                                                  for (var i = 0;
                                                      i < getUserList.length;
                                                      i++) {
                                                    print(getNotifiationList[
                                                            index]
                                                        .customerId);
                                                    print(getUserList[i]
                                                        .id
                                                        .toString());
                                                    if (getNotifiationList[
                                                                index]
                                                            .customerId ==
                                                        getUserList[i]
                                                            .userId
                                                            .toString()) {
                                                      print('click');
                                                      Get.to(chatBox(
                                                          imagePath:
                                                              getUserList[i]
                                                                  .customer
                                                                  .image,
                                                          index: i));
                                                    }
                                                  }
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                height: 100,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 3),
                                                color: Colors.white,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 8,
                                                      width: 8,
                                                      decoration: BoxDecoration(
                                                          color: getNotifiationList[
                                                                          index]
                                                                      .status ==
                                                                  0
                                                              ? Colors
                                                                  .orange[700]
                                                              : Colors
                                                                  .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.topRight,
                                                        children: [
                                                          Image.asset(
                                                            'assets/icons/bottomNavigation (5).png',
                                                            height: 6.9.h,
                                                            color: Colors
                                                                .grey[400],
                                                          ),
                                                          CircleAvatar(
                                                            maxRadius: 10,
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Image.asset(
                                                              'assets/icons/Seller app icon (18).png',
                                                              height: 2.2.h,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 0.1.h,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              getNotifiationList[
                                                                      index]
                                                                  .title,
                                                              style: TextStyle(
                                                                  height: 0.2.h,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      10.sp),
                                                            ),
                                                            Text(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              getNotifiationList[
                                                                      index]
                                                                  .description,
                                                              style: TextStyle(
                                                                  height: 0.2.h,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      10.sp),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 0.1.h,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              getNotifiationList[
                                                                      index]
                                                                  .createdAt
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10.sp,
                                                              ),
                                                            ),
                                                            /*  Text(
                                                              getNotifiationList[
                                                                      index]
                                                                  .createdAt
                                                                  .toString()
                                                                  .substring(
                                                                      10, 16),
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10.sp,
                                                              ),
                                                            ), */
                                                          ],
                                                        )
                                                        // GestureDetector(onTap: ,)
                                                      ],
                                                    )),
                                                    const SizedBox(
                                                      width: 9,
                                                    ),
                                                    /*  Image.asset('assets/Bag$index.jpg',
                                              width: 50), */
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  )
                            : Expanded(
                                child: loader
                                    ? spinkit
                                    : getUserList.isEmpty
                                        ? const Center(
                                            child: Text('No Users'),
                                          )
                                        : SmartRefresher(
                                            enablePullDown: true,
                                            /* getNotifiationList.isNotEmpty
                                                    ? true
                                                    : false, */
                                            enablePullUp: false,
                                            controller: _refreshController,
                                            onRefresh: _pullRefreshChats,
                                            child: ListView.builder(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                itemCount: getUserList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return InkWell(
                                                    onTap: () async {
                                                      /*  Map<String, dynamic> userdata = {
                                              'user_id': '3',
                                              'seller_id': '1',
                                            };
                                                                
                                            await DataApiService.instance
                                                .getChat(userdata, context); */
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    chatBox(
                                                                      imagePath: getUserList[
                                                                              index]
                                                                          .customer
                                                                          .image,
                                                                      index:
                                                                          index,
                                                                    )),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      height: 100,
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 3),
                                                      color: Colors.white,
                                                      child: Row(
                                                        children: [
                                                          getUserList[index]
                                                                          .seenBySeller ==
                                                                      0 &&
                                                                  getUserList[index]
                                                                          .sentByCustomer ==
                                                                      1
                                                              ? Container(
                                                                  height: 8,
                                                                  width: 8,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                              .orange[
                                                                          700],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                )
                                                              : const SizedBox(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0),
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              children: [
                                                                Container(
                                                                  height: 6.h,
                                                                  width: 6.h,
                                                                  child:
                                                                      ClipOval(
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl: 'https://becknowledge.com/af24/public/storage/profile/' +
                                                                          getUserList[index]
                                                                              .customer
                                                                              .image,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/icons/Seller app icon (8).png',
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/icons/Seller app icon (8).png',
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                /*  CircleAvatar(
                                                        maxRadius: 10,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Image.asset(
                                                          'assets/icons/Seller app icon (18).png',
                                                          height: 2.2.h,
                                                        ),
                                                      ), */
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 7,
                                                          ),
                                                          Expanded(
                                                              child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 2,
                                                              ),
                                                              getUserList[index]
                                                                          .customer !=
                                                                      null
                                                                  ? Text(
                                                                      getUserList[index]
                                                                              .customer!
                                                                              .fName! +
                                                                          ' ' +
                                                                          getUserList[index]
                                                                              .customer!
                                                                              .lName,
                                                                      style:
                                                                          TextStyle(
                                                                        height:
                                                                            1.5,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        fontSize:
                                                                            10.sp,
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                getUserList[
                                                                        index]
                                                                    .lastMessage
                                                                    .toString(),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10.sp),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                getUserList[
                                                                        index]
                                                                    .updatedAt
                                                                    .toString()
                                                                    .substring(
                                                                        11, 16),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10.sp),
                                                              )
                                                              // GestureDetector(onTap: ,)
                                                            ],
                                                          )),
                                                          /*  SizedBox(
                                              width: 9,
                                            ),
                                            Image.asset('assets/images/1.PNG',
                                                width: 50), */
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                              )
                      ],
                    ),
                  ),
                )),
          );
  }
}
