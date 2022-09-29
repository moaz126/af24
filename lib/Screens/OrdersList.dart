// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:af24/Model/SellerOrderListModel.dart';
import 'package:af24/Screens/login.dart';

import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'navBar.dart';
import 'newBar.dart';
import 'orderDetail.dart';
import 'package:intl/intl.dart';

class newOrderConfirmed extends StatefulWidget {
  @override
  _newOrderConfirmed createState() => _newOrderConfirmed();
}

class _newOrderConfirmed extends State<newOrderConfirmed> {
  int pressed = 0;

  List<String> buttontext = [
    'All',
    'Pending',
    'Processing',
    'Confirmed',
    'Delivered',
    'Canceled',
  ];
  String now = DateFormat("dd-MM-yyyy").format(DateTime.now());
  List<SellerOrderListModel> neworderlist = [];
  List<SellerOrderListModel> pendingOrderList = [];
  List<SellerOrderListModel> processingOrderList = [];
  List<SellerOrderListModel> confiremedOrderList = [];
  List<SellerOrderListModel> deliverdOrderList = [];
  List<SellerOrderListModel> canceledOrderList = [];

  List<SellerOrderListModel> dateOrderList = [];
  List<SellerOrderListModel> selectedOrderList = [];

  List<TextEditingController> trackController = [];
  List<TextEditingController> deliveryController = [];
  DateTime selectdate = DateTime.now();
  int count = 0;

  bool loader = false;
  filterListByStatus() {
    print('123');
    // setState(() {});
    for (var model in sellerOrderList) {
      if (model.orderStatus == 'pending') {
        pendingOrderList.add(model);
      } else if (model.orderStatus == 'processing') {
        processingOrderList.add(model);
      } else if (model.orderStatus == 'confirmed') {
        confiremedOrderList.add(model);
      } else if (model.orderStatus == 'delivered') {
        deliverdOrderList.add(model);
      } else if (model.orderStatus == 'confirmed') {
        confiremedOrderList.add(model);
      } else if (model.orderStatus == 'canceled') {
        canceledOrderList.add(model);
      }
    }

    // setState(() {});
    print('456');
  }

  generateController() {
    trackController.clear();
    for (var i = 0; i < selectedOrderList.length; i++) {
      print('controller');
      print(i);
      trackController.add(TextEditingController());
      deliveryController.add(TextEditingController());
    }
  }

  filterbyDate(DateTime date) {
    pendingOrderList.clear();
    processingOrderList.clear();
    confiremedOrderList.clear();
    deliverdOrderList.clear();
    canceledOrderList.clear();
    for (var model in sellerOrderList) {
      if (date.toString().substring(0, 10) ==
                  model.createdAt.toString().substring(0, 10) &&
              model.orderStatus == 'pending' ||
          model.orderStatus == 'processing' ||
          model.orderStatus == 'confirmed' ||
          model.orderStatus == 'delivered' ||
          model.orderStatus == 'canceled') {
        dateOrderList.add(model);
      }

      if (date.toString().substring(0, 10) ==
              model.createdAt.toString().substring(0, 10) &&
          model.orderStatus == 'pending') {
        print('yes');
        pendingOrderList.add(model);
      } else if (date.toString().substring(0, 10) ==
              model.createdAt.toString().substring(0, 10) &&
          model.orderStatus == 'processing') {
        processingOrderList.add(model);
      } else if (date.toString().substring(0, 10) ==
              model.createdAt.toString().substring(0, 10) &&
          model.orderStatus == 'confirmed') {
        confiremedOrderList.add(model);
      } else if (date.toString().substring(0, 10) ==
              model.createdAt.toString().substring(0, 10) &&
          model.orderStatus == 'delivered') {
        deliverdOrderList.add(model);
      } else if (date.toString().substring(0, 10) ==
              model.createdAt.toString().substring(0, 10) &&
          model.orderStatus == 'canceled') {
        canceledOrderList.add(model);
      } else {
        dateOrderList.add(model);
      }
    }
  }

