import 'package:af24/Screens/EditStoreInfo.dart';
import 'package:af24/Screens/Edit_Product.dart';
import 'package:af24/Screens/linkDetail.dart';
import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/productDetail.dart';
import 'package:af24/Screens/shopInfo.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/src/smart_refresher.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dashBoard.dart';
import 'newBar.dart';

class paymentLink extends StatefulWidget {
  const paymentLink({Key? key}) : super(key: key);

  @override
  _paymentLinkState createState() => _paymentLinkState();
}

class _paymentLinkState extends State<paymentLink> {
  bool loader = false;
  callApi() async {
    setState(() {
      loader = true;
    });

    await DataApiService.instance.getLinksProduct(context);

    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    callApi();
    super.initState();
  }

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  final spinkitimg = SpinKitSpinningLines(
    size: 2.h,
    color: Colors.black,
  );
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<void> _pullRefresh() async {
    callApi();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: newNavBar(index: 2,),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Payment Links',
          style: const TextStyle(color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              Get.offAll((navBar(index: 0, see: 1)));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: loader
          ? spinkit
          : productLinks.isEmpty
              ? const Center(
                  child: Text('List is Empty'),
                )
              : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _pullRefresh,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 0.75),
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      itemCount: productLinks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => linkDetail(index)),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        2, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(6)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Container(
                                    width: 20.h,
                                    height: 20.h,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          'https://becknowledge.com/af24/public/storage/product/thumbnail/' +
                                              productLinks[index].thumbnail,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => spinkitimg,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/place.jpg',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          productLinks[index].name,
                                          style: TextStyle(
                                            height: 1.5,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          productLinks[index]
                                              .linksCount
                                              .toString(),
                                          style: TextStyle(
                                            height: 1.5,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
    );
  }
}
