import 'dart:convert';
import 'dart:io';

import 'package:af24/Model/getColors.dart';
import 'package:af24/Model/getsizeModel.dart';
import 'package:af24/Screens/image_crop.dart';
import 'package:af24/api/urls.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'package:af24/Model/GetcategoriesModel.dart';
import 'package:af24/Model/getbrand.dart';
import 'package:af24/Screens/dashBoard.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';

import 'navBar.dart';
import 'newBar.dart';

class uploadProduct extends StatefulWidget {
  @override
  _uploadProductState createState() => _uploadProductState();
}

class _uploadProductState extends State<uploadProduct> {
  final NmaeController = TextEditingController();
  final BrandidController = TextEditingController();
  final ShippingcostController = TextEditingController();
  final PurchasePriceController = TextEditingController();
  final SubnameController = TextEditingController();
  final DescriptionController = TextEditingController();
  final ColorController = TextEditingController();
  final SizeController = TextEditingController();
  List<TextEditingController> _textFieldController = [];
  List<TextEditingController> _textColorController = [];
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  bool colorcheck = false;
  bool sizepicker = false;

  String allowRequests = '0';
  bool getvalue = false;
// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  XFile? _picked;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodeConsumer = FocusNode();
  FocusNode myFocusNodeWhole = FocusNode();
  CategoryModel? subcat;
  String? dropdownvalue;
  late int value;
  int subvalue = 0;
  late int brandvalue;
  late GetBrandModel brands;
  late List<String> colors;
  late List<String> size;
  String? dropcat;
  var items = [
    'Bag',
    'Shoes',
  ];
  int check = 0;
  int subcheck = 0;
  List<int> text = [1, 2, 3, 4];
  int loop = 0;
  late File file;
  bool showsub = false;
  late int index;
  String? dropdownvalue2;
  var items2 = ['Fancy Shoes', 'Tote Bags'];
  String? dropdownvalue3;
  var items3 = ['Wholesale price', 'Consumer price'];
  List<String> images = [];
  List<String> imagesfile = [];
  List<String> categoryItems = [];

