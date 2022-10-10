import 'package:af24/Screens/chatNotification.dart';
import 'package:af24/Screens/image_crop.dart';
import 'package:af24/Screens/login.dart';
import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/MyProducts.dart';
import 'package:af24/Screens/paymentLinks.dart';
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

import '../localization/languages/languages.dart';
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
    firstTimeDashboard = false;
  }

  @override
  void initState() {
    firstTimeDashboard ? callApi() : null;
    super.initState();
    status = ['Pending', 'Processing', 'Cancelled'];
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
      title: Languages.of(context)!.EXIT,
      desc: Languages.of(context)!.EXIT_APP_TEXT,
      btnCancelOnPress: () {},
      btnCancelText: Languages.of(context)!.NO,
      btnOkText: Languages.of(context)!.YES,
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
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  List<String> status = [];
  List<int> counter = [
    getDashboardContent!.pending == null ? 0 : getDashboardContent!.pending,
    getDashboardContent!.processing_count,
    getDashboardContent!.cancelledOrder,
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? result = await _onBackPressed();
        if (result == null) {
          result = false;
        }
        return result;
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
                                    Container(
                                      child: Text(
                                        shopinfoContent.name,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    PopupMenuButton<int>(
                                      // ignore: sort_child_properties_last
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          height: 40,
                                          imageUrl:
                                              'https://becknowledge.com/af24/public/storage/shop/${shopinfoContent.image}',
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/icons/Seller app icon (8).png',
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'assets/icons/Seller app icon (8).png',
                                          ),
                                        ),
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 1,
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(Languages.of(context)!
                                                  .EDIT_PROFILE)
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Row(
                                            children: [
                                              Icon(Icons.logout),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  Languages.of(context)!.LOGOUT)
                                            ],
                                          ),
                                        ),
                                      ],
                                      offset: Offset(0, 40),
                                      color: Colors.white,
                                      elevation: 0,

                                      onSelected: (value) {
                                        if (value == 1) {
                                          Get.to(shopInfo());
                                        } else if (value == 2) {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.QUESTION,
                                            animType: AnimType.TOPSLIDE,
                                            title:
                                                Languages.of(context)!.LOGOUT,
                                            desc: Languages.of(context)!
                                                .LOGOUT_TEXT,
                                            btnCancelOnPress: () {},
                                            btnCancelText:
                                                Languages.of(context)!.NO,
                                            btnOkText:
                                                Languages.of(context)!.YES,
                                            btnOkOnPress: () async {
                                              DataApiService.instance.logout(
                                                  shopinfoContent.sellerId);
                                              setUserLoggedIn(false);
                                              GlobalSnackBar.show(
                                                  context,
                                                  Languages.of(context)!
                                                      .LOGOUT_SUCCESS);
                                              Get.offAll(Login());
                                            },
                                          ).show();
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 15,
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
                                        InkWell(
                                          onTap: () {
                                            Get.to(paymentLink());
                                          },
                                          child: Container(
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
                                                              .issued_payment_count >
                                                          99
                                                      ? '99+'
                                                      : getDashboardContent!
                                                          .issued_payment_count
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 40,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    Languages.of(context)!
                                                        .ISSUED,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                  Languages.of(context)!
                                                      .PAYMENT_PAGE,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            orderPressed = 4;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      navBar(index: 4, see: 0)),
                                            );
                                          },
                                          child: Container(
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
                                                              .confirmOrder >
                                                          99
                                                      ? '99+'
                                                      : getDashboardContent!
                                                          .confirmOrder
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: 40,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    Languages.of(context)!
                                                        .ORDER,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    Languages.of(context)!
                                                        .CONFIRMED,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            orderPressed = 5;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      navBar(index: 4, see: 0)),
                                            );
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
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 7.0, top: 12),
                                                  child: Text(
                                                    getDashboardContent!
                                                                .delieved >
                                                            99
                                                        ? '99+'
                                                        : getDashboardContent!
                                                            .delieved
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: 40,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                    Languages.of(context)!
                                                        .DELIVERED,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5.0),
                                                  child: Text("",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
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
                                          InkWell(
                                            onTap: () {
                                              orderPressed = i + 1;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        navBar(
                                                            index: 4, see: 0)),
                                              );
                                            },
                                            child: Container(
                                              height: 100.w / 4.5,
                                              width: 100.w / 4.5,
                                              child: Card(
                                                elevation: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        counter[i] > 99
                                                            ? '99+'
                                                            : counter[i]
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20.sp),
                                                      ),
                                                      Text(
                                                        status[i],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 8.sp),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    ],
                                                  ),
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
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    Languages.of(context)!
                                                        .MY_STORE,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 8.sp),
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
                                        Languages.of(context)!.EARNINGS,
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
                                        Languages.of(context)!.CATTING_WITH,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print('hello');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    navBar(index: 3, see: 0)),
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                  Languages.of(context)!
                                                      .VIEW_ALL,
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
                                        ? Center(
                                            child: Text(Languages.of(context)!
                                                .NO_MESSAGES))
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
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                                    .updatedAt
                                                                    .toString()
                                                                    .substring(
                                                                        11, 16),
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
