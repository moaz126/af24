import 'package:af24/Screens/chat.dart';
import 'package:af24/Screens/dashBoard.dart';
import 'package:af24/Screens/uploadProduct.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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

  callApi() async {
    setState(() {
      loader = true;
    });

    await DataApiService.instance.getproductlist();

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

  @override
  void initState() {
    callApi();
    super.initState();
  }

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return loader
        ? spinkit
        : Scaffold(
            // bottomNavigationBar: newNavBar(
            //   index: 4,
            // ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: InkWell(
                  onTap: () {
                    Get.offAll(navBar(index: 0, see: 1));
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              title: Text("My messages",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              actions: [
                InkWell(
                  onTap: () async {
                    FirebaseMessaging.instance.getToken().then((value) async {
                      print(value);
                    });
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
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: (buttonstatus2 == false)
                              ? Image.asset(
                                  'assets/icons/Seller app icon (1).png',
                                  height: 20.sp,
                                )
                              : Image.asset(
                                  'assets/icons/Seller app icon (2).png',
                                  height: 20.sp),
                          onPressed: () {
                            setState(() {
                              buttonstatus2 = false;
                              buttonstatus1 = true;
                              MainScreenStatus = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(150, 50),
                              primary: (buttonstatus1 == false)
                                  ? Colors.white54
                                  : Colors.white,
                              shadowColor: Colors.white,
                              padding: EdgeInsets.symmetric(),
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        ElevatedButton(
                          child: (buttonstatus2 == false)
                              ? Image.asset(
                                  'assets/icons/Seller app icon (4).png',
                                  height: 20.sp,
                                )
                              : Image.asset(
                                  'assets/icons/Seller app icon (3).png',
                                  height: 20.sp),
                          // child: Icon(
                          //   Icons.notifications_outlined,
                          //   color: (buttonstatus2 == false) ? Colors.grey : Colors.blue,
                          // ),
                          onPressed: () async {
                            setState(() {
                              buttonstatus2 = true;
                              buttonstatus1 = false;
                              MainScreenStatus = true;
                            });
                            callApi2();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(150, 50),
                              primary: (buttonstatus2 == false)
                                  ? Colors.white54
                                  : Colors.white,
                              padding: EdgeInsets.symmetric(),
                              shadowColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                  MainScreenStatus == true
                      ? getNotifiationList.isEmpty
                          ? Center(
                              child: Text('No Notification'),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: getNotifiationList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      height: 100,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 3),
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 8,
                                            decoration: BoxDecoration(
                                                color: Colors.orange[700],
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                Image.asset(
                                                  'assets/icons/bottomNavigation (5).png',
                                                  height: 6.9.h,
                                                  color: Colors.grey[400],
                                                ),
                                                CircleAvatar(
                                                  maxRadius: 10,
                                                  backgroundColor: Colors.white,
                                                  child: Image.asset(
                                                    'assets/icons/Seller app icon (18).png',
                                                    height: 2.2.h,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 0.1.h,
                                              ),
                                              Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                getNotifiationList[index]
                                                    .description,
                                                style: TextStyle(
                                                    height: 0.2.h,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.sp),
                                              ),
                                              SizedBox(
                                                height: 0.1.h,
                                              ),
                                              Text(
                                                "10days",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.sp,
                                                ),
                                              )
                                              // GestureDetector(onTap: ,)
                                            ],
                                          )),
                                          SizedBox(
                                            width: 9,
                                          ),
                                          /*  Image.asset('assets/Bag$index.jpg',
                                      width: 50), */
                                        ],
                                      ),
                                    );
                                  }),
                            )
                      : Expanded(
                          child: loader
                              ? spinkit
                              : getUserList.isEmpty
                                  ? Center(
                                      child: Text('No Users'),
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.only(top: 8),
                                      itemCount: getUserList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                                                  builder: (context) => chatBox(
                                                        imagePath:
                                                            'assets/Bag0.jpg',
                                                        index: index,
                                                      )),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: 100,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            color: Colors.white,
                                            child: Row(
                                              children: [
                                                getUserList[index]
                                                            .seenBySeller ==
                                                        1
                                                    ? Container(
                                                        height: 8,
                                                        width: 8,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .orange[700],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                      )
                                                    : SizedBox(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topRight,
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/Seller app icon (8).png',
                                                        height: 6.9.h,
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
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      getUserList[index]
                                                              .customer!
                                                              .fName! +
                                                          ' ' +
                                                          getUserList[index]
                                                              .customer!
                                                              .lName,
                                                      style: TextStyle(
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      getUserList[index]
                                                          .lastMessage
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      getUserList[index]
                                                          .createdAt
                                                          .toString()
                                                          .substring(14, 19),
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.sp),
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
                        )
                ],
              ),
            ));
  }
}