  String? dropdownvalue4;
  var items4 = [
    'Stock',
    'Re-Stock',
  ];
  final spinkit = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.white,
  );

  bool generateVarient = false;
  getName() {
    for (var i = 0; i < catergorylist.length; i++) {
      categoryItems.add(catergorylist[i].name);
    }
  }

  /*  addsizefunc() async {
    await DataApiService.instance.addSize(_textFieldController.text, context);

    await DataApiService.instance.getsizelist();
  } */

  List<String> combination = [];

  genrateTextController() {
    for (var i = 0; i < sizeVarient.length * colorVarient.length; i++) {
      priceController.add(TextEditingController());
      skuController.add(TextEditingController());
      quantityController.add(TextEditingController());
    }
  }

  generateCombintaion() {
    int count = 0;
    for (var i = 0; i < colorVarient.length; i++) {
      for (var j = 0; j < sizeVarient.length; j++) {
        combination.add(colorVarient[i] + '-' + sizeVarient[j]);
        count++;
      }
    }
  }

  bool loader = false;
  List<TextEditingController> priceController = [];
  List<TextEditingController> skuController = [];
  List<TextEditingController> quantityController = [];
  List<String> sizeVarient = [];
  List<String> colorVarient = [];
  List<String> colorCode = [];

  @override
  void initState() {
    setState(() {});
    myFocusNode.addListener(() {
      setState(() {});
    });
    myFocusNodeConsumer.addListener(() {
      setState(() {});
    });
    myFocusNodeWhole.addListener(() {
      setState(() {});
    });

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
          'Product Upload',
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
                          for (int i = 0; i < myImages.length; i++)
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    /*  await selectFile();
                                    Map<String, dynamic> upload = {
                                      'image': file.toString(),
                                      'type': 'product',
                                    }; */
                                    await _uploadImage();
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
                                      child: myImages[i].isEmpty
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
                                              File(myImages[i]),
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
                                            /*  images.removeAt(i);
                                            imagesfile.removeAt(i); */
                                            myImages.removeAt(i);
                                          });

                                          print("helooooooooooooo");
                                        },
                                        child: Icon(Icons.close)))
                              ],
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () async {
                              /*   await selectFile();
                              Map<String, dynamic> upload = {
                                'image': file.toString(),
                                'type': 'product',
                              }; */
                              await _uploadImage();
                              /*  Get.to(imageCrop()); */
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
                          )
                        ],
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
                              setState(() {
                                ProductName = NmaeController.text;
                              });
                            },
                            controller: NmaeController,
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
                      /* Container(
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
                      ), */
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
                            hint: Text('Category'),
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
                                    hint: Text('Sub Category'),
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
                                      setState(() {
                                        dropcat = newValue!;

                                        /*   subcat = newValue as CategoryModel?;
                                        print('subcategory');
                                        subvalue = subcat!.id;
                                        print(subvalue);

                                        print(subvalue); */
                                      });
                                      for (var i = 0;
                                          i <
                                              catergorylist[subcheck]
                                                  .subCategories
                                                  .length;
                                          i++) {
                                        if (catergorylist[subcheck]
                                                .subCategories[i]
                                                .name ==
                                            newValue) {
                                          print('in if');
                                          print(catergorylist[subcheck]
                                              .subCategories[i]
                                              .name);
                                          print(catergorylist[subcheck]
                                              .subCategories[i]
                                              .id);
                                          subvalue = catergorylist[subcheck]
                                              .subCategories[i]
                                              .id;
                                        }
                                      }
                                    },
                                  ),
                                  /*  DropdownButtonFormField(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    hint: Text('subCategory'),
                                    // value: dropdownvalue,
                                    items: subcat!.subCategories
                                        .map((CategoryModel item) {
                                      return DropdownMenuItem(
                                        value: item.id.toString(),
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                      
                                        print(newValue);
                                        //dropdownvalue = newValue;
                                        for (var model in catergorylist) {
                                          print("hello");
                                          print(model.id);
                                          if (model.id.toString() ==
                                              newValue.toString()) {
                                            print('in if');
                                            setState(() {
                                              /*  subcat = model;
                                         print(subcat!.name); */
                                              subvalue = model.id;
                                              print(model.name);
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
                                  ), */
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
                    ],
                  ),
                ),
                for (int i = 0; i < loop; i++)
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2.18,
                              child: Text(
                                'Size',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
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
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 6),
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black12, width: 1.8)),
                            child: sizepicker
                                ? Center(
                                    child: TextField(
                                      onTap: () {
                                        setState(() {
                                          sizepicker = false;
                                        });
                                      },
                                      readOnly: true,
                                      controller: _textFieldController[i],
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none),
                                    ),
                                  )
                                : DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      // value: dropdownvalue4,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ''),
                                      hint: Text('Size'),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.grey[600],
                                      ),
                                      items: sizeList.map((SizeModel items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Container(
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
                                          if (getsize.label == 'add more') {
                                            _textFieldController
                                                .add(TextEditingController());
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Expanded(
                                                  child: AlertDialog(
                                                    title: Text('Add new size'),
                                                    content: TextField(
                                                      onChanged: (value) {},
                                                      controller:
                                                          _textFieldController[
                                                              index],
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Size",
                                                      ),
                                                    ),
                                                    actions: [
                                                      FlatButton(
                                                        textColor: Colors.black,
                                                        onPressed: () async {
                                                          await DataApiService
                                                              .instance
                                                              .addSize(
                                                                  _textFieldController[
                                                                          i]
                                                                      .text,
                                                                  context);

                                                          await DataApiService
                                                              .instance
                                                              .getsizelist();
                                                          setState(() {
                                                            sizepicker = true;
                                                          });
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .pop();
                                                        },
                                                        child: Text('ADD'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          print(newValue);

                                          sizeVarient.add(getsize.label);
                                          print(sizeVarient[i]);
                                          generateVarient = false;

                                          // dropdownvalue4 = newValue! as String?;
                                        });
                                      },
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 6),
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black12, width: 1.8)),
                              child: colorcheck
                                  ? TextField(
                                      onTap: () {
                                        setState(() {
                                          colorcheck = false;
                                        });
                                      },
                                      readOnly: true,
                                      controller: _textColorController[i],
                                    )
                                  : DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                        // value: dropdownvalue4,
                                        decoration: InputDecoration.collapsed(
                                            hintText: ''),
                                        hint: Text('Color'),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.grey[600],
                                        ),
                                        items:
                                            colorList.map((ColorsModel items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Container(
                                              width: 30.w,
                                              child: Text(
                                                items.name,
                                                overflow: TextOverflow.ellipsis,
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
                                            getcolor = newValue as ColorsModel;
                                            if (getcolor.name == 'add more') {
                                              _textColorController
                                                  .add(TextEditingController());
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          'Pick a color!'),
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
                                                            TextField(
                                                              onChanged:
                                                                  (value) {},
                                                              controller:
                                                                  _textColorController[
                                                                      i],
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText:
                                                                          "Color Name"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                          child: const Text(
                                                              'Got it'),
                                                          onPressed: () async {
                                                            setState(() =>
                                                                currentColor =
                                                                    pickerColor);

                                                            print(currentColor);
                                                            Map<String, dynamic>
                                                                addcolor = {
                                                              'code': currentColor
                                                                  .toString(),
                                                              'name':
                                                                  _textColorController[
                                                                          i]
                                                                      .text,
                                                            };
                                                            await DataApiService
                                                                .instance
                                                                .addColor(
                                                                    addcolor,
                                                                    context);
                                                            setState(() {
                                                              colorcheck = true;
                                                            });

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            }
                                            colorVarient.add(getcolor.name);
                                            colorCode.add(getcolor.code);

                                            print(colorVarient[i]);
                                            print(colorCode[i]);
                                            // dropdownvalue4 = newValue! as String?;
                                          });
                                        },
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2.18,
                              child: Text(
                                'SKU',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          Text(
                            'Price',
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
                                controller: skuController[i],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'SKU',
                                    enabledBorder: InputBorder.none),
                                maxLines: 1,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
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
                                  /*  onTap: () {
                                    Shipping_Cost = ShippingcostController.text;
                                  }, */
                                  controller: priceController[i],
                                  keyboardType: TextInputType.number,
                                  // focusNode: myFocusNode,
                                  decoration: InputDecoration(
                                      prefix: Text(
                                          '' /*  + categorycostlist[0].cost.toString() */),
                                      hintText: '\$ 0.00',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      /*   hintText:
                                    '\$ ' + categorycostlist[0].cost.toString(), */
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none),
                                  maxLines: 1,
                                )),
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
                                'Quantity',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
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
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black12, width: 1.8)),
                              child: TextField(
                                controller: quantityController[i],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: 'Quantity',
                                    enabledBorder: InputBorder.none),
                                maxLines: 1,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Divider(),
                    ), */
                  ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          loop++;
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
                          loop--;
                          generateVarient = false;
                          /*    priceController.removeLast();
                          skuController.removeLast();
                          quantityController.removeLast(); */
                          /*  sizeVarient.removeLast();
                          colorVarient.removeLast();
                          colorCode.removeLast(); */
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
                    InkWell(
                      onTap: () async {
                        await genrateTextController();
                        await generateCombintaion();
                        setState(() {
                          generateVarient = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13),
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
                                  'Generate Varients',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                for (int i = 0;
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
                                    'Price',
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
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      width: MediaQuery.of(context).size.width /
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
                                        controller: skuController[i],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'SKU',
                                            enabledBorder: InputBorder.none),
                                        maxLines: 1,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                          /*  onTap: () {
                                    Shipping_Cost = ShippingcostController.text;
                                  }, */
                                          controller: priceController[i],
                                          keyboardType: TextInputType.number,
                                          // focusNode: myFocusNode,
                                          decoration: InputDecoration(
                                              prefix: Text(
                                                  '' /*  + categorycostlist[0].cost.toString() */),
                                              hintText: '\$ 0.00',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              /*   hintText:
                                    '\$ ' + categorycostlist[0].cost.toString(), */
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none),
                                          maxLines: 1,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
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
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      width: MediaQuery.of(context).size.width /
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
                                        controller: quantityController[i],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: 'Quantity',
                                            enabledBorder: InputBorder.none),
                                        maxLines: 1,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Divider(),
                            ),
                          ],
                        )
                      : SizedBox(),
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
                _isCancelable(),
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
                        imaglist = [];
                      });
                      print(colorCode);
                      setState(() {
                        colors = ColorController.text.split(',');
                        size = SizeController.text.split(',');
                      });
                      String product = 'product';
                      String thumbnail = 'thumbnail';
                      await DataApiService.instance
                          .updateProfileContent(myImages[0], thumbnail);
                      for (int i = 0; i < myImages.length; i++) {
                        Map<String, dynamic> upload = {
                          'image': myImages[i],
                          'type': 'product',
                        };
                        print('for');
                        await DataApiService.instance
                            .updateProfileContent(myImages[i], product);
                      }
                      Map<String, dynamic> upload = {
                        'image': myImages[0],
                        'type': 'product',
                      };

                      Map<String, dynamic> addproductmap = {
                        /*  'name': NmaeController.text,
                        'sub_name': SubnameController.text,
                        'category_id': subvalue.toString(),
                        'brand_id': brandvalue.toString(),
                        'unit': 'pc',
                        for (int i = 0; i < imaglist.length; i++)
                          'images[$i]': imaglist[i],
                        'thumbnail': thumbnaiImage,
                        'tax': '10',
                        'lang[]': 'en',
                        'unit_price': '60',
                        'shipping_cost': ShippingcostController.text,
                        'description': DescriptionController.text,
                        'price_type': 'wholesale',
                        for (int i = 0; i < colors.length; i++)
                          'colors': colors[i],
                        for (int i = 0; i < size.length; i++) 'size': size[i],
                        'size': 'l', */

                        //new
                        'name': NmaeController.text,
                        'sub_name': SubnameController.text,
                        'category_id': subvalue.toString(),
                        'brand_id': brandvalue.toString(),
                        'unit': 'pc',
                        for (int i = 0; i < imaglist.length; i++)
                          'images[$i]': imaglist[i],
                        'thumbnail': thumbnaiImage,
                        'tax': '10',
                        'lang[]': 'en',
                        'unit_price': '60',
                        'shipping_cost': ShippingcostController.text,
                        'description': DescriptionController.text,
                        'price_type': 'wholesale',
                        'colors_active': 'true',
                        'size_active': 'true',
                        'secret_payment': allowRequests.toString(),

                        //  'colors[]': colorCode,
                        /*  'colors': [
                          for (int i = 0; i < colorVarient.length; i++)
                            colorCode[i],
                        ],
                        'size':[
                            for (int i = 0; i < sizeVarient.length; i++)
                            jsonEncode(sizeVarient[i]),
                        ], */
                        'colors': colorCode.join(','),
                        'size': sizeVarient.join(','),
                        for (int i = 0; i < combination.length; i++)
                          'price_${combination[i]}': priceController[i].text,
                        for (int i = 0; i < combination.length; i++)
                          'qty_${combination[i]}': quantityController[i].text,
                        for (int i = 0; i < combination.length; i++)
                          'sku_${combination[i]}': skuController[i].text,

                        /*  for (int i = 0, countCv = 0;
                            i < priceController.length;
                            i++, countCv++)
                          'price_${colorVarient[countCv]}-${sizeVarient[countCv]}':
                              priceController[i].text,

                        for (int i = 0, countCv = 0;
                            i < quantityController.length;
                            i++, countCv++)
                          'qty_${colorVarient[countCv]}-${sizeVarient[countCv]}':
                              quantityController[i].text,

                        for (int i = 0, countCv = 0;
                            i < skuController.length;
                            i++, countCv++)
                          'sku_${colorVarient[countCv]}-${sizeVarient[countCv]}':
                              skuController[i].text, */
                      };
                      print(addproductmap);

                      await DataApiService.instance
                          .addProduct(addproductmap, context);
                      setState(() {
                        loader = false;
                      });
                      GlobalSnackBar.show(context, snackmessage);
                      /*  for (var i = 0; i < loop; i++) {
                        print('price_${colorVarient[i]}_${sizeVarient[i]}=' +
                            priceController[i].text);
                        print('qty_${colorVarient[i]}_${sizeVarient[i]}=' +
                            quantityController[i].text);
                        print('sku_${colorVarient[i]}_${sizeVarient[i]}=' +
                            skuController[i].text);
                      } */
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

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = pickedFile;
      setState(() {
        _picked = pickedFile;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => imageCrop()),
        );
      });
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    images.add(path);

    setState(() => file = File(path));
    imagesfile.add(file.toString());
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
