import 'package:af24/Model/getSecretModel.dart';
import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/shopInfo.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dashBoard.dart';
import 'newBar.dart';

class products extends StatefulWidget {
  final int index;
  products(this.index);

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
  bool chat = false;
  bool checkRequest = true;
  int commentNumber = 3;
  final List<String> message = [
    'I really want to buy this',
    'Are you sure',
    'Yes',
    'I will get you the payment link'
  ];
  final List<String> text2 = [
    'L***y',
    'Seller',
  ];
  TextEditingController sendcommentController = TextEditingController();
  final List<String> img = [
    'assets/images/alexander-popov-kx1r9Fgqe7s-unsplash.jpg'
  ];
  final controller1 = CarouselController();
  int count = 3;
  int activeIndex = 0;
  int _counter = 0;
  int _counter2 = 0;

  TextEditingController _textFieldController = TextEditingController();

  _incrementCounter() {
    setState(() {
      _counter;
    });
  }

  List<bool> commentUser = [];
  bool loader = false;
  callApi() async {
    setState(() {
      loader = true;
    });
    print(productlistContent[widget.index].id);

    Map<String, dynamic> getuser = {
      'product_id': productlistContent[widget.index].id.toString()
    };
    await DataApiService.instance.getSecretUser(getuser, context);
    await DataApiService.instance.getlinkUsers(getuser, context);
    for (var i = 0; i < secretUserList.length; i++) {
      commentUser.add(false);
    }
    setState(() {
      loader = false;
    });
  }

