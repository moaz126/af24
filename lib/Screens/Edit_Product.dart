import 'dart:io';
import 'dart:async';

import 'package:af24/Model/getColors.dart';
import 'package:af24/Model/getsizeModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

import '../localization/languages/languages.dart';
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
  final WholesalePriceController = TextEditingController();
  final SubnameController = TextEditingController();
  final DescriptionController = TextEditingController();
  final ColorController = TextEditingController();
  final SizeController = TextEditingController();
  TextEditingController _textSizeController = TextEditingController();
  TextEditingController _textColorController = TextEditingController();
  int check = 0;
  int subcheck = 0;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  List<int> colorsSelectedIndex = [];
  bool generateVarient = false;
  List<dynamic> sizeVarient = [];
  List<String> colorVarient = [];
  List<dynamic> colorCode = [];
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodeShipping = FocusNode();
  FocusNode myFocusNodeConsumer = FocusNode();
  FocusNode myFocusNodeWhole = FocusNode();
  CategoryModel? subcat;
  String? dropdownvalue;
  late int value;
  late dynamic subvalue;
  late int brandvalue;
  List<bool> colorcheck = [false];
  List<bool> sizepicker = [false];
  late GetBrandModel brands;
  late List<String> colors;
  late List<String> size;
  String allowRequests = '0';

  bool getvalue = false;
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  String? subcategoryValue;

  String? brandname;
  String? dropcat;
  bool loader = false;
  final spinkit = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.white,
  );
  var items = [
    'Bag',
    'Shoes',
  ];
  late File file;
  bool showsub = false;
  // late int index;
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
  int loop = 0;
  addImages() {
    loop = productlistContent[widget.index].colors.length >
            productlistContent[widget.index].size.length
        ? productlistContent[widget.index].colors.length
        : productlistContent[widget.index].size.length >
                productlistContent[widget.index].colors.length
            ? productlistContent[widget.index].size.length
            : productlistContent[widget.index].colors.length;
    for (var model in catergorylist) {
      check++;
      print("hello");
      print(model.id);
      print(productlistContent[widget.index].categoryName);
      print(productlistContent[widget.index].subCategoryName);
      print(productlistContent[widget.index].categoryIds[0].id.toString());
      print(
          productlistContent[widget.index].categoryIds[0].position.toString());
      if (model.id.toString() ==
          productlistContent[widget.index].categoryIds[0].id.toString()) {
        print('in if');

        subcheck = check;
        setState(() {
          subcat = model;
          print(subcat!.name);
          showsub = true;
          value = subcat!.id;
          print(value);
        });
      }
    }
    setState(() {});
    imageditlist = [];
    for (var i = 0; i < productlistContent[widget.index].images.length; i++) {
      imageditlist.add(productlistContent[widget.index].images[i]);
    }
  }

  List<TextEditingController> priceController = [];
  List<TextEditingController> skuController = [];
  List<TextEditingController> quantityController = [];
  List<String> combination = [];

  newTextController() {
    skuController.clear();
    quantityController.clear();
    if (sizeVarient.isEmpty) {
      for (var i = 0; i < colorVarient.length; i++) {
        skuController.add(TextEditingController());

        quantityController.add(TextEditingController());
      }
    } else {
      for (var i = 0; i < sizeVarient.length * colorVarient.length; i++) {
        skuController.add(TextEditingController());

        quantityController.add(TextEditingController());
      }
    }
    print('controller');
    print(skuController.length);
    print(quantityController.length);
  }

  generateCombintaion() {
    int count = 0;
    print(colorVarient);
    print(colorCode);
    print(sizeVarient);
    combination = [];
    if (sizeVarient.isEmpty) {
      for (var i = 0; i < colorVarient.length; i++) {
        print('combintaion');
        combination.add(colorVarient[i]);
        count++;
      }
    } else {
      for (var i = 0; i < colorVarient.length; i++) {
        for (var j = 0; j < sizeVarient.length; j++) {
          combination.add(colorVarient[i] + '-' + sizeVarient[j]);
          count++;
        }
      }
    }
    print(combination);
  }

  initialize() {
    if (productlistContent[widget.index].secret_payment == 1) {
      getvalue = true;
      allowRequests = '1';
    }
    for (var i = 0;
        i < productlistContent[widget.index].colorsList.length;
        i++) {
      colorVarient.add(productlistContent[widget.index].colorsList[i].name);
    }

    colorCode = productlistContent[widget.index].colors;
    sizeVarient = productlistContent[widget.index].size;
    subvalue = productlistContent[widget.index].categoryIds[1].id;
    brandvalue = productlistContent[widget.index].brandId;
  }

  genrateTextController() {
    if (sizeVarient.isEmpty) {
      for (var i = 0; i < colorVarient.length; i++) {
        skuController.add(TextEditingController());
        skuController[i].text =
            productlistContent[widget.index].variation[i].sku.toString();
        quantityController.add(TextEditingController());
        quantityController[i].text =
            productlistContent[widget.index].variation[i].qty.toString();
      }
    } else {
      for (var i = 0; i < sizeVarient.length * colorVarient.length; i++) {
        skuController.add(TextEditingController());
        skuController[i].text =
            productlistContent[widget.index].variation[i].sku.toString();
        quantityController.add(TextEditingController());
        quantityController[i].text =
            productlistContent[widget.index].variation[i].qty.toString();
      }
    }
  }

  @override
  void initState() {
    print('sadfsdf');
    print(widget.index);
    sizepicker.add(false);
    colorcheck.add(false);
    addImages();
    initialize();
    generateCombintaion();
    genrateTextController();
    generateVarient = true;
    myFocusNode.addListener(() {
      setState(() {});
    });
    myFocusNodeShipping.addListener(() {
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
    PurchasePriceController.text =
        productlistContent[widget.index].unitPrice.toString();
    WholesalePriceController.text =
        productlistContent[widget.index].wholesalePrice.toString();
    ShippingcostController.text =
        productlistContent[widget.index].shippingCost.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          Languages.of(context)!.EDIT_PRODUCT,
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              // Navigator.of(context).pop();
              // Get.offAll((navBar(index: 0, see: 1)));
              Get.off(navBar(index: 1, see: 0));
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
                  Languages.of(context)!.PRODUCT_DETAIL,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  Languages.of(context)!.ADD_IMAGES,
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            Languages.of(context)!.PRODUCT_NAME,
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      Text(
                        Languages.of(context)!.SUB_NAME,
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
                                hintText: Languages.of(context)!.PRODUCT_NAME,
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
                                hintText: Languages.of(context)!.SUB_NAME,
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            Languages.of(context)!.CATEGORY,
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      showsub == true
                          ? Text(
                              Languages.of(context)!.SUB_CATEGORY,
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
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: Colors.black12, width: 1.8)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration.collapsed(hintText: ''),

                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            icon: Icon(Icons.keyboard_arrow_down),
                            hint: Text(
                                productlistContent[widget.index].categoryName ==
                                        null
                                    ? Languages.of(context)!.CATEGORY
                                    : productlistContent[widget.index]
                                        .categoryName),
                            // value: dropdownvalue,
                            items: catergorylist.map((CategoryModel item) {
                              return DropdownMenuItem(
                                value: item.id.toString(),
                                child: Text(
                                  item.name,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                showsub = false;
                                print(newValue);
                                //dropdownvalue = newValue;
                                for (var model in catergorylist) {
                                  check++;
                                  print("hello");
                                  print(model.id);
                                  if (model.id.toString() ==
                                      newValue.toString()) {
                                    print('in if');

                                    subcheck = check;
                                    setState(() {
                                      subcat = model;
                                      print(subcat!.name);
                                      showsub = true;
                                      value = subcat!.id;
                                      print(value);
                                    });
                                  }
                                }
                                // subcat = newValue;
                                // print('category');
                                // print(subcat!.id);
                                // print(subcat!.name);
                                // value = subcat!.id;
                                // print(value);
                              });
                            },
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
                                    hint: Text(productlistContent[widget.index]
                                                .subCategoryName ==
                                            null
                                        ? Languages.of(context)!.SUB_CATEGORY
                                        : productlistContent[widget.index]
                                            .subCategoryName!),
                                    value: dropcat,
                                    items: subcat!.subCategories
                                        .map((CategoryModel item) {
                                      return DropdownMenuItem(
                                        value: item.name.toString(),
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      print('sdfasdfsadf');

                                      subcategoryValue = newValue;
                                      setState(() {
                                        dropcat = newValue!;

                                        /*   subcat = newValue as CategoryModel?;
                                        print('subcategory');
                                        subvalue = subcat!.id;
                                        print(subvalue);

                                        print(subvalue); */
                                      });
                                      for (var model in subcat!.subCategories) {
                                        if (model.name == newValue) {
                                          print(newValue);
                                          print(model.id);
                                          subvalue = model.id;
                                        }
                                      }
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            Languages.of(context)!.BRANDS,
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 6),
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black12, width: 1.8)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            // value: dropdownvalue4,
                            decoration: InputDecoration.collapsed(hintText: ''),
                            hint: Text(
                                productlistContent[widget.index].brandName),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey[600],
                            ),
                            items: brandlist.map((GetBrandModel items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Container(
                                  width: 100,
                                  child: Text(
                                    items.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
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
                    ],
                  ),
                ),
                for (int i = 0; i < loop; i++)
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.18,
                              child: Text(
                                Languages.of(context)!.SIZE,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          Text(
                            Languages.of(context)!.COLOR,
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
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: /*  sizepicker[i]
                                    ? Center(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return Languages.of(context)!.VALIDATOR;
                                            }
                                          },
                                          onTap: () {
                                            setState(() {
                                              sizepicker[i] = false;
                                            });
                                          },
                                          readOnly: true,
                                          controller: _textSizeController,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              hintText: productlistContent[
                                                      widget.index]
                                                  .variation[i]
                                                  .type
                                                  .toString()
                                                  .split('-')[0]),
                                        ),
                                      )
                                    : */
                                    DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == null) {
                                        return Languages.of(context)!.VALIDATOR;
                                      }
                                    },
                                    // value: dropdownvalue4,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        hintText: ''),
                                    hint: Text(
                                        sizeVarient.asMap().containsKey(i)
                                            ? sizeVarient[i]
                                            : Languages.of(context)!.SIZE),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.grey[600],
                                    ),
                                    items: sizeList.map((SizeModel items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: SizedBox(
                                          width: 30.w,
                                          child: Text(
                                            items.label,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        SizeModel getsize;
                                        getsize = newValue as SizeModel;
                                        if (getsize.label == 'Add More') {
                                          /*  _textSizeController
                                                    .add(TextEditingController()); */
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    Languages.of(context)!
                                                        .ADD_NEW_SIZE),
                                                content: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return Languages.of(
                                                              context)!
                                                          .VALIDATOR;
                                                    }
                                                  },
                                                  onChanged: (value) {},
                                                  controller:
                                                      _textSizeController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        productlistContent[
                                                                widget.index]
                                                            .variation[i]
                                                            .type
                                                            .toString()
                                                            .split('-')[1],
                                                  ),
                                                ),
                                                actions: [
                                                  FlatButton(
                                                    textColor: Colors.black,
                                                    onPressed: () async {
                                                      bool exist = false;
                                                      for (var model
                                                          in sizeList) {
                                                        if (model.label ==
                                                            _textSizeController
                                                                .text) {
                                                          exist = true;
                                                        }
                                                      }
                                                      if (exist) {
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType:
                                                              DialogType.INFO,
                                                          animType: AnimType
                                                              .BOTTOMSLIDE,
                                                          title: Languages.of(
                                                                  context)!
                                                              .MATCH_FOUND,
                                                          desc: Languages.of(
                                                                  context)!
                                                              .ALREADY_SIZE,
                                                          btnOkOnPress: () {},
                                                        ).show();
                                                      } else {
                                                        await DataApiService
                                                            .instance
                                                            .addSize(
                                                                _textSizeController
                                                                    .text,
                                                                context);

                                                        await DataApiService
                                                            .instance
                                                            .getsizelist();
                                                        setState(() {
                                                          sizepicker[i] = true;
                                                        });
                                                        sizeVarient.add(
                                                            _textSizeController
                                                                .text);
                                                        print(sizeVarient[i]);
                                                        generateVarient = false;
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                      }
                                                    },
                                                    child: Text(
                                                        Languages.of(context)!
                                                            .ADD),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                        bool alreadySize = false;
                                        for (var model in sizeVarient) {
                                          if (getsize.label == model) {
                                            alreadySize = true;
                                          }
                                        }
                                        if (alreadySize) {
                                        } else {
                                          if (getsize.label != 'Add More') {
                                            print(newValue);
                                            if (i + 1 > sizeVarient.length) {
                                              skuController.clear();
                                              quantityController.clear();
                                              sizeVarient.add(getsize.label);
                                              print(sizeVarient[i]);
                                            } else {
                                              sizeVarient[i] = getsize.label;
                                            }
                                            /*  sizeVarient.add(getsize.label);
                                                  print(sizeVarient[i]); */
                                            generateVarient = false;
                                          }
                                        }

                                        // dropdownvalue4 = newValue! as String?;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              i == 0
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _textSizeController.clear();
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      Languages.of(context)!
                                                          .ADD_NEW_SIZE),
                                                  content: TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return Languages.of(
                                                                context)!
                                                            .VALIDATOR;
                                                      }
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              "[a-zA-Z]")),
                                                    ],
                                                    onChanged: (value) {},
                                                    controller:
                                                        _textSizeController,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          Languages.of(context)!
                                                              .SIZE,
                                                    ),
                                                  ),
                                                  actions: [
                                                    FlatButton(
                                                      textColor: Colors.black,
                                                      onPressed: () async {
                                                        if (_textSizeController
                                                            .text.isNotEmpty) {
                                                          bool exist = false;
                                                          for (var model
                                                              in sizeList) {
                                                            if (model.label ==
                                                                _textSizeController
                                                                    .text) {
                                                              exist = true;
                                                            }
                                                          }
                                                          if (exist) {
                                                            AwesomeDialog(
                                                              context: context,
                                                              dialogType:
                                                                  DialogType
                                                                      .INFO,
                                                              animType: AnimType
                                                                  .BOTTOMSLIDE,
                                                              title: Languages.of(
                                                                      context)!
                                                                  .MATCH_FOUND,
                                                              desc: Languages.of(
                                                                      context)!
                                                                  .ALREADY_SIZE,
                                                              btnOkOnPress:
                                                                  () {},
                                                            ).show();
                                                          } else {
                                                            print(
                                                                'asfgsdagsfdg');
                                                            print(
                                                                _textSizeController
                                                                    .text);
                                                            await DataApiService
                                                                .instance
                                                                .addSize(
                                                                    _textSizeController
                                                                        .text,
                                                                    context);

                                                            /*  await DataApiService
                                                                .instance
                                                                
                                                                .getsizelist(); */
                                                            setState(() {
                                                              sizeList.insert(
                                                                  0,
                                                                  SizeModel(
                                                                      label: _textSizeController
                                                                          .text));
                                                            });

                                                            /* setState(() {
                                                              sizepicker[i] =
                                                                  true;
                                                            }); */
                                                            /*   sizeVarient.add(
                                                                _textSizeController
                                                                    .text); */

                                                            /*    print(
                                                                sizeVarient[i]); */
                                                            generateVarient =
                                                                false;
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                          }
                                                        }
                                                      },
                                                      child: Text(
                                                          Languages.of(context)!
                                                              .ADD),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 5),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.black),
                                            child: Text(
                                                Languages.of(context)!
                                                    .ADD_NEW_SIZE,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      /*  padding:
                                          EdgeInsets.only(left: 10, right: 10, top: 6), */
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: /*  colorcheck[i]
                                          ? TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return Languages.of(context)!.VALIDATOR;
                                                }
                                              },
                                              onTap: () {
                                                setState(() {
                                                  colorcheck[i] = false;
                                                });
                                              },
                                              readOnly: true,
                                              controller: _textColorController,
                                            )
                                          :  */
                                          DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField(
                                          validator: (value) {
                                            if (value == null) {
                                              return Languages.of(context)!
                                                  .VALIDATOR;
                                            }
                                          },
                                          // value: dropdownvalue4,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              hintText: ''),
                                          hint: Text(colorVarient
                                                  .asMap()
                                                  .containsKey(i)
                                              ? colorVarient[i]
                                              : 'Color'),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey[600],
                                          ),
                                          items: colorList
                                              .map((ColorsModel items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: SizedBox(
                                                width: 30.w,
                                                child: Text(
                                                  items.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            setState(() {
                                              print(newValue);
                                              generateVarient = false;
                                              ColorsModel getcolor;
                                              getcolor =
                                                  newValue as ColorsModel;
                                              if (getcolor.name == 'Add More') {
                                                /*  _textColorController
                                                          .add(TextEditingController()); */
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                            Languages.of(
                                                                    context)!
                                                                .PICK_COLOR),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              ColorPicker(
                                                                pickerColor:
                                                                    pickerColor,
                                                                onColorChanged:
                                                                    changeColor,
                                                              ),
                                                              TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return Languages.of(
                                                                            context)!
                                                                        .VALIDATOR;
                                                                  }
                                                                },
                                                                onChanged:
                                                                    (value) {},
                                                                controller:
                                                                    _textColorController,
                                                                decoration: InputDecoration(
                                                                    hintText: Languages.of(
                                                                            context)!
                                                                        .COLOR_NAME),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          ElevatedButton(
                                                              child: Text(
                                                                  Languages.of(
                                                                          context)!
                                                                      .ADD),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  currentColor =
                                                                      pickerColor;
                                                                  colorsSelectedIndex
                                                                      .add(i);
                                                                });

                                                                String selectedColor = '#' +
                                                                    currentColor
                                                                        .toString()
                                                                        .substring(
                                                                            10,
                                                                            16);
                                                                bool exist =
                                                                    false;
                                                                for (var model
                                                                    in colorList) {
                                                                  if (selectedColor ==
                                                                      model
                                                                          .code) {
                                                                    exist =
                                                                        true;
                                                                  }
                                                                }
                                                                if (exist) {
                                                                  AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    dialogType:
                                                                        DialogType
                                                                            .INFO,
                                                                    animType:
                                                                        AnimType
                                                                            .BOTTOMSLIDE,
                                                                    title: Languages.of(
                                                                            context)!
                                                                        .MATCH_FOUND,
                                                                    desc: Languages.of(
                                                                            context)!
                                                                        .ALREADY_COLOR,
                                                                    btnOkOnPress:
                                                                        () {},
                                                                  ).show();
                                                                } else {
                                                                  print(
                                                                      currentColor);

                                                                  print('#' +
                                                                      currentColor
                                                                          .toString()
                                                                          .substring(
                                                                              10,
                                                                              16));

                                                                  Map<String,
                                                                          dynamic>
                                                                      addcolor =
                                                                      {
                                                                    'code':
                                                                        selectedColor,
                                                                    'name':
                                                                        _textColorController
                                                                            .text,
                                                                  };
                                                                  await DataApiService
                                                                      .instance
                                                                      .addColor(
                                                                          addcolor,
                                                                          context);
                                                                  setState(() {
                                                                    colorcheck[
                                                                            i] =
                                                                        true;
                                                                  });

                                                                  colorVarient.add(
                                                                      _textColorController
                                                                          .text);
                                                                  colorCode.add(
                                                                      selectedColor);
                                                                  colorList.insert(
                                                                      1,
                                                                      ColorsModel(
                                                                          id:
                                                                              5196,
                                                                          name: _textColorController
                                                                              .text,
                                                                          code:
                                                                              selectedColor.toString()));

                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              }),
                                                        ],
                                                      );
                                                    });
                                              }
                                              if (i + 1 > colorVarient.length) {
                                                skuController.clear();
                                                quantityController.clear();
                                                colorVarient.add(getcolor.name);
                                                colorCode.add(getcolor.code);
                                                print(colorVarient[i]);
                                                print(colorCode);
                                              } else {
                                                colorVarient[i] = getcolor.name;
                                                colorCode[i] = getcolor.code;
                                              }
                                              // dropdownvalue4 = newValue! as String?;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                i == 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _textColorController.clear();
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          Languages.of(context)!
                                                              .PICK_COLOR),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            ColorPicker(
                                                              pickerColor:
                                                                  pickerColor,
                                                              onColorChanged:
                                                                  changeColor,
                                                            ),
                                                            TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return Languages.of(
                                                                            context)!
                                                                        .VALIDATOR;
                                                                  }
                                                                },
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          "[a-zA-Z]")),
                                                                ],
                                                                onChanged:
                                                                    (value) {},
                                                                controller:
                                                                    _textColorController,
                                                                decoration: InputDecoration(
                                                                    hintText: Languages.of(
                                                                            context)!
                                                                        .COLOR_NAME)),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        SizedBox(
                                                          width: 100,
                                                          child: ElevatedButton(
                                                            child: Text(
                                                                Languages.of(
                                                                        context)!
                                                                    .ADD),
                                                            onPressed:
                                                                () async {
                                                              if (_textColorController
                                                                  .text
                                                                  .isNotEmpty) {
                                                                setState(() {
                                                                  currentColor =
                                                                      pickerColor;
                                                                  /*   colorsSelectedIndex
                                                                      .add(i); */
                                                                  /*  loaderColor =
                                                                        true; */
                                                                });
                                                                String selectedColor = '#' +
                                                                    currentColor
                                                                        .toString()
                                                                        .substring(
                                                                            10,
                                                                            16);
                                                                bool exist =
                                                                    false;
                                                                for (var model
                                                                    in colorList) {
                                                                  if (selectedColor ==
                                                                      model
                                                                          .code) {
                                                                    exist =
                                                                        true;
                                                                  }
                                                                }
                                                                if (exist) {
                                                                  /*  loaderColor =
                                                                        false; */
                                                                  AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    dialogType:
                                                                        DialogType
                                                                            .INFO,
                                                                    animType:
                                                                        AnimType
                                                                            .BOTTOMSLIDE,
                                                                    title: Languages.of(
                                                                            context)!
                                                                        .MATCH_FOUND,
                                                                    desc: Languages.of(
                                                                            context)!
                                                                        .ALREADY_COLOR,
                                                                    btnOkOnPress:
                                                                        () {},
                                                                  ).show();
                                                                } else {
                                                                  print(
                                                                      currentColor);

                                                                  print('#' +
                                                                      currentColor
                                                                          .toString()
                                                                          .substring(
                                                                              10,
                                                                              16));

                                                                  Map<String,
                                                                          dynamic>
                                                                      addcolor =
                                                                      {
                                                                    'code':
                                                                        selectedColor,
                                                                    'name':
                                                                        _textColorController
                                                                            .text,
                                                                  };
                                                                  await DataApiService
                                                                      .instance
                                                                      .addColor(
                                                                          addcolor,
                                                                          context);
                                                                  /*    setState(() {
                                                                    colorcheck[
                                                                            i] =
                                                                        true;
                                                                  }); */

                                                                  /*   colorVarient.add(
                                                                      _textColorController
                                                                          .text);
                                                                  colorCode.add(
                                                                      selectedColor); */
                                                                  setState(() {
                                                                    colorList.insert(
                                                                        0,
                                                                        ColorsModel(
                                                                            id:
                                                                                5196,
                                                                            name:
                                                                                _textColorController.text,
                                                                            code: selectedColor.toString()));
                                                                  });

                                                                  /*   setState(
                                                                        () {
                                                                      loaderColor =
                                                                          false;
                                                                    }); */

                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                }
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 10, bottom: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.black),
                                              child: Text(
                                                  Languages.of(context)!
                                                      .ADD_MORE_COLOR,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    /*   (colorVarient.length < 2 && sizeVarient.length < 2) ||
                            colorVarient.isEmpty */
                    colorVarient.length > 0 || sizeVarient.length > 0
                        ? InkWell(
                            onTap: () async {
                              await newTextController();
                              await generateCombintaion();
                              print(combination);
                              if (combination.isEmpty) {
                                GlobalSnackBar.show(
                                    context, Languages.of(context)!.ADD_CLR_SZ);
                              }
                              setState(() {
                                generateVarient = true;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 5.h,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /* Icon(
                                  Icons.arrow_downward,
                                  size: 30,
                                  color: Colors.white,
                                ), */
                                      Text(
                                        Languages.of(context)!
                                            .GENERATE_VARIANTS,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          loop++;
                          combination.clear();
                          generateVarient = false;

                          /*   priceController.add(TextEditingController());
                          skuController.add(TextEditingController());
                          quantityController.add(TextEditingController()); */
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 5.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.white,
                              ),
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (loop > 1) {
                            --loop;
                            combination.clear();
                            generateVarient = false;
                            /*    priceController.removeLast();
                          skuController.removeLast();
                          quantityController.removeLast(); */
                            /*  sizeVarient.removeLast();
                          colorVarient.removeLast();
                          colorCode.removeLast(); */

                            if (colorVarient.length == sizeVarient.length &&
                                colorVarient.isNotEmpty &&
                                sizeVarient.isNotEmpty) {
                              colorVarient.removeLast();
                              colorCode.removeLast();
                              sizeVarient.removeLast();
                            } else if (colorVarient.length >
                                sizeVarient.length) {
                              colorVarient.removeLast();
                              colorCode.removeLast();
                            } else if (sizeVarient.length >
                                colorVarient.length) {
                              sizeVarient.removeLast();
                            }
                            print('in icon');
                            print(colorVarient);
                            print(colorCode);
                            print(sizeVarient);
                            print(combination);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Container(
                            alignment: Alignment.center,
                            height: 5.h,
                            width: 10.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.black),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.remove,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                sizeVarient.isEmpty ? emptySizeVaiants() : sizeColorVariant(),
                /*   for (int i = 0;
                    i < sizeVarient.length * colorVarient.length;
                    i++)
                  generateVarient
                      ? Column(
                          children: [
                            Text(combination[i]),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.18,
                                      child: Text(
                                        'SKU',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Text(
                                    'Quantity',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
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
                                      /*  padding:
                                          EdgeInsets.only(left: 10, right: 10), */
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return Languages.of(context)!.VALIDATOR;
                                          }
                                        },
                                        controller: skuController[i],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'SKU',
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10.0),
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                        maxLines: 1,
                                      )),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 0, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            /* padding: EdgeInsets.only(
                                                left: 10, right: 10), */
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return Languages.of(context)!.VALIDATOR;
                                                }
                                              },
                                              controller: quantityController[i],
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'Quantity',
                                                filled: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 10.0),
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6)),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                              ),
                                              maxLines: 1,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /*  Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.18,
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ), */
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Divider(),
                            ),
                          ],
                        )
                      : SizedBox(), */
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            Languages.of(context)!.SHIPPING_COST,
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
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
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black12, width: 1.8)),
                        child: TextField(
                          onTap: () {
                            Shipping_Cost = ShippingcostController.text;
                          },
                          controller: ShippingcostController,
                          keyboardType: TextInputType.number,
                          focusNode: myFocusNodeShipping,
                          decoration: InputDecoration(
                              suffix: Text(
                                  '€' /*  + categorycostlist[0].cost.toString() */),
                              hintText:
                                  myFocusNodeShipping.hasFocus ? '' : '0.00 €',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            Languages.of(context)!.WHOLESALE_PRICE,
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          )),
                      Text(
                        Languages.of(context)!.CONSUMER_PRICE,
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Languages.of(context)!.VALIDATOR;
                              }
                            },
                            onTap: () {},
                            controller: WholesalePriceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabled: true,
                              suffix: Text('€'),
                              hintText:
                                  myFocusNodeWhole.hasFocus ? '' : '0.00 €',
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(6)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(6)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            maxLines: 1,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Languages.of(context)!.VALIDATOR;
                                }
                              },
                              onTap: () {},
                              controller: PurchasePriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabled: true,
                                suffix: Text('€'),
                                hintText:
                                    myFocusNodeWhole.hasFocus ? '' : '0.00 €',
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 10.0),
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              maxLines: 1,
                            )),
                      )
                    ],
                  ),
                ),
                _isCancelable(),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.18,
                          child: Text(
                            Languages.of(context)!.DESCRIPTION,
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
                            hintText: Languages.of(context)!.DESC_HINT),
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
                      if (loader == false) {
                        if (generateVarient == false) {
                          GlobalSnackBar.show(
                              context, Languages.of(context)!.VARIENT_MSG);
                        } else {
                          setState(() {
                            loader = true;
                            colors = ColorController.text.split(',');
                            size = SizeController.text.split(',');
                          });
                          if (images.isNotEmpty) {
                            if (sizeVarient.isEmpty) {
                              emptySizeMultiple();
                            } else {
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
                                'category_id': value.toString(),
                                'sub_category_id': subvalue.toString(),
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
                                'wholesale_price':
                                    WholesalePriceController.text,
                                'colors_active': 'true',
                                'size_active': 'true',
                                'colors': colorCode.join(','),
                                'size': sizeVarient.join(','),
                                'secret_payment': allowRequests.toString(),
                                '_method': 'PUT',
                                for (int i = 0; i < combination.length; i++)
                                  'price_${combination[i]}':
                                      PurchasePriceController.text,
                                for (int i = 0; i < combination.length; i++)
                                  'qty_${combination[i]}':
                                      quantityController[i].text,
                                for (int i = 0; i < combination.length; i++)
                                  'sku_${combination[i]}':
                                      skuController[i].text,
                              };
                              print(updateProductMap);

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
                                title: Languages.of(context)!.SUCCESS,
                                desc: Languages.of(context)!.UPDATE_SUCCESS,
                                btnOkOnPress: () {
                                  Get.off(() => navBar(index: 1, see: 0));
                                },
                              ).show();
                            }
                          } else if (productlistContent[widget.index]
                                  .images
                                  .isNotEmpty &&
                              images.isNotEmpty) {
                            if (sizeVarient.isEmpty) {
                              emptySizeMultiple2();
                            } else {
                              Map<String, dynamic> updateProductMap = {
                                'name': NameController.text,
                                'sub_name': SubnameController.text,
                                'category_id': value.toString(),
                                'sub_category_id': subvalue.toString(),
                                'brand_id': brandvalue.toString(),
                                'unit': 'pc',
                                for (int i = 0;
                                    i <
                                        productlistContent[widget.index]
                                            .images
                                            .length;
                                    i++)
                                  'images[]': productlistContent[widget.index]
                                      .images[i],
                                for (int i = 0; i < imageditlist.length; i++)
                                  'images[]': imageditlist[i],
                                'thumbnail':
                                    productlistContent[widget.index].thumbnail,
                                'discount_type': 'percent',
                                'tax': '10',
                                'lang[]': 'en',
                                'unit_price': PurchasePriceController.text,
                                'purchase_price': PurchasePriceController.text,
                                'discount': '20',
                                'shipping_cost': ShippingcostController.text,
                                'description': DescriptionController.text,
                                'price_type': 'wholesale',
                                'wholesale_price':
                                    WholesalePriceController.text,
                                'colors_active': 'true',
                                'size_active': 'true',
                                'colors': colorCode.join(','),
                                'size': sizeVarient.join(','),
                                'secret_payment': allowRequests.toString(),
                                '_method': 'PUT',
                                for (int i = 0; i < combination.length; i++)
                                  'price_${combination[i]}':
                                      PurchasePriceController.text,
                                for (int i = 0; i < combination.length; i++)
                                  'qty_${combination[i]}':
                                      quantityController[i].text,
                                for (int i = 0; i < combination.length; i++)
                                  'sku_${combination[i]}':
                                      skuController[i].text,
                              };
                              print(updateProductMap);
                              print(colorCode);

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
                                title: Languages.of(context)!.SUCCESS,
                                desc: Languages.of(context)!.UPDATE_SUCCESS,
                                btnOkOnPress: () {
                                  Get.off(() => navBar(index: 1, see: 0));
                                },
                              ).show();
                            }
                          } else {
                            if (sizeVarient.isEmpty) {
                              emptySizeMultple3();
                            } else {
                              Map<String, dynamic> updateProductMap = {
                                'name': NameController.text,
                                'sub_name': SubnameController.text,
                                'category_id': value.toString(),
                                'sub_category_id': subvalue.toString(),
                                'brand_id': brandvalue.toString(),
                                'unit': 'pc',
                                for (int i = 0;
                                    i <
                                        productlistContent[widget.index]
                                            .images
                                            .length;
                                    i++)
                                  'images[$i]': productlistContent[widget.index]
                                      .images[i],
                                'thumbnail':
                                    productlistContent[widget.index].thumbnail,
                                'discount_type': 'percent',
                                'tax': '10',
                                'lang[]': 'en',
                                'unit_price': PurchasePriceController.text,
                                'purchase_price': PurchasePriceController.text,
                                'discount': '20',
                                'shipping_cost': ShippingcostController.text,
                                'description': DescriptionController.text,
                                'price_type': 'wholesale',
                                'wholesale_price':
                                    WholesalePriceController.text,
                                'colors_active': 'true',
                                'size_active': 'true',
                                'colors': colorCode.join(','),
                                'size': sizeVarient.join(','),
                                'secret_payment': allowRequests.toString(),
                                '_method': 'PUT',
                                for (int i = 0; i < combination.length; i++)
                                  'price_${combination[i]}':
                                      PurchasePriceController.text,
                                for (int i = 0; i < combination.length; i++)
                                  'qty_${combination[i]}':
                                      quantityController[i].text,
                                for (int i = 0; i < combination.length; i++)
                                  'sku_${combination[i]}':
                                      skuController[i].text,
                              };
                              print(updateProductMap);
                              print(colorCode);

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
                                title: Languages.of(context)!.SUCCESS,
                                desc: Languages.of(context)!.UPDATE_SUCCESS,
                                btnOkOnPress: () {
                                  Get.off(() => navBar(index: 1, see: 0));
                                },
                              ).show();
                            }
                          }
                        }
                      }
                    },
                    child: loader
                        ? spinkit
                        : Text(
                            Languages.of(context)!.UPDATE,
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

  Widget emptySizeVaiants() {
    return Container(
        height: 120 * combination.length.toDouble(),
        child: generateVarient
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: colorVarient.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Text(combination[index]),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.18,
                                child: Text(
                                  Languages.of(context)!.SKU,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              Languages.of(context)!.QUANTITY,
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
                            SizedBox(
                                /*  padding:
                                              EdgeInsets.only(left: 10, right: 10), */
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return Languages.of(context)!.VALIDATOR;
                                    }
                                  },
                                  controller: skuController[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: Languages.of(context)!.SKU,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                  maxLines: 1,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 0, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      /* padding: EdgeInsets.only(
                                                    left: 10, right: 10), */
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return Languages.of(context)!
                                                .VALIDATOR;
                                          }
                                        },
                                        controller: quantityController[index],
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText:
                                              Languages.of(context)!.QUANTITY,
                                          filled: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10.0),
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                        ),
                                        maxLines: 1,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*  Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width /
                                              2.18,
                                          child: Text(
                                            'Quantity',
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ), */
                      const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Divider(),
                      ),
                    ],
                  );
                },
              )
            : SizedBox());
  }

  Widget sizeColorVariant() {
    return Container(
      height: 120 * combination.length.toDouble(),
      child: generateVarient
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: sizeVarient.length * colorVarient.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Text(combination[index]),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.18,
                              child: Text(
                                Languages.of(context)!.SKU,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          Text(
                            Languages.of(context)!.QUANTITY,
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
                          SizedBox(
                              /*  padding:
                                              EdgeInsets.only(left: 10, right: 10), */
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return Languages.of(context)!.VALIDATOR;
                                  }
                                },
                                controller: skuController[index],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: Languages.of(context)!.SKU,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 10.0),
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                maxLines: 1,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    /* padding: EdgeInsets.only(
                                                    left: 10, right: 10), */
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return Languages.of(context)!
                                              .VALIDATOR;
                                        }
                                      },
                                      controller: quantityController[index],
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText:
                                            Languages.of(context)!.QUANTITY,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 10.0),
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                      maxLines: 1,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*  Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width /
                                              2.18,
                                          child: Text(
                                            'Quantity',
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  ),
                                ), */
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Divider(),
                    ),
                  ],
                );
              },
            )
          : SizedBox(),
    );
  }

  emptySizeMultiple() async {
    String product = 'product';
    String thumbnail = 'thumbnail';
    await DataApiService.instance.updateProfileContent(images[0], thumbnail);
    for (int i = 0; i < images.length; i++) {
      Map<String, dynamic> upload = {
        'image': imagesfile[i],
        'type': 'product',
      };
      print('for');
      await DataApiService.instance.updateProfileContent(images[i], product);
      print('thumbnail=' + thumbnaiImage);
    }
    Map<String, dynamic> updateProductMap = {
      'name': NameController.text,
      'sub_name': SubnameController.text,
      'category_id': value.toString(),
      'sub_category_id': subvalue.toString(),
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
      'wholesale_price': WholesalePriceController.text,
      'colors_active': 'true',
      'size_active': 'false',
      'colors': colorCode.join(','),
      'secret_payment': allowRequests.toString(),
      '_method': 'PUT',
      for (int i = 0; i < combination.length; i++)
        'price_${combination[i]}': PurchasePriceController.text,
      for (int i = 0; i < combination.length; i++)
        'qty_${combination[i]}': quantityController[i].text,
      for (int i = 0; i < combination.length; i++)
        'sku_${combination[i]}': skuController[i].text,
    };
    print(updateProductMap);

    await DataApiService.instance.updateproducts(
        productlistContent[widget.index].id, updateProductMap, context);
    setState(() {
      loader = false;
    });
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: Languages.of(context)!.SUCCESS,
      desc: Languages.of(context)!.UPDATE_SUCCESS,
      btnOkOnPress: () {
        Get.off(() => navBar(index: 1, see: 0));
      },
    ).show();
  }

  emptySizeMultiple2() async {
    Map<String, dynamic> updateProductMap = {
      'name': NameController.text,
      'sub_name': SubnameController.text,
      'category_id': value.toString(),
      'sub_category_id': subvalue.toString(),
      'brand_id': brandvalue.toString(),
      'unit': 'pc',
      for (int i = 0; i < productlistContent[widget.index].images.length; i++)
        'images[]': productlistContent[widget.index].images[i],
      for (int i = 0; i < imageditlist.length; i++) 'images[]': imageditlist[i],
      'thumbnail': productlistContent[widget.index].thumbnail,
      'discount_type': 'percent',
      'tax': '10',
      'lang[]': 'en',
      'unit_price': PurchasePriceController.text,
      'purchase_price': PurchasePriceController.text,
      'discount': '20',
      'shipping_cost': ShippingcostController.text,
      'description': DescriptionController.text,
      'price_type': 'wholesale',
      'wholesale_price': WholesalePriceController.text,
      'colors_active': 'true',
      'size_active': 'false',
      'colors': colorCode.join(','),
      'secret_payment': allowRequests.toString(),
      '_method': 'PUT',
      for (int i = 0; i < combination.length; i++)
        'price_${combination[i]}': PurchasePriceController.text,
      for (int i = 0; i < combination.length; i++)
        'qty_${combination[i]}': quantityController[i].text,
      for (int i = 0; i < combination.length; i++)
        'sku_${combination[i]}': skuController[i].text,
    };
    print(updateProductMap);
    print(colorCode);

    await DataApiService.instance.updateproducts(
        productlistContent[widget.index].id, updateProductMap, context);
    setState(() {
      loader = false;
    });
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: Languages.of(context)!.SUCCESS,
      desc: Languages.of(context)!.UPDATE_SUCCESS,
      btnOkOnPress: () {
        Get.off(() => navBar(index: 1, see: 0));
      },
    ).show();
  }

  emptySizeMultple3() async {
    Map<String, dynamic> updateProductMap = {
      'name': NameController.text,
      'sub_name': SubnameController.text,
      'category_id': value.toString(),
      'sub_category_id': subvalue.toString(),
      'brand_id': brandvalue.toString(),
      'unit': 'pc',
      for (int i = 0; i < productlistContent[widget.index].images.length; i++)
        'images[$i]': productlistContent[widget.index].images[i],
      'thumbnail': productlistContent[widget.index].thumbnail,
      'discount_type': 'percent',
      'tax': '10',
      'lang[]': 'en',
      'unit_price': PurchasePriceController.text,
      'purchase_price': PurchasePriceController.text,
      'discount': '20',
      'shipping_cost': ShippingcostController.text,
      'description': DescriptionController.text,
      'price_type': 'wholesale',
      'wholesale_price': WholesalePriceController.text,
      'colors_active': 'true',
      'size_active': 'false',
      'secret_payment': allowRequests.toString(),
      'colors': colorCode.join(','),
      '_method': 'PUT',
      for (int i = 0; i < combination.length; i++)
        'price_${combination[i]}': PurchasePriceController.text,
      for (int i = 0; i < combination.length; i++)
        'qty_${combination[i]}': quantityController[i].text,
      for (int i = 0; i < combination.length; i++)
        'sku_${combination[i]}': skuController[i].text,
    };
    print(updateProductMap);
    print(colorCode);

    await DataApiService.instance.updateproducts(
        productlistContent[widget.index].id, updateProductMap, context);
    setState(() {
      loader = false;
    });
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: Languages.of(context)!.SUCCESS,
      desc: Languages.of(context)!.UPDATE_SUCCESS,
      btnOkOnPress: () {
        Get.off(() => navBar(index: 1, see: 0));
      },
    ).show();
  }

  _isCancelable() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 0,
        right: 15.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "Allow buy requests",
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Switch(
              onChanged: (value) {
                setState(
                  () {
                    getvalue = value;
                    if (value) {
                      allowRequests = '1';
                    } else {
                      allowRequests = '0';
                    }

                    print(allowRequests);
                  },
                );
              },
              value: getvalue)
        ],
      ),
    );
  }
}
