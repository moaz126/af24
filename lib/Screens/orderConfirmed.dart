import 'package:af24/Screens/dashBoard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'navBar.dart';
import 'newBar.dart';
import 'orderDetail.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class orderConfirmed extends StatefulWidget {
  const orderConfirmed({Key? key}) : super(key: key);

  @override
  _orderConfirmedState createState() => _orderConfirmedState();
}

class _orderConfirmedState extends State<orderConfirmed> {
  int pressed = 0;

  List<String> buttontext = [
    'All',
    'Pending',
    'Processing',
    'Delivered',
  ];
  String now = DateFormat("dd-MM-yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: newNavBar(
        index: 5,
      ),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$now',style: TextStyle(fontSize: 13.sp),),
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
                                          backgroundColor: Colors.blue,
                                          itemStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          doneStyle:
                                          TextStyle(color: Colors.black, fontSize: 16)),
                                      onChanged: (date) {
                                        print('change $date in time zone ' +
                                            date.timeZoneOffset.inHours.toString());
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                                },
                                child: Icon(
                                  Icons.date_range
                                )),
                            Text('Search Date',style: TextStyle(fontSize: 10.sp),)
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
                              width: 90,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    pressed = i;
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
                Card(
                  elevation: 2,
                  child: SizedBox(
                    height: 20.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Delivery",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "X",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "X",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Date paid",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "16/11/22",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "14/10/22",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "08/09/22",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "User ID",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "ABC12",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "FSC12",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "SSC12",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Order No.",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "560852",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "261852",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "564852",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tracking ID",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    width: 60,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Enter Tracking ID',
                                          enabledBorder: InputBorder.none),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    width: 60,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Enter Tracking ID',
                                          enabledBorder: InputBorder.none),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    width: 60,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Enter Tracking ID',
                                          enabledBorder: InputBorder.none),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Company",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    width: 60,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Enter Delivery Company',
                                          enabledBorder: InputBorder.none),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    width: 60,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Enter Delivery Company',
                                          enabledBorder: InputBorder.none),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    width: 60,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Enter Delivery Company',
                                          enabledBorder: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Size",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "L",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "M",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "M",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "QTY",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "1",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "HSCODE",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "123",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "123",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "123",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "150EUR",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "150EUR",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: Text(
                                      "150EUR",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Order Details",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => orderDetail());
                                      },
                                      child: Text(
                                        'Details',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.sp),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => orderDetail());
                                      },
                                      child: Text(
                                        'Details',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.sp),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => orderDetail());
                                      },
                                      child: Text(
                                        'Details',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.sp),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 2.h),
                            ],
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
      ),
    );
  }
}
