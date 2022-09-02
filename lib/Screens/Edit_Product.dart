import 'dart:io';
import 'dart:async';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import 'package:af24/Model/GetcategoriesModel.dart';
import 'package:af24/Model/getbrand.dart';
import 'package:af24/Screens/dashBoard.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';

import 'navBar.dart';
import 'newBar.dart';

class edit_Product extends StatefulWidget {
  final int index;
  edit_Product(this.index);
  @override
  _edit_ProductState createState() => _edit_ProductState();
}

class _edit_ProductState extends State<edit_Product> {
  final NameController = TextEditingController();
  final BrandidController = TextEditingController();
  final ShippingcostController = TextEditingController();
  final PurchasePriceController = TextEditingController();
  final SubnameController = TextEditingController();
  final DescriptionController = TextEditingController();
  final ColorController = TextEditingController();
  final SizeController = TextEditingController();

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodeConsumer = FocusNode();
  FocusNode myFocusNodeWhole = FocusNode();
  CategoryModel? subcat;
  String? dropdownvalue;
  late int value;
  late int subvalue;
  late int brandvalue;
  late GetBrandModel brands;
  late List<String> colors;
  late List<String> size;
  late String dropcat;
  bool loader = false;
  final spinkit = SpinKitDancingSquare(
    size: 3.h,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.white : Colors.white,
        ),
      );
    },
  );
  var items = [
    'Bag',
    'Shoes',
  ];
  late File file;
  bool showsub = false;
  late int index;
  String? dropdownvalue2;
  var items2 = ['Fancy Shoes', 'Tote Bags'];
  String? dropdownvalue3;
  var items3 = ['Wholesale price', 'Consumer price'];
  List<String> images = [];
  List<String> imagesfile = [];

  String? dropdownvalue4;
  var items4 = [
    'Stock',
    'Re-Stock',
  ];
  addImages() {
    imageditlist = [];
    for (var i = 0; i < productlistContent[widget.index].images.length; i++) {
      imageditlist.add(productlistContent[widget.index].images[i]);
    }
  }

  @override
  void initState() {
    addImages();
    myFocusNode.addListener(() {
      setState(() {});
    });
    myFocusNodeConsumer.addListener(() {
      setState(() {});
    });
    myFocusNodeWhole.addListener(() {
      setState(() {});
    });
    NameController.text = productlistContent[widget.index].name;
    SubnameController.text = productlistContent[widget.index].subName;
    DescriptionController.text = productlistContent[widget.index].details!;
    ShippingcostController.text =
        productlistContent[widget.index].shippingCost.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: newNavBar(
      //   index: 3,
      // ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Edit Product',
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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Details',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Images',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: 20),
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          for (int i = 0;
                              i <
                                  productlistContent[widget.index]
                                      .images
                                      .length;
                              i++)
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await selectFile();
                                    Map<String, dynamic> upload = {
                                      'image': file.toString(),
                                      'type': 'product',
                                    };
                                  },
                                  child: Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.4),
                                        ),
                                        color: Colors.white),
                                    child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Image.network(
                                          'http://becknowledge.com/af24/storage/app/public/product/' +
                                              productlistContent[widget.index]
                                                  .images[i],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )),
                                  ),
                                ),
                                Positioned(
                                    right: 5,
                                    top: 5,
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            productlistContent[widget.index]
                                                .images
                                                .removeAt(i);
                                          });

                                          print("helooooooooooooo");
                                        },
                                        child: Icon(Icons.close)))
                              ],
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          for (int i = 0; i < images.length; i++)
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await selectFile();
                                    Map<String, dynamic> upload = {
                                      'image': file.toString(),
                                      'type': 'product',
                                    };
                                  },
                                  child: Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.4),
                                        ),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: productlistContent[widget.index]
                                              .images[i]
                                              .isEmpty
                                          ? DottedBorder(
                                              dashPattern: [4, 6],
                                              strokeWidth: 2,
                                              color: Colors.grey,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  'assets/icons/Seller app icon (19).png',
                                                  height: 5.h,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            )
                                          : Image.file(
                                              File(images[i]),
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 5,
                                    top: 5,
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            images.removeAt(i);
                                            imagesfile.removeAt(i);
                                          });

                                          print("helooooooooooooo");
                                        },
                                        child: Icon(Icons.close)))
                              ],
                            ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          await selectFile();
                          Map<String, dynamic> upload = {
                            'image': file.toString(),
                            'type': 'product',
                          };
                        },
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
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: DottedBorder(
                                dashPattern: [4, 6],
                                strokeWidth: 2,
                                color: Colors.grey,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/icons/Seller app icon (19).png',
                                    height: 5.h,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            'Product Name',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      Text(
                        'Sub Name',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black12, width: 1.8)),
                          child: TextField(
                            onTap: () {
                              setState(() {});
                            },
                            controller: NameController,
                            decoration: InputDecoration(
                                hintText: 'Product Name',
                                enabledBorder: InputBorder.none),
                            maxLines: 1,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black12, width: 1.8)),
                          child: TextField(
                            onTap: () {
                              setState(() {
                                SubName = SubnameController.text;
                              });
                            },
                            controller: SubnameController,
                            decoration: InputDecoration(
                                hintText: 'Sub Name',
                                enabledBorder: InputBorder.none),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            'Category',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      showsub == true
                          ? Text(
                              'Sub Catgory',
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: Colors.black12, width: 1.8)),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: DropdownButton(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              icon: Icon(Icons.keyboard_arrow_down),
                              hint: Text('Category'),
                              value: dropdownvalue,
                              items: catergorylist.map((CategoryModel item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.name,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  showsub = true;
                                  //dropdownvalue = newValue as String?;
                                  subcat = newValue as CategoryModel?;
                                  print('category');
                                  print(subcat!.id);
                                  print(subcat!.name);
                                  value = subcat!.id;
                                  print(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      showsub == true
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                height: 40,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black12, width: 1.8)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    hint: Text('Sub Category'),
                                    value: dropdownvalue,
                                    items: subcat!.subCategories
                                        .map((CategoryModel item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        subcat = newValue as CategoryModel?;
                                        print('subcategory');
                                        subvalue = subcat!.id;
                                        print(subvalue);

                                        print(subvalue);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            'Brand',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      Text(
                        'Color',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black12, width: 1.8)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: dropdownvalue4,
                            hint: Text('Brands'),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[600],
                            ),
                            items: brandlist.map((GetBrandModel items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items.name,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                print(newValue);
                                // dropdownvalue4 = newValue! as String?;
                                brands = newValue as GetBrandModel;
                                //dropdownvalue4 = brands.name;
                                print(brands.name);
                                brandvalue = brands.id;
                                print(brandvalue);
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black12, width: 1.8)),
                          child: TextField(
                            controller: ColorController,
                            decoration: InputDecoration(
                                hintText: 'Color',
                                enabledBorder: InputBorder.none),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            'Size',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      Text(
                        'Status',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black12, width: 1.8)),
                          child: TextField(
                            controller: SizeController,
                            decoration: InputDecoration(
                                hintText: 'Size',
                                enabledBorder: InputBorder.none),
                            maxLines: 1,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black12, width: 1.8)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: dropdownvalue4,
                              hint: Text('Status'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey[600],
                              ),
                              items: items4.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue4 = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: Container(
                      //     padding: EdgeInsets.only(left: 10, right: 10),
                      //     height: 40,
                      //     width: MediaQuery.of(context).size.width / 2.3,
                      //     decoration: BoxDecoration(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(5)),
                      //         color: Colors.white,
                      //         border: Border.all(
                      //             color: Colors.black12, width: 1.8)),
                      //     child: TextField(
                      //       keyboardType: TextInputType.number,
                      //       focusNode: myFocusNode,
                      //       decoration: InputDecoration(
                      //           prefix: Text('\$'),
                      //           hintText: myFocusNode.hasFocus ? '' : '\$ 0.00',
                      //           border: InputBorder.none,
                      //           enabledBorder: InputBorder.none),
                      //       maxLines: 1,
                      //     )
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            'Shipping Cost',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      Text(
                        'Company',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black12, width: 1.8)),
                          child: TextField(
                            onTap: () {
                              Shipping_Cost = ShippingcostController.text;
                            },
                            controller: ShippingcostController,
                            keyboardType: TextInputType.number,
                            focusNode: myFocusNode,
                            decoration: InputDecoration(
                                prefix: Text(
                                    '\$' /*  + categorycostlist[0].cost.toString() */),
                                hintText: myFocusNode.hasFocus ? '' : '\$ 0.00',
                                hintStyle: TextStyle(color: Colors.grey),
                                /*   hintText:
                                    '\$ ' + categorycostlist[0].cost.toString(), */
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            maxLines: 1,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black12, width: 1.8)),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Company',
                                enabledBorder: InputBorder.none),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            'Price',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      dropdownvalue3 == 'Consumer price' ||
                              dropdownvalue3 == 'Wholesale price'
                          ? dropdownvalue3 == 'Consumer price'
                              ? Text(
                                  'Consumer Price',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  'Wholesale Price',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black12, width: 1.8)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: dropdownvalue3,
                            hint: Text('Price'),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[600],
                            ),
                            items: items3.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue3 = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      dropdownvalue3 == 'Consumer price' ||
                              dropdownvalue3 == 'Wholesale price'
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  dropdownvalue3 == 'Wholesale price'
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black12,
                                                  width: 1.8)),
                                          child: TextField(
                                            onTap: () {
                                              setState(() {
                                                Price_type = 'Wholesale';
                                                Purchase_price =
                                                    PurchasePriceController
                                                        .text;
                                              });
                                            },
                                            controller: PurchasePriceController,
                                            keyboardType: TextInputType.number,
                                            focusNode: myFocusNodeWhole,
                                            decoration: InputDecoration(
                                                enabled: true,
                                                prefix: Text('\$'),
                                                hintText:
                                                    myFocusNodeWhole.hasFocus
                                                        ? ''
                                                        : '\$ 0.00',
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    InputBorder.none),
                                            maxLines: 1,
                                          ))
                                      : Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black12,
                                                  width: 1.8)),
                                          child: TextField(
                                            onTap: () {
                                              setState(() {
                                                Price_type = 'Consumer';
                                                Purchase_price =
                                                    PurchasePriceController
                                                        .text;
                                              });
                                            },
                                            controller: PurchasePriceController,
                                            keyboardType: TextInputType.number,
                                            focusNode: myFocusNodeConsumer,
                                            decoration: InputDecoration(
                                                enabled: true,
                                                prefix: Text('\$'),
                                                hintText:
                                                    myFocusNodeConsumer.hasFocus
                                                        ? ''
                                                        : '\$ 0.00',
                                                border: InputBorder.none,
                                                enabledBorder:
                                                    InputBorder.none),
                                            maxLines: 1,
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : Container(),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10),
                      //   child: Container(
                      //     padding: EdgeInsets.only(left: 10, right: 10),
                      //     height: 40,
                      //     width: MediaQuery.of(context).size.width / 2.3,
                      //     decoration: BoxDecoration(
                      //         borderRadius:
                      //         BorderRadius.all(Radius.circular(5)),
                      //         color: Colors.white,
                      //         border: Border.all(
                      //             color: Colors.black12, width: 1.8)),
                      //     child: TextField(
                      //       keyboardType: TextInputType.number,
                      //       focusNode: myFocusNode,
                      //       decoration: InputDecoration(
                      //           prefix: Text('\$'),
                      //           hintText: myFocusNode.hasFocus ? '' : '\$ 0.00',
                      //           border: InputBorder.none,
                      //           enabledBorder: InputBorder.none),
                      //       maxLines: 1,
                      //     )
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                        border: Border.all(color: Colors.black12, width: 1.8)),
                    width: MediaQuery.of(context).size.width / 1.12,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                      child: TextField(
                        controller: DescriptionController,
                        decoration: new InputDecoration.collapsed(
                            hintText: 'Enter Description'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.12,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loader = true;
                        colors = ColorController.text.split(',');
                        size = SizeController.text.split(',');
                      });
                      String product = 'product';
                      String thumbnail = 'thumbnail';
                      await DataApiService.instance
                          .updateProfileContent(images[0], thumbnail);
                      for (int i = 0; i < images.length; i++) {
                        Map<String, dynamic> upload = {
                          'image': imagesfile[i],
                          'type': 'product',
                        };
                        print('for');
                        await DataApiService.instance
                            .updateProfileContent(images[i], product);
                        print('thumbnail=' + thumbnaiImage);
                      }
                      Map<String, dynamic> updateProductMap = {
                        'name': NameController.text,
                        'sub_name': SubnameController.text,
                        'category_id': subvalue.toString(),
                        'brand_id': brandvalue.toString(),
                        'unit': 'pc',
                        for (int i = 0; i < imageditlist.length; i++)
                          'images[$i]': imageditlist[i],
                        'thumbnail': thumbnaiImage,
                        'discount_type': 'percent',
                        'tax': '10',
                        'lang[]': 'en',
                        'unit_price': '60',
                        'purchase_price': '40',
                        'discount': '20',
                        'shipping_cost': ShippingcostController.text,
                        'description': DescriptionController.text,
                        'price_type': 'wholesale',
                        '_method': 'PUT'
                      };

                      await DataApiService.instance.updateproducts(
                          productlistContent[widget.index].id,
                          updateProductMap,
                          context);
                      setState(() {
                        loader = false;
                      });
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Success',
                        desc: SnackMessage,
                        btnOkOnPress: () {},
                      ).show();
                    },
                    child: loader
                        ? spinkit
                        : Text(
                            'Upload Now',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
                          ),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    images.add(path);

    setState(() => file = File(path));
    imagesfile.add(file.toString());
  }
}
