import 'package:af24/Screens/image_crop.dart';
import 'package:af24/Screens/login.dart';
import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/MyProducts.dart';
import 'package:af24/Screens/shopInfo.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:af24/Screens/chat_Inbox.dart';
import '../Model/dashBoardChart.dart';

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
    await DataApiService.instance.getUserChat(context);
    await DataApiService.instance.getDashboard();
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<void> _pullRefresh() async {
    callApi();
    _refreshController.refreshCompleted();
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
        setUserLoggedIn(false);

        Get.offAll(Login());
      },
    ).show();
  }

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  List<String> status = ['Delivered', 'Cancelled', 'Return'];
  List<String> counter = [
    getDashboardContent!.delieved == null
        ? '0'
        : getDashboardContent!.delieved.toString(),
    getDashboardContent!.cancelledOrder.toString(),
    getDashboardContent!.returnedOrder.toString()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? result = await _onBackPressed();
        if (result == null) {
          result = false;
        }
        return result!;
      },
      child: Scaffold(
        //bottomNavigationBar: newNavBar(index: 1,),
        body: loader
            ? spinkit
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: _pullRefresh,
                child: SafeArea(
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
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.QUESTION,
                                          animType: AnimType.TOPSLIDE,
                                          title: 'Logout',
                                          desc:
                                              'Are you sure you want to Logout?',
                                          btnCancelOnPress: () {},
                                          btnCancelText: 'No',
                                          btnOkText: 'Yes',
                                          btnOkOnPress: () async {
                                            setUserLoggedIn(false);
                                            GlobalSnackBar.show(
                                                context, 'Logout Successfully');
                                            Get.offAll(Login());
                                          },
                                        ).show();
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
                                                getDashboardContent!
                                                    .issued_payment_count
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text("Issued",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
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
                                                getDashboardContent!
                                                    .confirmOrder
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text("Order",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text("Confirmed",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            /*  await DataApiService.instance
                                                .getDashboard(); */
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 3.0, top: 12),
                                                  child: Text(
                                                    getDashboardContent!
                                                        .outForDelivery
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(height: 5),

                                                /*  Text("",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)), */
                                                Text("Delivered",
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
                                                padding:
                                                    const EdgeInsets.all(5),
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
                                        'Earnings',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
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
                                      borderRadius:
                                          BorderRadius.circular(10.00),
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
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            navBar(index: 3, see: 0),
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          child: Row(
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
                                                color: Colors.black
                                                    .withOpacity(0.9),
                                                size: 13,
                                              ),
                                            ],
                                          ),
                                        ),
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
                                    height: 40.h,
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
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      chatBox(
                                                                        imagePath: getUserList[i]
                                                                            .customer
                                                                            .image,
                                                                        index:
                                                                            i,
                                                                      )),
                                                        );
                                                      },
                                                      leading: Container(
                                                        height: 6.h,
                                                        width: 6.h,
                                                        child: ClipOval(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                'https://becknowledge.com/af24/public/storage/profile/' +
                                                                    getUserList[
                                                                            i]
                                                                        .customer
                                                                        .image,
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
                                                      title: getUserList[i]
                                                                  .customer !=
                                                              null
                                                          ? Text(
                                                              getUserList[i]
                                                                  .customer
                                                                  .fName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : SizedBox(),
                                                      subtitle: Text(
                                                        getUserList[i]
                                                            .lastMessage,
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
                                                              color: Colors
                                                                  .grey[300],
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
              ),
      ),
    );
  }
}
