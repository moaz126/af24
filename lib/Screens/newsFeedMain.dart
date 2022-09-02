import 'package:af24/Screens/EditStoreInfo.dart';
import 'package:af24/Screens/Edit_Product.dart';
import 'package:af24/Screens/editproduct.dart';
import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/products.dart';
import 'package:af24/Screens/shopInfo.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dashBoard.dart';
import 'newBar.dart';

class newsFeedMain extends StatefulWidget {
  const newsFeedMain({Key? key}) : super(key: key);

  @override
  _newsFeedMainState createState() => _newsFeedMainState();
}

class _newsFeedMainState extends State<newsFeedMain> {
  /* final List<String> productsDescription = <String>[
    'Displaying the bag with long zips and double sided!',
    'Displaying the bag with small zips and single sided',
  ]; */

  bool loader = false;
  callApi() async {
    setState(() {
      loader = true;
    });

    await DataApiService.instance.getproductlist();

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

  final spinkit = SpinKitDancingSquare(
    size: 3.h,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration:
            BoxDecoration(color: index.isEven ? Colors.black : Colors.black12),
      );
    },
  );
  final spinkitimg = SpinKitDancingSquare(
    size: 2.h,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.black : Colors.grey,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: newNavBar(index: 2,),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'My Products',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        leading: InkWell(
            onTap: () {
              // Get.offAll(navBar(index: 0, see: 1));
              Get.to(dashBoard());
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                /*  InkWell(
                  onTap: () async {
                     Get.to(shopInfo());
                   
                  },
                  child: Image.asset(
                    'assets/icons/Seller app icon (6).png',
                    height: 3.7.h,
                  ),
                ), */
                /*  Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.orange[700],
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  padding: EdgeInsets.only(right: 2),
                  //color: Colors.blue,
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.black, fontSize: 8),
                  ),
                ) */
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: loader
          ? spinkit
          : productlistContent.isEmpty
              ? Center(
                  child: Text('List is Empty'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 8),
                  itemCount: productlistContent.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => products(index)),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 100,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  color: Colors.orange[700],
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: 10.w,
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            'https://becknowledge.com/af24/public/storage/product/thumbnail/' +
                                                productlistContent[index]
                                                    .thumbnail,
                                        placeholder: (context, url) =>
                                            spinkitimg,
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                              Icons.error_outline_sharp,
                                              color: Colors.red,
                                            )),
                                  ),
                                  /*  Image.network(productlistContent[0].thumbnail), */
                                  /*  CircleAvatar(
                                maxRadius: 10,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/icons/Seller app icon (18).png',
                                  height: 2.2.h,
                                ),
                              ), */
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  productlistContent[index].name,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.1.h,
                                ),
                                Text(
                                  "1h",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.sp),
                                )
                                // GestureDetector(onTap: ,)
                              ],
                            )),
                            /*  SizedBox(
                                          width: 9,
                                        ),
                                        Image.asset('assets/images/1.PNG',
                                            width: 50), */

                            InkWell(
                              onTap: () {
                                Get.to(edit_Product(index));
                              },
                              child: Container(
                                height: 10.h,
                                width: 8.w,
                                child: Icon(
                                  Icons.edit,
                                  size: 3.h,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            InkWell(
                              onTap: () async {
                                await DataApiService.instance.deleteProduct(
                                    productlistContent[index].id.toString());

                                GlobalSnackBar.show(context, snackmessage);
                                setState(() {
                                  productlistContent.removeAt(index);
                                });
                              },
                              child: Container(
                                height: 10.h,
                                width: 8.w,
                                child: Icon(
                                  Icons.delete,
                                  size: 3.h,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
    );
  }
}
