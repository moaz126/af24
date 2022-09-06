import 'package:af24/Screens/image_crop.dart';
import 'package:af24/Screens/login.dart';
import 'package:af24/Screens/newsFeedMain.dart';
import 'package:af24/Screens/shopInfo.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Model/dashBoardChart.dart';
import '../Model/dashBoardUsers.dart';
import 'newBar.dart';

class dashBoard extends StatefulWidget {
  @override
  _dashBoardState createState() => _dashBoardState();
}

class _dashBoardState extends State<dashBoard> {
  bool loader = false;
  callApi() async {
    setState(() {
      loader = true;
    });

    // await DataApiService.instance.getDashboard();
    await DataApiService.instance.getUserChat();
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
  List<String> status = ['Delivered', 'Cancelled', 'Return'];
  List<String> counter = [
    getDashboardContent!.delieved.toString(),
    getDashboardContent!.cancelledOrder.toString(),
    getDashboardContent!.returnedOrder.toString()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: newNavBar(index: 1,),
      body: loader
          ? spinkit
          : SafeArea(
              child: Container(
                color: Colors.black,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 13.0, bottom: 30, top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              'assets/icons/Seller app icon (11).png',
                              height: 4.h,
                              fit: BoxFit.fitHeight,
                              color: Colors.white,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(shopInfo());
                                  },
                                  child: Container(
                                    width: 10.w,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setUserLoggedIn(false);
                                    Get.offAll(Login());
                                  },
                                  child: Container(
                                    width: 10.w,
                                    child: Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 100.w / 3.3,
                                      width: 100.w / 3.3,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "40",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Issued",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            "Payment Page",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 100.w / 3.3,
                                      width: 100.w / 3.3,
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            getDashboardContent!.confirmOrder
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Order",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          Text("Confirmed",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await DataApiService.instance
                                            .getDashboard();
                                      },
                                      child: Container(
                                        height: 100.w / 3.3,
                                        width: 100.w / 3.3,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              getDashboardContent!
                                                  .outForDelivery
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("Out for",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("Delivery",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for (int i = 0; i < status.length; i++)
                                      Container(
                                        height: 100.w / 4.5,
                                        width: 100.w / 4.5,
                                        child: Card(
                                          elevation: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  counter[i],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.sp),
                                                ),
                                                Text(
                                                  status[i],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(newsFeedMain());
                                      },
                                      child: Container(
                                        height: 100.w / 4.5,
                                        width: 100.w / 4.5,
                                        child: Card(
                                          elevation: 2,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.home, size: 20.sp),
                                              Text(
                                                "My store",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Stock out product',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('View All',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black
                                                  .withOpacity(0.9))),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black.withOpacity(0.9),
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                height: 400,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 1.0),
                                  child: Container(child: dashBoardChart()),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.00),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Chatting with users',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('View All',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black
                                                  .withOpacity(0.9))),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black.withOpacity(0.9),
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                height: 300,
                                child: getUserList.isEmpty
                                    ? Center(child: Text('No Users'))
                                    : ListView(
                                        children: [
                                          for (int i = 0;
                                              i < getUserList.length;
                                              i++)
                                            Column(
                                              children: [
                                                ListTile(
                                                  leading: Stack(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/Seller app icon (8).png',
                                                        height: 5.h,
                                                      ),
                                                      /* Container(
                                                  height: 11,
                                                  width: 11,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF59E0C5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ), */
                                                    ],
                                                  ),
                                                  title: Text(
                                                    getUserList[i]
                                                        .customer
                                                        .fName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  subtitle: Text(
                                                    getUserList[i].lastMessage,
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  trailing: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 20),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                            getUserList[i]
                                                                .createdAt
                                                                .toString()
                                                                .substring(
                                                                    14, 19),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                i < getUserList.length - 1
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 25,
                                                                right: 25),
                                                        child: Divider(
                                                          color:
                                                              Colors.grey[300],
                                                          thickness: 2.0,
                                                          height: 0,
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            )
                                        ],
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
