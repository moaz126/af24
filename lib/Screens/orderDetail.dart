import 'package:af24/Screens/newBar.dart';
import 'package:af24/api/global_variable.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class orderDetail extends StatelessWidget {
  const orderDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: newNavBar(
        index: 5,
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Orders details",
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: SafeArea(
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
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Order_No: " +
                                  sellerOrderDetails[index].orderId.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Method: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Cash on delivery",
                                      style: TextStyle(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "1:51 AM / 18 Mar-2022",
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment status",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 42.w,
                                ),
                                Container(
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    color: Colors.red[700],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(
                                    sellerOrderDetails[index]
                                        .paymentStatus
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  )),
                                )
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
                                          BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                      color: Colors.white),
                                  child:
                                      // Padding(
                                      //   padding: const EdgeInsets.all(3.0),
                                      //   child: DottedBorder(
                                      //     dashPattern: [4, 6],
                                      //     strokeWidth: 2,
                                      //     color: Colors.grey,
                                      //     child: Container(
                                      //       alignment: Alignment.center,
                                      //       child: Image.asset(
                                      //         'assets/icons/Seller app icon (19).png',
                                      //         height: 5.h,
                                      //         color: Colors.grey[400],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Image.network(
                                          'http://becknowledge.com/af24/storage/app/public/product/' +
                                              sellerOrderDetails[index]
                                                  .productDetails
                                                  .images[0]),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Item name / Brand",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Size",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "HsCode".toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        sellerOrderDetails[index]
                                                .productDetails
                                                .unitPrice
                                                .toString() +
                                            " EUR  x " +
                                            sellerOrderDetails[index]
                                                .qty
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 16, right: 8),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 30.w,
                                          child: Text("Sub Total"),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            "(+)\$" +
                                                sellerOrderDetails[index]
                                                    .price
                                                    .toString(),
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
                                          child: Text("Tax"),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            "(+)\$" +
                                                sellerOrderDetails[index]
                                                    .tax
                                                    .toString(),
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
                                          child: Text("Discount"),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            "(-)\$" +
                                                sellerOrderDetails[index]
                                                    .productDetails
                                                    .discount
                                                    .toString(),
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
                                          child: Text("Coupon"),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
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
                                          child: Text("Shipping Fee"),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            "(+)\$" +
                                                sellerOrderDetails[index]
                                                    .productDetails
                                                    .shippingCost
                                                    .toString(),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
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
                                          child: Text(
                                            "Total Amount",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            "\$" +
                                                ((sellerOrderDetails[index]
                                                                .qty!
                                                                .toDouble() *
                                                            sellerOrderDetails[
                                                                    index]
                                                                .productDetails
                                                                .unitPrice!
                                                                .toDouble()) +
                                                        sellerOrderDetails[
                                                                index]
                                                            .tax!
                                                            .toDouble() +
                                                        sellerOrderDetails[
                                                                index]
                                                            .productDetails
                                                            .shippingCost!
                                                            .toDouble() -
                                                        sellerOrderDetails[
                                                                index]
                                                            .productDetails
                                                            .discount!
                                                            .toDouble())
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Customer Contact Details",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Name :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(sellerOrderDetails[index].userName),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Email :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(sellerOrderDetails[index].userEmail),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "contact :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(sellerOrderDetails[index].userContact),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "Address :",
                                style: TextStyle(fontWeight: FontWeight.bold),
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
              )
              // Container(
              //   decoration: BoxDecoration(color: Colors.white),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: [
              //         SizedBox(
              //           height: 15,
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(bottom: 8.0),
              //           child: Text(
              //             "Order_No: "+sellerOrderDetails[0].orderId.toString(),
              //             style: TextStyle(fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(bottom: 8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Row(
              //                 mainAxisAlignment: MainAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     "Method: ",
              //                     style: TextStyle(fontWeight: FontWeight.bold),
              //                   ),
              //                   Text(
              //                     "Cash on delivery",
              //                     style: TextStyle(),
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 children: [
              //                   Text(
              //                     "1:51 AM / 18 Mar-2022",
              //                   ),
              //                 ],
              //               )
              //             ],
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(bottom: 12.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Text(
              //                 "Payment status",
              //                 style: TextStyle(fontWeight: FontWeight.bold),
              //               ),
              //               SizedBox(
              //                 width: 42.w,
              //               ),
              //               Container(
              //                 width: 15.w,
              //                 decoration: BoxDecoration(
              //                   color: Colors.red[700],
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 child: Center(
              //                     child: Text(
              //                   sellerOrderDetails[0].paymentStatus.toString(),
              //                   style: TextStyle(color: Colors.white),
              //                 )),
              //               )
              //             ],
              //           ),
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Expanded(
              //               flex: 1,
              //               child: Container(
              //                 height: 140,
              //                 width: 140,
              //                 decoration: BoxDecoration(
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(5)),
              //                     border: Border.all(
              //                       color: Colors.grey.withOpacity(0.4),
              //                     ),
              //                     color: Colors.white),
              //                 child:
              //                 // Padding(
              //                 //   padding: const EdgeInsets.all(3.0),
              //                 //   child: DottedBorder(
              //                 //     dashPattern: [4, 6],
              //                 //     strokeWidth: 2,
              //                 //     color: Colors.grey,
              //                 //     child: Container(
              //                 //       alignment: Alignment.center,
              //                 //       child: Image.asset(
              //                 //         'assets/icons/Seller app icon (19).png',
              //                 //         height: 5.h,
              //                 //         color: Colors.grey[400],
              //                 //       ),
              //                 //     ),
              //                 //   ),
              //                 // ),
              //                 Image.network('http://becknowledge.com/af24/storage/app/public/product/'+sellerOrderDetails[0].productDetails.images[0]),
              //               ),
              //             ),
              //             Expanded(
              //               flex: 1,
              //               child: Center(
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       "Item name / Brand",
              //                       style: TextStyle(fontWeight: FontWeight.bold),
              //                     ),
              //                     SizedBox(
              //                       height: 5,
              //                     ),
              //                     Text(
              //                       "Size",
              //                       style: TextStyle(fontWeight: FontWeight.bold),
              //                     ),
              //                     SizedBox(
              //                       height: 5,
              //                     ),
              //                     Text(
              //                       "HsCode".toUpperCase(),
              //                       style: TextStyle(fontWeight: FontWeight.bold),
              //                     ),
              //                     SizedBox(
              //                       height: 5,
              //                     ),
              //                     Text(
              //                       sellerOrderDetails[0].productDetails.unitPrice.toString() + " EUR  x " + sellerOrderDetails[0].qty.toString(),
              //                       style: TextStyle(fontWeight: FontWeight.bold),
              //                     ),
              //                     SizedBox(
              //                       height: 5,
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 30,
              //         ),
              //         Container(
              //           decoration: BoxDecoration(
              //             color: Colors.grey[100],
              //             borderRadius: BorderRadius.all(Radius.circular(5)),
              //           ),
              //           height: 200,
              //           child: Padding(
              //             padding:
              //                 const EdgeInsets.only(top: 10, left: 16, right: 8),
              //             child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                 children: [
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       SizedBox(
              //                         width: 30.w,
              //                         child: Text("Sub Total"),
              //                       ),
              //                       SizedBox(
              //                         width: 30.w,
              //                       ),
              //                       SizedBox(
              //                         width: 20.w,
              //                         child: Text(
              //                           "(+)\$"+sellerOrderDetails[0].price.toString(),
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       SizedBox(
              //                         width: 30.w,
              //                         child: Text("Tax"),
              //                       ),
              //                       SizedBox(
              //                         width: 30.w,
              //                       ),
              //                       SizedBox(
              //                         width: 20.w,
              //                         child: Text(
              //                           "(+)\$"+sellerOrderDetails[0].tax.toString(),
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       SizedBox(
              //                         width: 30.w,
              //                         child: Text("Discount"),
              //                       ),
              //                       SizedBox(
              //                         width: 30.w,
              //                       ),
              //                       SizedBox(
              //                         width: 20.w,
              //                         child: Text(
              //                           "(-)\$"+sellerOrderDetails[0].productDetails.discount.toString(),
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       SizedBox(
              //                         width: 30.w,
              //                         child: Text("Coupon"),
              //                       ),
              //                       SizedBox(
              //                         width: 30.w,
              //                       ),
              //                       SizedBox(
              //                         width: 20.w,
              //                         child: Text(
              //                           "(-)\$0.00",
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       SizedBox(
              //                         width: 30.w,
              //                         child: Text("Shipping Fee"),
              //                       ),
              //                       SizedBox(
              //                         width: 30.w,
              //                       ),
              //                       SizedBox(
              //                         width: 20.w,
              //                         child: Text(
              //                           "(+)\$"+sellerOrderDetails[0].productDetails.shippingCost.toString(),
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                   Divider(
              //                     thickness: 1,
              //                     height: 1,
              //                     color: Colors.grey,
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       SizedBox(
              //                         width: 30.w,
              //                         child: Text(
              //                           "Total Amount",
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 30.w,
              //                       ),
              //                       SizedBox(
              //                         width: 20.w,
              //                         child: Text(
              //                           "\$"+ ((sellerOrderDetails[0].qty!.toDouble() * sellerOrderDetails[0].productDetails.unitPrice!.toDouble()) + sellerOrderDetails[0].tax!.toDouble() + sellerOrderDetails[0].productDetails.shippingCost!.toDouble() - sellerOrderDetails[0].productDetails.discount!.toDouble() ).toString(),
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold),
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ]),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 20,
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               "Customer Contact Details",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(
              //               height: 7,
              //             ),
              //             Text(
              //               "Name :",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(
              //               height: 7,
              //             ),
              //             Text(
              //               "Email :",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(
              //               height: 7,
              //             ),
              //             Text(
              //               "contact :",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //             SizedBox(
              //               height: 7,
              //             ),
              //             Text(
              //               "Address :",
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              ),
        ),
      ),
    );
  }
}
