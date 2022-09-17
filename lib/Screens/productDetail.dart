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
import 'package:hexcolor/hexcolor.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
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
  var containerKey = GlobalKey();
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

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<void> _pullRefresh() async {
    callApi();
    _refreshController.refreshCompleted();
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
            title: const Text(
              'Product Detail',
              style: TextStyle(color: Colors.black),
            ),
            leading: InkWell(
                onTap: () {
                  cron.close();
                  // Get.offAll((navBar(index: 0, see: 1)));
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
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
                                            fit: BoxFit.contain,
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
                                    height: 230.0,
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
                                              secretUserList.length.toString(),
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                fontSize: 18.sp,
                                              ),
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/icons/Seller app icon (12).png",
                                            height: 17.sp,
                                            color: Colors.green[500],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          productlistContent[widget.index]
                                              .likes
                                              .toString(),
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Image.asset(
                                            "assets/icons/Seller app icon (13).png",
                                            height: 17.sp,
                                            color: Colors.red[500],
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
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(productlistContent[widget.index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30),
                                  textDirection: TextDirection.ltr),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                  productlistContent[widget.index]
                                      .brandName
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                  textDirection: TextDirection.ltr),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
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
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "\$",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: (productlistContent[widget.index]
                                            .variation
                                            .length *
                                        10)
                                    .h +
                                30,
                            child: HorizontalDataTable(
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                              leftHandSideColumnWidth: 60,
                              rightHandSideColumnWidth: 320,
                              isFixedHeader: true,
                              headerWidgets: _getTitleWidget(),
                              leftSideItemBuilder: _generateFirstColumnRow,
                              rightSideItemBuilder:
                                  _generateRightHandSideColumnRow,
                              itemCount: productlistContent[widget.index]
                                  .variation
                                  .length,
                              rowSeparatorWidget: const Divider(
                                color: Colors.black54,
                                height: 1.0,
                                thickness: 0.0,
                              ),
                              leftHandSideColBackgroundColor:
                                  const Color(0xFFFFFFFF),
                              rightHandSideColBackgroundColor:
                                  const Color(0xFFFFFFFF),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Shipping Cost ',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      textDirection: TextDirection.ltr),
                                  Text(
                                      '${productlistContent[widget.index].shippingCost.toString()}\$',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      textDirection: TextDirection.ltr),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Status ',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      textDirection: TextDirection.ltr),
                                  Text(
                                      productlistContent[widget.index].status ==
                                              1
                                          ? 'In Stock'
                                          : 'Out of Stock',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      textDirection: TextDirection.ltr),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('WholeSale Price ',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      textDirection: TextDirection.ltr),
                                  Text(
                                      productlistContent[widget.index]
                                              .wholesalePrice
                                              .toString() +
                                          '\$',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      textDirection: TextDirection.ltr),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Consumer Price ',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      textDirection: TextDirection.ltr),
                                  Text(
                                      productlistContent[widget.index]
                                              .unitPrice
                                              .toString() +
                                          '\$',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                      textDirection: TextDirection.ltr),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                              child: Text('Product Detail: ',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                  textDirection: TextDirection.ltr),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                  productlistContent[widget.index]
                                      .details
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                  textDirection: TextDirection.ltr),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                                  key: containerKey,
                                  width: 35.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      color: checkRequest
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(7)),
                                  alignment: AlignmentDirectional.topStart,
                                  child: Center(
                                    child: Text(
                                      "Comment",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 2.h,
                                          color: checkRequest
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    checkRequest = false;
                                  });
                                },
                                child: Container(
                                  width: 35.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                      color: checkRequest
                                          ? Colors.white
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(7)),
                                  alignment: AlignmentDirectional.topStart,
                                  child: Center(
                                    child: Text(
                                      "Requests",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 2.h,
                                          color: checkRequest
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.black.withOpacity(0.5),
                            height: 3.h,
                          ),
                          checkRequest
                              ? loader
                                  ? spinkit
                                  : secretUserList.isEmpty
                                      ? const Center(child: Text('No Comments'))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: secretUserList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
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
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .topStart,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      10,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                  secretUserList[
                                                                          index]
                                                                      .fName,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize: 17
                                                                          .sp),
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height: 25,
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Text(
                                                              secretUserList[
                                                                      index]
                                                                  .lastMessage
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      9.sp),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        height: 32,
                                                        alignment: Alignment
                                                            .bottomRight,
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
                                                                if (i ==
                                                                    index) {
                                                                  commentUser[
                                                                          index] =
                                                                      !commentUser[
                                                                          index];
                                                                } else {
                                                                  commentUser[
                                                                          i] =
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
                                                                      height:
                                                                          3.5.h,
                                                                      color: Colors
                                                                              .grey[
                                                                          700],
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 8,
                                                                      child:
                                                                          Text(
                                                                        secretUserList[index]
                                                                            .messagesCount
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white),
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
                                                const SizedBox(
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
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            loader2
                                                                ? spinkit2
                                                                : ConstrainedBox(
                                                                    constraints:
                                                                        BoxConstraints(
                                                                            maxHeight:
                                                                                20.h),
                                                                    child: ListView
                                                                        .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      reverse:
                                                                          true,
                                                                      physics:
                                                                          const BouncingScrollPhysics(),
                                                                      itemCount:
                                                                          getSecretList
                                                                              .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 28.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                  width: 70,
                                                                                  child: Text(
                                                                                    getSecretList[index].sendBy.toString() == 'seller' ? getSecretList[index].sellerName.toString() : getSecretList[index].userName.toString(),
                                                                                    maxLines: 1,
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  )),
                                                                              const Text(":  "),
                                                                              SizedBox(width: 200, child: Text(getSecretList[index].message)),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 0.h,
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
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
                                                                            setState(() {
                                                                              getSecretList.insert(0, GetSecretModel(sendBy: 'seller', sellerName: shopinfoContent.name, message: sendcommentController.text));
                                                                            });

                                                                            Map<String, dynamic>
                                                                                sendcommnt =
                                                                                {
                                                                              'user_id': secretUserList[index].id.toString(),
                                                                              'product_id': productlistContent[widget.index].id.toString(),
                                                                              'message': sendcommentController.text,
                                                                              'sender_name': shopinfoContent.name
                                                                            };
                                                                            await DataApiService.instance.sendSecretMessage(sendcommnt,
                                                                                context);
                                                                            setState(() {
                                                                              secretUserList[index].messagesCount++;
                                                                            });
                                                                            sendcommentController.clear();
                                                                          },
                                                                          child:
                                                                              const Icon(Icons.send)),
                                                                  hintText:
                                                                      "  Leave the first comment.",
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
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : const SizedBox(
                                                        height: 10,
                                                      ),
                                              ],
                                            );
                                          },
                                        )
                              : getlinkuser.isEmpty
                                  ? const Center(child: Text('No Requests'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: getlinkuser.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    getlinkuser[index]
                                                        .userName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17.sp),
                                                    textDirection:
                                                        TextDirection.ltr),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Enter Price in \$'),
                                                          content: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            onChanged:
                                                                (value) {},
                                                            controller:
                                                                _textFieldController,
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  "\$ 0.00",
                                                            ),
                                                          ),
                                                          actions: [
                                                            FlatButton(
                                                              textColor:
                                                                  Colors.black,
                                                              onPressed:
                                                                  () async {
                                                                Map<String,
                                                                        dynamic>
                                                                    sendlink = {
                                                                  'price':
                                                                      _textFieldController
                                                                          .text,
                                                                  'request_id':
                                                                      getlinkuser[
                                                                              index]
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
                                                              child: const Text(
                                                                  'Send'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.black),
                                                  child: const Text(
                                                    'Send Link',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Sku', 80),
      _getTitleItemWidget('Color', 80),
      _getTitleItemWidget('Size', 80),
      _getTitleItemWidget('Quantity', 80),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Center(
          child:
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 80,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Center(
          child: Text(productlistContent[widget.index]
              .variation[index]
              .sku
              .toString())),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 80,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: Text(productlistContent[widget.index]
                  .variation[index]
                  .type
                  .toString()
                  .split('-')[0])),
        ),
        Container(
          width: 80,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: Text(productlistContent[widget.index]
                  .variation[index]
                  .type
                  .toString()
                  .split('-')[1])),
        ),
        Container(
          width: 80,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: Text(productlistContent[widget.index]
                  .variation[index]
                  .qty
                  .toString())),
        ),
      ],
    );
  }
}