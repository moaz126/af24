import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/newBar.dart';
import 'package:af24/api/global_variable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:sizer/sizer.dart';

import '../api/auth_af24.dart';

class orderDetail extends StatefulWidget {
  final String id;
  orderDetail(this.id);
  @override
  State<orderDetail> createState() => _orderDetailState();
}

class _orderDetailState extends State<orderDetail> {
  bool loader = false;
  int mainIndex = 0;
  callApi() async {
    setState(() {
      loader = true;
    });

    await DataApiService.instance.getSellerOrderDetails(widget.id);

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

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Variant', 60),
      _getTitleItemWidget('Color', 60),
      _getTitleItemWidget('Size', 60),
      _getTitleItemWidget('Sku', 60),
      _getTitleItemWidget('Quantity', 70),
    ];
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      width: 60,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Center(child: Text('${index + 1}')),
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 70,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: Text(sellerOrderDetails[index]
                  .productDetails
                  .variation[0]
                  .type
                  .toString()
                  .split('-')[0])),
        ),
        Container(
          width: 60,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: Text(sellerOrderDetails[index]
                  .productDetails
                  .variation[0]
                  .type
                  .toString()
                  .split('-')[1])),
        ),
        Container(
          width: 60,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: Text(
                  sellerOrderDetails[index].productDetails.variation[0].sku ==
                          null
                      ? '-'
                      : sellerOrderDetails[index]
                          .productDetails
                          .variation[0]
                          .sku
                          .toString())),
        ),
        Container(
          width: 60,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: Text(
                  sellerOrderDetails[index].productDetails.variation[0].qty ==
                          null
                      ? '-'
                      : sellerOrderDetails[index]
                          .productDetails
                          .variation[0]
                          .qty
                          .toString())),
        ),
      ],
    );
  }

  List<String> status = ['pending', 'processing', 'confirmed', 'delivered'];
  List<String> payment_status = ['paid', 'unpaid'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: newNavBar(
        index: 5,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Orders details",
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              Get.off(navBar(index: 4, see: 0));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: loader
          ? spinkit
          : SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: sellerOrderDetails.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "Order_No: ${sellerOrderDetails[index].orderId}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Method: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            sellerOrderDetails[index]
                                                .paymentMethod
                                                .toString(),
                                            style: TextStyle(),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            sellerOrderDetails[index]
                                                .createdAt
                                                .toString()
                                                .substring(0, 10),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Order status",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 30.w,
                                      ),
                                      sellerOrderDetails[index].orderStatus ==
                                              'delivered'
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 17.w),
                                              child: Container(
                                                width: 18.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.red[700],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  sellerOrderDetails[index]
                                                      .orderStatus
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 1),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.7,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color:
                                                                Colors.black12,
                                                            width: 1.8)),
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButtonFormField(
                                                        // value: dropdownvalue4,
                                                        decoration:
                                                            InputDecoration
                                                                .collapsed(
                                                                    hintText:
                                                                        ''),
                                                        hint: Text(
                                                            sellerOrderDetails[
                                                                    index]
                                                                .orderStatus),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    7)),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                        items: status.map(
                                                            (String items) {
                                                          return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(
                                                              items,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (newValue) async {
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .QUESTION,
                                                            animType: AnimType
                                                                .BOTTOMSLIDE,
                                                            title:
                                                                'Change Status',
                                                            desc:
                                                                'Are you sure you want to Change Status?',
                                                            btnCancelOnPress:
                                                                () {},
                                                            btnCancelText: 'No',
                                                            btnOkText: 'Yes',
                                                            btnOkOnPress:
                                                                () async {
                                                              print(sellerOrderDetails[
                                                                      index]
                                                                  .orderId
                                                                  .toString());
                                                              print(newValue
                                                                  .toString());
                                                              await DataApiService
                                                                  .instance
                                                                  .changeStatus(
                                                                      sellerOrderDetails[
                                                                              index]
                                                                          .orderId
                                                                          .toString(),
                                                                      newValue
                                                                          .toString(),
                                                                      context);
                                                            },
                                                          ).show();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Payment status",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10, top: 1),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.7,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black12,
                                                      width: 1.8)),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField(
                                                  // value: dropdownvalue4,
                                                  decoration:
                                                      InputDecoration.collapsed(
                                                          hintText: ''),
                                                  hint: Text(
                                                      sellerOrderDetails[index]
                                                          .paymentStatus),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.grey[600],
                                                  ),
                                                  items: payment_status
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(
                                                        items,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[600]),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) async {
                                                    AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.QUESTION,
                                                      animType:
                                                          AnimType.BOTTOMSLIDE,
                                                      title: 'Change Status',
                                                      desc:
                                                          'Are you sure you want to Change Status?',
                                                      btnCancelOnPress: () {},
                                                      btnCancelText: 'No',
                                                      btnOkText: 'Yes',
                                                      btnOkOnPress: () async {
                                                        await DataApiService
                                                            .instance
                                                            .changePymentStatus(
                                                                sellerOrderDetails[
                                                                        index]
                                                                    .orderId
                                                                    .toString(),
                                                                newValue
                                                                    .toString(),
                                                                context);
                                                      },
                                                    ).show();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 140,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                            border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                            ),
                                            color: Colors.white),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'http://becknowledge.com/af24/storage/app/public/product/${sellerOrderDetails[index].productDetails.images[0]}',
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/icons/Seller app icon (8).png',
                                          ),
                                        ),
                                        /*   Image.network(
                                                'http://becknowledge.com/af24/storage/app/public/product/${sellerOrderDetails[index].productDetails.images[0]}'),
                                    */
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              sellerOrderDetails[index]
                                                  .productDetails
                                                  .name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              "Size",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "HsCode".toUpperCase(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${sellerOrderDetails[index].price} \$  x ${sellerOrderDetails[index].qty}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 110,
                                  child: HorizontalDataTable(
                                    scrollPhysics:
                                        const NeverScrollableScrollPhysics(),
                                    leftHandSideColumnWidth: 60,
                                    rightHandSideColumnWidth: 300,
                                    isFixedHeader: true,
                                    headerWidgets: _getTitleWidget(),
                                    leftSideItemBuilder:
                                        _generateFirstColumnRow,
                                    rightSideItemBuilder:
                                        _generateRightHandSideColumnRow,
                                    itemCount: sellerOrderDetails.length,
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
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 16, right: 8),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                child: const Text("Sub Total"),
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  "(+)\$${(sellerOrderDetails[index].price.toDouble() * sellerOrderDetails[index].qty)}",
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                child: const Text("Tax"),
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  "(+)\$${sellerOrderDetails[index].tax}",
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                child: const Text("Discount"),
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  "(-)\$${sellerOrderDetails[index].productDetails.discount}",
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                child: const Text("Coupon"),
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                                child: const Text(
                                                  "(-)\$0.00",
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                child:
                                                    const Text("Shipping Fee"),
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  "(+)\$${sellerOrderDetails[index].productDetails.shippingCost}",
                                                ),
                                              )
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            height: 1,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                child: const Text(
                                                  "Total Amount",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  "\$${(sellerOrderDetails[index].qty.toDouble() * sellerOrderDetails[index].productDetails.unitPrice.toDouble()) + sellerOrderDetails[index].tax.toDouble() + sellerOrderDetails[index].productDetails.shippingCost.toDouble() - sellerOrderDetails[index].productDetails.discount.toDouble()}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                        ]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Customer Contact Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Name :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(
                                            sellerOrderDetails[index].userName),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "Email :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(sellerOrderDetails[index]
                                            .userEmail),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "contact :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text(sellerOrderDetails[index]
                                            .userContact),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Text(
                                      "Address :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                      height: 3.h,
                                      thickness: 0.3.h,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ),
            ),
    );
  }
}