  final cron = Cron();
  delay() async {
    cron.schedule(Schedule.parse('*/3 * * * * *'), () async {
      commentUser = [];
      Map<String, dynamic> getuser = {
        'product_id': productlistContent[widget.index].id.toString()
      };
      await DataApiService.instance.getSecretUser(getuser, context);
      for (var i = 0; i < secretUserList.length; i++) {
        commentUser.add(false);
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    callApi();
    super.initState();
  }

  final spinkit = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.black,
  );
  bool loader2 = true;
  final spinkit2 = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          cron.close();
          // Get.offAll((navBar(index: 0, see: 1)));
          Navigator.of(context).pop();
          return false;
        },
        child: Scaffold(
          bottomNavigationBar: newNavBar(
            index: 2,
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Product Detail',
              style: TextStyle(color: Colors.black),
            ),
            leading: InkWell(
                onTap: () {
                  cron.close();
                  // Get.offAll((navBar(index: 0, see: 1)));
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                CarouselSlider(
                                  carouselController: controller1,
                                  items: [
                                    for (int i = 0;
                                        i <
                                            productlistContent[widget.index]
                                                .images
                                                .length;
                                        i++)
                                      //1st Image of Slider
                                      Container(
                                        margin: EdgeInsets.all(0.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'http://becknowledge.com/af24/storage/app/public/product/' +
                                                  productlistContent[
                                                          widget.index]
                                                      .images[i],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  ],

                                  //Slider Container properties
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        activeIndex = index;
                                      });
                                    },
                                    height: 280.0,
                                    enlargeCenterPage: true,
                                    autoPlay: false,
                                    aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    viewportFraction: 1.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 2.0),
                                            child: Text(
                                              '$_counter',
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                _incrementCounter();
                                              },
                                              child: Image.asset(
                                                "assets/icons/Seller app icon (12).png",
                                                height: 17.sp,
                                                color: Colors.grey[500],
                                              )),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '$_counter',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Container(
                                            child: InkWell(
                                                onTap: () {
                                                  _incrementCounter();
                                                },
                                                child: Image.asset(
                                                  "assets/icons/Seller app icon (13).png",
                                                  height: 17.sp,
                                                  color: Colors.grey[500],
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                AnimatedSmoothIndicator(
                                  activeIndex: activeIndex,
                                  count: productlistContent[widget.index]
                                      .images
                                      .length,
                                  curve: Curves.bounceInOut,
                                  effect: SlideEffect(
                                    radius: 2,
                                    dotHeight: 3,
                                    dotWidth: 15,
                                    activeDotColor:
                                        Colors.black.withOpacity(0.7),
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                  productlistContent[widget.index].brandName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30),
                                  textDirection: TextDirection.ltr),
                            ),
                            alignment: AlignmentDirectional.topStart,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                  productlistContent[widget.index]
                                      .slug
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                  textDirection: TextDirection.ltr),
                            ),
                            alignment: AlignmentDirectional.topStart,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                      productlistContent[widget.index]
                                          .unitPrice
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textDirection: TextDirection.ltr),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "W",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ],
                              ),
                            ),
                            alignment: AlignmentDirectional.topStart,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/Seller app icon (20).png',
                                    height: 23.sp,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("No Exchange No refunds",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 248, 133, 66))),
                                  )
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.5),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/icons/Seller app icon (12).png',
                                    height: 23.sp,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          /*  Container(
                        height: 50,
                        child: FlatButton(
                          child: Text(
                            'Contact seller',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          color: Color.fromARGB(255, 0, 0, 0),
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        height: 50,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            "+ More Description".toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Color.fromARGB(255, 124, 123, 123)),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        height: 50,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            "Create Alert for Similar Items",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Color.fromARGB(255, 124, 123, 123)),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.1),
                        height: 6.h,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Row(
                            children: [
                              Text(
                                "Quality control",
                                style: TextStyle(
                                    fontSize: 13.25.sp,
                                    color: Colors.black.withOpacity(0.4)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: Colors.black.withOpacity(0.4))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text("Seller",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 30),
                              textDirection: TextDirection.ltr),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/Seller app icon (7).png',
                                  height: 9.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 0.1.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Madam Queen " + ('shop').toUpperCase(),
                                        style: TextStyle(fontSize: 2.h),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/Seller app icon (15).png',
                                              height: 2.h,
                                            ),
                                            SizedBox(
                                              width: 0.3.h,
                                            ),
                                            Text("Czech Republic    ",
                                                style: TextStyle(fontSize: 2.h))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 25.w,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Follow"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ), */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    checkRequest = true;
                                  });
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      color: checkRequest
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Center(
                                    child: Text(
                                      "Comment",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 3.h,
                                          color: checkRequest
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    checkRequest = false;
                                  });
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      color: checkRequest
                                          ? Colors.white
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Center(
                                    child: Text(
                                      "Requests",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 3.h,
                                          color: checkRequest
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                              ),

                              /* Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Proceed to payment(2) / Payment completed(5)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 1.2.h,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ), */
                            ],
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.5),
                            height: 3.h,
                          ),
                          checkRequest
                              ? loader
                                  ? spinkit
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: secretUserList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10, 0, 0, 0),
                                                          child: Text(
                                                              secretUserList[
                                                                      index]
                                                                  .fName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      17.sp),
                                                              textDirection:
                                                                  TextDirection
                                                                      .ltr),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional
                                                                .topStart,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Text(
                                                          secretUserList[index]
                                                              .lastMessage
                                                              .toString()
                                                              .substring(0, 10),
                                                          style: TextStyle(
                                                              fontSize: 9.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 32,
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          loader2 = true;
                                                        });
                                                        setState(() {
                                                          // chat = !chat;

                                                          for (var i = 0;
                                                              i <
                                                                  commentUser
                                                                      .length;
                                                              i++) {
                                                            if (i == index) {
                                                              commentUser[
                                                                      index] =
                                                                  !commentUser[
                                                                      index];
                                                            } else {
                                                              commentUser[i] =
                                                                  false;
                                                            }
                                                          }
                                                        });
                                                        Map<String, dynamic>
                                                            secret = {
                                                          'product_id':
                                                              productlistContent[
                                                                      widget
                                                                          .index]
                                                                  .id
                                                                  .toString(),
                                                          'user_id':
                                                              secretUserList[
                                                                      index]
                                                                  .id
                                                                  .toString()
                                                        };
                                                        await DataApiService
                                                            .instance
                                                            .getSecretMessage(
                                                                secret,
                                                                context);

                                                        setState(() {
                                                          loader2 = false;
                                                        });
                                                      },
                                                      child: SizedBox(
                                                        width: 60,
                                                        child: Row(
                                                          children: [
                                                            Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  'assets/icons/Seller app icon (16).png',
                                                                  height: 3.5.h,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 8,
                                                                  child: Text(
                                                                    secretUserList[
                                                                            index]
                                                                        .messagesCount
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4),
                                                              size: 3.5.h,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            commentUser[index]
                                                ? Container(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        loader2
                                                            ? spinkit2
                                                            : ListView.builder(
                                                                reverse: true,
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    getSecretList
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            28.0),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                            width:
                                                                                50,
                                                                            child:
                                                                                Text(getSecretList[index].senderName.toString())),
                                                                        Text(
                                                                            ":  "),
                                                                        SizedBox(
                                                                            width:
                                                                                200,
                                                                            child:
                                                                                Text(getSecretList[index].message)),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                        /* Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 90.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          'Send Request',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary: Colors
                                                                    .black),
                                                      ),
                                                    ), */
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 5),
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.4),
                                                          ),
                                                          child: TextField(
                                                            controller:
                                                                sendcommentController,
                                                            decoration:
                                                                InputDecoration(
                                                              suffixIcon:
                                                                  InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          getSecretList.insert(
                                                                              0,
                                                                              GetSecretModel(senderName: shopinfoContent.name, message: sendcommentController.text));
                                                                        });

                                                                        Map<String,
                                                                                dynamic>
                                                                            sendcommnt =
                                                                            {
                                                                          'user_id': secretUserList[index]
                                                                              .id
                                                                              .toString(),
                                                                          'product_id': productlistContent[widget.index]
                                                                              .id
                                                                              .toString(),
                                                                          'message':
                                                                              sendcommentController.text,
                                                                          'sender_name':
                                                                              shopinfoContent.name
                                                                        };
                                                                        await DataApiService.instance.sendSecretMessage(
                                                                            sendcommnt,
                                                                            context);

                                                                        sendcommentController
                                                                            .clear();
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .send)),
                                                              hintText:
                                                                  "  Leave the first comment.",
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            style: TextStyle(
                                                                height: 0.1),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 10,
                                                  ),
                                          ],
                                        );
                                      },
                                    )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: getlinkuser.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 0, 0, 0),
                                                      child: Text(
                                                          getlinkuser[index]
                                                              .userName
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 17.sp),
                                                          textDirection:
                                                              TextDirection
                                                                  .ltr),
                                                    ),
                                                    alignment:
                                                        AlignmentDirectional
                                                            .topStart,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  /*  Container(
                                                height: 25,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                  "06-15-2022",
                                                  style:
                                                      TextStyle(fontSize: 9.sp),
                                                ),
                                              ), */
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 90.0),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Expanded(
                                                          child: AlertDialog(
                                                            title: Text(
                                                                'Write Price'),
                                                            content: TextField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              onChanged:
                                                                  (value) {},
                                                              controller:
                                                                  _textFieldController,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    "Price",
                                                              ),
                                                            ),
                                                            actions: [
                                                              FlatButton(
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                onPressed:
                                                                    () async {
                                                                  /*   await DataApiService
                                                              .instance
                                                              .addSize(
                                                                  _textFieldController[
                                                                          i]
                                                                      .text,
                                                                  context); */
                                                                  Map<String,
                                                                          dynamic>
                                                                      sendlink =
                                                                      {
                                                                    'price':
                                                                        _textFieldController
                                                                            .text,
                                                                    'request_id':
                                                                        getlinkuser[index]
                                                                            .id
                                                                            .toString()
                                                                  };
                                                                  await DataApiService
                                                                      .instance
                                                                      .sendLink(
                                                                          sendlink,
                                                                          context);
                                                                  setState(() {
                                                                    // sizepicker = true;
                                                                  });
                                                                  GlobalSnackBar.show(
                                                                      context,
                                                                      snackmessage);

                                                                  Navigator.of(
                                                                          context,
                                                                          rootNavigator:
                                                                              true)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                    'Send'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    'Send Link',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.black),
                                                ),
                                              ),
                                              /*   Container(
                                            height: 32,
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  loader2 = true;
                                                });
                                                setState(() {
                                                  // chat = !chat;

                                                  for (var i = 0;
                                                      i < commentUser.length;
                                                      i++) {
                                                    if (i == index) {
                                                      commentUser[index] =
                                                          !commentUser[index];
                                                    } else {
                                                      commentUser[i] = false;
                                                    }
                                                  }
                                                });
                                                Map<String, dynamic> secret = {
                                                  'product_id':
                                                      productlistContent[
                                                              widget.index]
                                                          .id
                                                          .toString(),
                                                  'user_id':
                                                      secretUserList[index]
                                                          .id
                                                          .toString()
                                                };
                                                await DataApiService.instance
                                                    .getSecretMessage(
                                                        secret, context);

                                                setState(() {
                                                  loader2 = false;
                                                });
                                              },
                                              child: SizedBox(
                                                width: 60,
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/Seller app icon (16).png',
                                                          height: 3.5.h,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                        Container(
                                                          height: 20,
                                                          width: 8,
                                                          child: Text(
                                                            '$commentNumber',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      size: 3.5.h,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                       */
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  },
                                )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