  callApi() async {
    setState(() {
      loader = true;
    });

    await DataApiService.instance.getSellerOrderList(context);

    await filterListByStatus();
    if (orderPressed == 1) {
      pressed = 1;
      selectedOrderList = pendingOrderList;
    } else if (orderPressed == 2) {
      pressed = 2;
      selectedOrderList = processingOrderList;
    } else if (orderPressed == 3) {
      pressed = 5;
      selectedOrderList = canceledOrderList;
    } else if (orderPressed == 4) {
      pressed = 3;
      selectedOrderList = confiremedOrderList;
    } else if (orderPressed == 5) {
      pressed = 4;
      selectedOrderList = deliverdOrderList;
    } else {
      selectedOrderList = sellerOrderList;
    }
    orderPressed = 0;
    await generateController();
    setState(() {
      loader = false;
    });
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<void> _pullRefresh() async {
    callApi();
    _refreshController.refreshCompleted();
  }

  bool loaderButton = false;
  int checkloader = 0;
  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  bool loadertable = false;
  final spinkittable = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  final saveSpinkit = SpinKitSpinningLines(
    size: 2.h,
    color: Colors.white,
  );
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
  }
/* 
  @override
  void dispose() {
    // TODO: implement dispose
    selectedOrderList.clear();

    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    // loader = false;
    return WillPopScope(
      onWillPop: () async {
        bool? result = await _onBackPressed();
        if (result == null) {
          result = false;
        }
        return result;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
                onTap: () {
                  Get.offAll(navBar(index: 0, see: 1));
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            backgroundColor: Colors.white,
            title: Text(
              "My Order",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    _pullRefresh();
                  },
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: Colors.black,
                  ))
            ],
          ),
          body: loader
              ? spinkit
              : SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  selectdate.toString().substring(0, 10),
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                              ],
                            ),
                            Container(
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(2018, 3, 5),
                                            maxTime: DateTime(2022, 12, 31),
                                            theme: DatePickerTheme(
                                                headerColor: Colors.grey[300],
                                                backgroundColor: Colors.black,
                                                itemStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)),
                                            onChanged: (date) {
                                          print('change $date in time zone ' +
                                              date.timeZoneOffset.inHours
                                                  .toString());
                                        }, onConfirm: (date) async {
                                          setState(() {
                                            loadertable = true;
                                            selectdate = date;
                                            // pressed = 0;
                                            filterbyDate(date);
                                            generateController();
                                            // selectedOrderList = dateOrderList;
                                            print('Confirem $date');
                                            loadertable = false;
                                          });

                                          // filterbydate();
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                      child: Icon(Icons.date_range)),
                                  Text(
                                    'Search Date',
                                    style: TextStyle(fontSize: 10.sp),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 5.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (int i = 0; i < buttontext.length; i++)
                                  Container(
                                    height: 35,
                                    width: 120,
                                    child: InkWell(
                                      onTap: () async {
                                        // filterListByStatus();
                                        setState(() {
                                          pressed = i;
                                          loader = true;
                                          if (pressed == 1) {
                                            selectedOrderList =
                                                pendingOrderList;
                                            generateController();
                                            print(pendingOrderList.length);
                                          } else if (pressed == 2) {
                                            selectedOrderList =
                                                processingOrderList;
                                            generateController();
                                          } else if (pressed == 3) {
                                            selectedOrderList =
                                                confiremedOrderList;
                                            generateController();
                                          } else if (pressed == 4) {
                                            selectedOrderList =
                                                deliverdOrderList;
                                            generateController();
                                          } else if (pressed == 5) {
                                            selectedOrderList =
                                                canceledOrderList;
                                            generateController();
                                          } else {
                                            selectedOrderList = sellerOrderList;
                                            generateController();
                                          }
                                          loader = false;
                                          print(pressed);
                                        });
                                      },
                                      child: Card(
                                        color: (pressed == i)
                                            ? Colors.blue
                                            : Colors.white,
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4),
                                          child: Text(
                                            buttontext[i],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: (pressed == i)
                                                  ? Colors.white
                                                  : Colors.blue,
                                            ),
                                          ),
                                        )),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: selectedOrderList.isEmpty
                            ? Center(
                                child: Text('No Orders Found'),
                              )
                            : loadertable
                                ? spinkittable
                                : HorizontalDataTable(
                                    leftHandSideColumnWidth: 80,
                                    rightHandSideColumnWidth: 650,
                                    isFixedHeader: true,
                                    headerWidgets: _getTitleWidget(),
                                    leftSideItemBuilder:
                                        _generateFirstColumnRow,
                                    rightSideItemBuilder:
                                        _generateRightHandSideColumnRow,
                                    itemCount: selectedOrderList.length,
                                    rowSeparatorWidget: const Divider(
                                      color: Colors.black54,
                                      height: 1.0,
                                      thickness: 0.0,
                                    ),
                                    leftHandSideColBackgroundColor:
                                        Color(0xFFFFFFFF),
                                    rightHandSideColBackgroundColor:
                                        Color(0xFFFFFFFF),
                                  ),
                      ),
                    ],
                  ),
                )),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Order No.', 100),
      _getTitleItemWidget('Date of Order', 100),
      _getTitleItemWidget('Customer ID', 100),
      _getTitleItemWidget('Tracking ID', 90),
      _getTitleItemWidget('Delivery Company', 150),
      // _getTitleItemWidget('Size', 100),
      // _getTitleItemWidget('Color', 100)
      // _getTitleItemWidget('QTY', 100),
      // _getTitleItemWidget('HSCODE', 100),
      /*  _getTitleItemWidget('Price', 100),
      _getTitleItemWidget('Delivery', 100), */
      _getTitleItemWidget('Order Details', 100),
      _getTitleItemWidget('Save Details', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Center(
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Center(child: Text('${selectedOrderList[index].id}')),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(selectedOrderList[index]
                    .createdAt
                    .toString()
                    .substring(0, 10)),
              ))
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Center(
              child: Text(selectedOrderList[index].customerId.toString())),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: sellerOrderList[index].thirdPartyDeliveryTrackingId == null
                ? TextField(
                    controller: trackController[index],
                    decoration: InputDecoration(
                        hintText: 'Enter Tracking ID',
                        enabledBorder: InputBorder.none),
                    maxLines: 1,
                  )
                : Center(
                    child: Text(selectedOrderList[index]
                        .thirdPartyDeliveryTrackingId
                        .toString())),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: sellerOrderList[index].deliveryServiceName == null
                ? TextField(
                    controller: deliveryController[index],
                    decoration: InputDecoration(
                        hintText: 'Enter Delivery Company',
                        enabledBorder: InputBorder.none),
                    maxLines: 1,
                  )
                : Center(
                    child: Text(selectedOrderList[index]
                        .deliveryServiceName
                        .toString())),
          ),
          width: 150,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        /*    Container(
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(child: Text('${selectedOrderList[index].orderAmount}')),
        ),
        Container(
          child: Center(
              child: Text(selectedOrderList[index].orderStatus.toString())),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ), */
        Container(
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                /*  await DataApiService.instance.getSellerOrderDetails(
                    selectedOrderList[index].id!.toInt()); */
                Get.to(
                    () => orderDetail(selectedOrderList[index].id.toString()));
                // selectedOrderList.clear();
              },
              child: Text(
                'Details',
                style: TextStyle(color: Colors.white, fontSize: 11.sp),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Center(
            child: SizedBox(
              height: 37,
              width: 72,
              child: ElevatedButton(
                onPressed: () async {
                  checkloader = index;
                  setState(() {
                    loaderButton = true;
                  });
                  Map<String, dynamic> save = {
                    'order_id': sellerOrderList[index].id.toString(),
                    'delivery_service_name': deliveryController[index].text,
                    'third_party_delivery_tracking_id':
                        trackController[index].text,
                  };
                  print(save);
                  await DataApiService.instance.sendOrderDetail(save, context);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.SUCCES,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'Success',
                    desc: 'Save Successfully',
                    btnOkOnPress: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  navBar(index: 4, see: 0)));
                    },
                  ).show();
                  setState(() {
                    loaderButton = false;
                  });
                },
                child: checkloader == index && loaderButton
                    ? saveSpinkit
                    : Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              ),
            ),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
