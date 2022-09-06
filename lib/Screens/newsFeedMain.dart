import 'package:af24/Screens/EditStoreInfo.dart';
import 'package:af24/Screens/Edit_Product.dart';
import 'package:af24/Screens/editproduct.dart';
import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/products.dart';
import 'package:af24/Screens/shopInfo.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
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

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  final spinkitimg = SpinKitSpinningLines(
    size: 2.h,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: newNavBar(index: 2,),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          shopinfoContent.name,
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              Get.offAll((navBar(index: 0, see: 1)));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: loader
          ? spinkit
          : productlistContent.isEmpty
              ? Center(
                  child: Text('List is Empty'),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.85),
                  padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
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
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(2, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                width: 10.h,
                                height: 10.h,
                                child: CachedNetworkImage(
                                    imageUrl:
                                        'https://becknowledge.com/af24/public/storage/product/thumbnail/' +
                                            productlistContent[index].thumbnail,
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => spinkitimg,
                                    errorWidget: (context, url, error) => Icon(
                                          Icons.error_outline_sharp,
                                          color: Colors.red,
                                        )),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  productlistContent[index].name,
                                  style: TextStyle(
                                    height: 1.5,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  productlistContent[index]
                                      .createdAt
                                      .toString()
                                      .substring(14, 19),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.sp),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Get.to(edit_Product(index));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              'Edit    ',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.QUESTION,
                                          animType: AnimType.BOTTOMSLIDE,
                                          title: 'Delete',
                                          desc:
                                              'Are you sure you want to delete',
                                          btnCancelOnPress: () {},
                                          btnCancelText: 'No',
                                          btnOkText: 'Yes',
                                          btnOkOnPress: () async {
                                            await DataApiService.instance
                                                .deleteProduct(
                                                    productlistContent[index]
                                                        .id
                                                        .toString());
                                            GlobalSnackBar.show(
                                                context, snackmessage);
                                            setState(() {
                                              productlistContent
                                                  .removeAt(index);
                                            });
                                          },
                                        ).show();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
    );
  }
}
