import 'dart:io';
import 'package:af24/Model/GetcategoriesModel.dart';
import 'package:af24/Model/getColors.dart';
import 'package:af24/Model/getbrand.dart';
import 'package:af24/Model/getsizeModel.dart';
import 'package:af24/Screens/image_crop.dart';
import 'package:af24/api/auth_af24.dart';
import 'package:af24/api/global_variable.dart';
import 'package:af24/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'navBar.dart';

class uploadProduct extends StatefulWidget {
  @override
  _uploadProductState createState() => _uploadProductState();
}

class _uploadProductState extends State<uploadProduct> {
  final NmaeController = TextEditingController();
  final BrandidController = TextEditingController();
  final ShippingcostController = TextEditingController();
  final PurchasePriceController = TextEditingController();
  final WholesalePriceController = TextEditingController();
  final SubnameController = TextEditingController();
  final DescriptionController = TextEditingController();
  final ColorController = TextEditingController();
  final SizeController = TextEditingController();
  final skucontro = TextEditingController();
  final quantitycontrol = TextEditingController();
  TextEditingController _textSizeController = TextEditingController();
  TextEditingController _textColorController = TextEditingController();
  // create some values
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  List<bool> colorcheck = [false];
  List<bool> sizepicker = [false];
  String? subcategoryValue;
  String allowRequests = '0';
  bool showGenerate = false;
  bool getvalue = false;
  final _formKey = GlobalKey<FormState>();
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
  List<int> colorsSelectedIndex = [];
  int subcheck = 0;
  int loop = 1;
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
    'Active',
    'In-Active',
  ];
  final spinkit = SpinKitSpinningLines(
    size: 3.h,
    color: Colors.white,
  );
  bool loaderColor = false;
  final spinkitColor = SpinKitSpinningLines(
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
    await DataApiService.instance.addSize(_textSizeController.text, context);

    await DataApiService.instance.getsizelist();
  } */

  List<String> combination = [];

  genrateTextController() {
    if (sizeVarient.isEmpty) {
      for (var i = 0; i < colorVarient.length; i++) {
        priceController.add(TextEditingController());
        skuController.add(TextEditingController());
        quantityController.add(TextEditingController());
      }
    } else {
      for (var i = 0; i < sizeVarient.length * colorVarient.length; i++) {
        priceController.add(TextEditingController());
        skuController.add(TextEditingController());
        quantityController.add(TextEditingController());
      }
    }
  }

  generateCombintaion() {
    int count = 0;
    print(colorVarient);
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
    /* _textSizeController.add(TextEditingController());
    _textColorController.add(TextEditingController()); */
    sizepicker.add(false);
    colorcheck.add(false);
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

  Future<dynamic> _onBackPressed() async {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Exit',
      desc: 'Are you sure you want to Exit?',
      btnCancelOnPress: () {},
      btnCancelText: 'No',
      btnOkText: 'Yes',
      btnOkOnPress: () async {
        SystemNavigator.pop();
      },
    ).show();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    images.clear();
    myImages.clear();
    imagesfile.clear();
    combination.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // loader = false;
    return WillPopScope(
      onWillPop: () async {
        bool? result = await _onBackPressed();
        if (result == null) {
          result = false;
        }
        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Upload Product',
            style: TextStyle(color: Colors.black),
          ),
          leading: InkWell(
              onTap: () {
                chatNavigate
                    ? Get.back()
                    : Get.offAll((navBar(index: 0, see: 1)));
                chatNavigate = false;
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey[200]),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 20, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Product Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Add Images',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
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
                                          borderRadius: const BorderRadius.all(
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
                                          child: const Icon(Icons.close)))
                                ],
                              ),
                            const SizedBox(
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
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
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        SizedBox(
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
                        SizedBox(
                            // alignment: Alignment.center,
                            // padding: EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width / 2.3,

                            // color: Colors.white,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                              },
                              onTap: () {
                                setState(() {
                                  ProductName = NmaeController.text;
                                });
                              },
                              controller: NmaeController,
                              decoration: InputDecoration(
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
                                hintText: 'Product Name',
                              ),
                              maxLines: 1,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            // padding: EdgeInsets.only(left: 10, right: 10),
                            width: MediaQuery.of(context).size.width / 2.3,

                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                              },
                              onTap: () {
                                setState(() {
                                  SubName = SubnameController.text;
                                });
                              },
                              controller: SubnameController,
                              decoration: InputDecoration(
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
                                hintText: 'Sub Name',
                              ),
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
                              'Category',
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            )),
                        showsub == true
                            ? Text(
                                'Sub Catgory',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.only(left: 10),
                          width: MediaQuery.of(context).size.width / 2.25,
                          alignment: Alignment.center,

                          child: Padding(
                            padding: const EdgeInsets.only(right: 3.0),
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return "This field is required";
                                }
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  hintText: ' Category'),

                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              hint: const Text('Category'),
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
                                DataApiService.instance
                                    .getCategoryList(context);
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
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
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
                                          hintText: 'Sub Category'),
                                      validator: (value) {
                                        if (value == null) {
                                          return "This field is required";
                                        }
                                      },
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(7)),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      // hint: Text('Sub Category'),
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
                                        for (var model
                                            in subcat!.subCategories) {
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
                            : const SizedBox()
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
                        SizedBox(
                          // padding: EdgeInsets.only(left: 10, right: 10, top: 6),
                          width: MediaQuery.of(context).size.width / 2.3,

                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return "This field is required";
                                }
                              },
                              // value: dropdownvalue4,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  hintText: 'Brands'),
                              hint: const Text('Brands'),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
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
                          child: SizedBox(
                            // padding: EdgeInsets.only(left: 10, right: 10, top: 6),
                            width: MediaQuery.of(context).size.width / 2.3,

                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return "This field is required";
                                  }
                                },
                                // value: dropdownvalue4,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                    hintText: 'Status'),
                                hint: const Text('Status'),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
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
                                onChanged: (newValue) {},
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
                            SizedBox(
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
                            Column(
                              children: [
                                SizedBox(
                                  /*   padding:
                                      EdgeInsets.only(left: 10, right: 10, top: 6), */
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: sizepicker[i]
                                      ? Center(
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "This field is required";
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
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6)),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                hintText: 'Size'),
                                          ),
                                        )
                                      : DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField(
                                            /*   validator: (value) {
                                              if (value == null) {
                                                return "This field is required";
                                              }
                                            }, */
                                            // value: dropdownvalue4,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6)),
                                                filled: true,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                hintText: 'Size'),
                                            hint: const Text('Size'),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(7)),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.grey[600],
                                            ),
                                            items:
                                                sizeList.map((SizeModel items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: SizedBox(
                                                  width: 30.w,
                                                  child: Text(
                                                    items.label,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                SizeModel getsize;
                                                getsize = newValue as SizeModel;
                                                /*    if (getsize.label == 'Add More') {
                                                  _textSizeController[i].clear();
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Add new size'),
                                                        content: TextFormField(
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return "This field is required";
                                                            }
                                                          },
                                                          onChanged: (value) {},
                                                          controller:
                                                              _textSizeController[
                                                                  i],
                                                          decoration:
                                                              const InputDecoration(
                                                            hintText: "Size",
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
                                                                    _textSizeController[
                                                                            i]
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
                                                                  title:
                                                                      'Match Found',
                                                                  desc:
                                                                      'Size Already Exist!',
                                                                  btnOkOnPress:
                                                                      () {},
                                                                ).show();
                                                              } else {
                                                                print(
                                                                    'asfgsdagsfdg');
                                                                print(
                                                                    _textSizeController[
                                                                            i]
                                                                        .text);
                                                                await DataApiService
                                                                    .instance
                                                                    .addSize(
                                                                        _textSizeController[
                                                                                i]
                                                                            .text,
                                                                        context);

                                                                /*  await DataApiService
                                                                    .instance
                                                                    .getsizelist(); */
                                                                sizeList.insert(
                                                                    1,
                                                                    SizeModel(
                                                                        label: _textSizeController[
                                                                                i]
                                                                            .text));
                                                                setState(() {
                                                                  sizepicker[i] =
                                                                      true;
                                                                });
                                                                sizeVarient.add(
                                                                    _textSizeController[
                                                                            i]
                                                                        .text);

                                                                print(
                                                                    sizeVarient[i]);
                                                                generateVarient =
                                                                    false;
                                                                Navigator.of(
                                                                        context,
                                                                        rootNavigator:
                                                                            true)
                                                                    .pop();
                                                              }
                                                            },
                                                            child:
                                                                const Text('ADD'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } */
                                                bool alreadySize = false;
                                                for (var model in sizeVarient) {
                                                  if (getsize.label == model) {
                                                    alreadySize = true;
                                                  }
                                                }
                                                if (alreadySize) {
                                                } else {
                                                  if (getsize.label !=
                                                      'Add More') {
                                                    print(newValue);
                                                    if (i + 1 >
                                                        sizeVarient.length) {
                                                      skuController.clear();
                                                      quantityController
                                                          .clear();
                                                      sizeVarient
                                                          .add(getsize.label);
                                                      print(sizeVarient[i]);
                                                    } else {
                                                      sizeVarient[i] =
                                                          getsize.label;
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
                                              _textSizeController.clear();
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Add new size'),
                                                    content: TextFormField(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "This field is required";
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
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText: "Size",
                                                      ),
                                                    ),
                                                    actions: [
                                                      FlatButton(
                                                        textColor: Colors.black,
                                                        onPressed: () async {
                                                          if (_textSizeController
                                                              .text
                                                              .isNotEmpty) {
                                                            bool exist = false;
                                                            for (var model
                                                                in sizeList) {
                                                              if (model.label ==
                                                                  _textSizeController
                                                                      .text) {
                                                                exist = true;
                                                              }
                                                            }
                                                            /*  if (exist) {
                                                              AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .INFO,
                                                                animType: AnimType
                                                                    .BOTTOMSLIDE,
                                                                title:
                                                                    'Match Found',
                                                                desc:
                                                                    'Size Already Exist!',
                                                                btnOkOnPress:
                                                                    () {},
                                                              ).show();
                                                            } else { */
                                                            print(
                                                                'asfgsdagsfdg');
                                                            print(
                                                                _textSizeController
                                                                    .text);
                                                            bool check =
                                                                await DataApiService
                                                                    .instance
                                                                    .addSize(
                                                                        _textSizeController
                                                                            .text,
                                                                        context);

                                                            /*  await DataApiService
                                                                .instance
                                                                .getsizelist(); */
                                                            if (check) {
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
                                                              /*   generateVarient =
                                                                  false; */
                                                              Navigator.of(
                                                                      context,
                                                                      rootNavigator:
                                                                          true)
                                                                  .pop();
                                                            } else {
                                                              AwesomeDialog(
                                                                context:
                                                                    context,
                                                                dialogType:
                                                                    DialogType
                                                                        .INFO,
                                                                animType: AnimType
                                                                    .BOTTOMSLIDE,
                                                                title:
                                                                    'Match Found',
                                                                desc:
                                                                    'Size Already Exist!',
                                                                btnOkOnPress:
                                                                    () {},
                                                              ).show();
                                                            }

                                                            /*  } */
                                                          }
                                                        },
                                                        child:
                                                            const Text('ADD'),
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
                                              child: Text('Add More Size',
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
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: colorcheck[i]
                                        ? Container(
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "This field is required";
                                                  }
                                                },
                                                onTap: () {
                                                  setState(() {
                                                    colorcheck[i] = false;
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none),
                                                readOnly: true,
                                                controller:
                                                    _textColorController),
                                          )
                                        : DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField(
                                              /*  validator: (value) {
                                                if (value == null) {
                                                  return "This field is required";
                                                }
                                              }, */
                                              // value: dropdownvalue4,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  hintText: ''),
                                              hint: const Text('Color'),
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                                          color:
                                                              Colors.grey[600]),
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
                                                  /*   if (getcolor.name == 'Add More') {
                                                    _textColorController[i].clear();
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
                                                                  TextFormField(
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "This field is required";
                                                                      }
                                                                    },
                                                                    onChanged:
                                                                        (value) {},
                                                                    controller:
                                                                        _textColorController[
                                                                            i],
                                                                    decoration:
                                                                        const InputDecoration(
                                                                            hintText:
                                                                                "Color Name"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              SizedBox(
                                                                width: 100,
                                                                child:
                                                                    ElevatedButton(
                                                                  child: loaderColor
                                                                      ? spinkitColor
                                                                      : Text('Add'),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(() {
                                                                      currentColor =
                                                                          pickerColor;
                                                                      colorsSelectedIndex
                                                                          .add(i);
                                                                      loaderColor =
                                                                          true;
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
                                                                      loaderColor =
                                                                          false;
                                                                      AwesomeDialog(
                                                                        context:
                                                                            context,
                                                                        dialogType:
                                                                            DialogType
                                                                                .INFO,
                                                                        animType:
                                                                            AnimType
                                                                                .BOTTOMSLIDE,
                                                                        title:
                                                                            'Match Found',
                                                                        desc:
                                                                            'Color Already Exist!',
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
                                                                            _textColorController[i]
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
                                                                          _textColorController[
                                                                                  i]
                                                                              .text);
                                                                      colorCode.add(
                                                                          selectedColor);
                                                                      colorList.insert(
                                                                          1,
                                                                          ColorsModel(
                                                                              id:
                                                                                  5196,
                                                                              name: _textColorController[i]
                                                                                  .text,
                                                                              code:
                                                                                  selectedColor.toString()));
                                                                      setState(() {
                                                                        loaderColor =
                                                                            false;
                                                                      });

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  } */
                                                  bool alreadyColor = false;
                                                  for (var model
                                                      in colorVarient) {
                                                    if (getcolor.name ==
                                                        model) {
                                                      alreadyColor = true;
                                                    }
                                                  }
                                                  if (alreadyColor) {
                                                  } else {
                                                    if (getcolor.name !=
                                                        'Add More') {
                                                      /*  colorVarient.add(getcolor.name);
                                                    colorCode.add(getcolor.code); */
                                                      if (i + 1 >
                                                          colorVarient.length) {
                                                        skuController.clear();
                                                        quantityController
                                                            .clear();
                                                        colorVarient
                                                            .add(getcolor.name);
                                                        colorCode
                                                            .add(getcolor.code);
                                                        // print(colorVarient[i]);
                                                        print(colorCode);
                                                      } else {
                                                        colorVarient[i] =
                                                            getcolor.name;
                                                        colorCode[i] =
                                                            getcolor.code;
                                                      }

                                                      print(colorVarient[i]);
                                                      print(colorCode[i]);
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
                                                              TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return "This field is required";
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
                                                                decoration:
                                                                    const InputDecoration(
                                                                        hintText:
                                                                            "Color Name"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          SizedBox(
                                                            width: 100,
                                                            child:
                                                                ElevatedButton(
                                                              child: loaderColor
                                                                  ? spinkitColor
                                                                  : Text('Add'),
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
                                                                    loaderColor =
                                                                        true;
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
                                                                  /*  if (exist) {
                                                                    loaderColor =
                                                                        false;
                                                                    AwesomeDialog(
                                                                      context:
                                                                          context,
                                                                      dialogType:
                                                                          DialogType
                                                                              .INFO,
                                                                      animType:
                                                                          AnimType
                                                                              .BOTTOMSLIDE,
                                                                      title:
                                                                          'Match Found',
                                                                      desc:
                                                                          'Color Already Exist!',
                                                                      btnOkOnPress:
                                                                          () {},
                                                                    ).show();
                                                                  } else { */
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
                                                                  bool check = await DataApiService
                                                                      .instance
                                                                      .addColor(
                                                                          addcolor,
                                                                          context);
                                                                  if (check) {
                                                                    setState(
                                                                        () {
                                                                      colorList.insert(
                                                                          0,
                                                                          ColorsModel(
                                                                              id: 5196,
                                                                              name: _textColorController.text,
                                                                              code: selectedColor.toString()));
                                                                    });

                                                                    setState(
                                                                        () {
                                                                      loaderColor =
                                                                          false;
                                                                    });

                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  } else {
                                                                    loaderColor =
                                                                        false;
                                                                    AwesomeDialog(
                                                                      context:
                                                                          context,
                                                                      dialogType:
                                                                          DialogType
                                                                              .INFO,
                                                                      animType:
                                                                          AnimType
                                                                              .BOTTOMSLIDE,
                                                                      title:
                                                                          'Match Found',
                                                                      desc:
                                                                          'Color Already Exist!',
                                                                      btnOkOnPress:
                                                                          () {},
                                                                    ).show();

                                                                    /*   } */
                                                                    /*    setState(() {
                                                                    colorcheck[
                                                                            i] =
                                                                        true;
                                                                  }); */

                                                                    /*  colorVarient.add(
                                                                        _textColorController
                                                                            .text);
                                                                    colorCode.add(
                                                                        selectedColor); */

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
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.black),
                                                child: Text('Add More Color',
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      /*   (colorVarient.length < 2 && sizeVarient.length < 2) ||
                              colorVarient.isEmpty */
                      colorVarient.length > 1 || sizeVarient.length > 1
                          ? InkWell(
                              onTap: () async {
                                await genrateTextController();
                                await generateCombintaion();
                                print(combination);
                                if (combination.isEmpty) {
                                  GlobalSnackBar.show(
                                      context, 'Please Add Color and Size');
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Generate Variants',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    )),
                              ),
                            )
                          : SizedBox(),
                      generateVarient
                          ? const SizedBox(
                              width: 13,
                            )
                          : SizedBox(
                              width: 2,
                            ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            loop++;
                            colorcheck.add(false);
                            sizepicker.add(false);
                            combination.clear();
                            /*  _textSizeController.add(TextEditingController());
                            _textColorController.add(TextEditingController()); */
                            print(loop);
                            generateVarient = false;
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
                                const Icon(
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
                              colorcheck.removeLast();
                              sizepicker.removeLast();
                              combination.clear();
                              /*   _textSizeController.removeLast();
                              _textColorController.removeLast(); */
                              generateVarient = false;
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
                                  const Icon(
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
                  const SizedBox(
                    height: 10,
                  ),
                  sizeVarient.isEmpty ? emptySizeVaiants() : sizeColorVariant(),
                  /*  
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
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                    SizedBox(
                                        /*  padding:
                                            EdgeInsets.only(left: 10, right: 10), */
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "This field is required";
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
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              /* padding: EdgeInsets.only(
                                                  left: 10, right: 10), */
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.3,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "This field is required";
                                                  }
                                                },
                                                controller:
                                                    quantityController[i],
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: 'Quantity',
                                                  filled: true,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 10.0),
                                                  fillColor: Colors.white,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
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
                              const Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Divider(),
                              ),
                            ],
                          )
                        : const SizedBox(), */
                  colorVarient.length < 2 && sizeVarient.length < 2
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                children: [
                                  SizedBox(
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
                                  SizedBox(
                                      /*  padding:
                                          EdgeInsets.only(left: 10, right: 10), */
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field is required";
                                          }
                                        },
                                        controller: skucontro,
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
                                        SizedBox(
                                            /*  padding: EdgeInsets.only(
                                                left: 10, right: 10), */
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "This field is required";
                                                }
                                              },
                                              controller: quantitycontrol,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
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
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Divider(),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        SizedBox(
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
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: TextFormField(
                              onTap: () {
                                Shipping_Cost = ShippingcostController.text;
                              },
                              controller: ShippingcostController,
                              keyboardType: TextInputType.number,
                              focusNode: myFocusNode,
                              decoration: InputDecoration(
                                suffix: const Text(
                                    '€' /*  + categorycostlist[0].cost.toString() */),
                                hintText: myFocusNode.hasFocus ? '' : '0.00 €',
                                hintStyle: const TextStyle(color: Colors.grey),
                                /*   hintText:
                                      '\$ ' + categorycostlist[0].cost.toString(), */
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
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This field is required";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Company',
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
                              'Wholesale Price',
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            )),
                        Text(
                          'Consumer Price',
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
                                  return "This field is required";
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
                                    return "This field is required";
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
                              'Description',
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.black12, width: 1.8)),
                      width: MediaQuery.of(context).size.width / 1.12,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: DescriptionController,
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter Description'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.12,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (loader == false) {
                            if (_formKey.currentState!.validate()) {
                              if (myImages.isEmpty) {
                                GlobalSnackBar.show(
                                    context, 'Please Upload Images');
                              } else {
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
                                    .updateProfileContent(
                                        myImages[0], thumbnail);
                                for (int i = 0; i < myImages.length; i++) {
                                  Map<String, dynamic> upload = {
                                    'image': myImages[i],
                                    'type': 'product',
                                  };
                                  print('for');
                                  await DataApiService.instance
                                      .updateProfileContent(
                                          myImages[i], product);
                                }
                                Map<String, dynamic> upload = {
                                  'image': myImages[0],
                                  'type': 'product',
                                };

                                var addproductmap;
                                if (combination.isNotEmpty &&
                                    sizeVarient.isNotEmpty &&
                                    colorVarient.isNotEmpty) {
                                  addproductmap = {
                                    //new
                                    'name': NmaeController.text,
                                    'sub_name': SubnameController.text,
                                    'category_id': value.toString(),
                                    'sub_category_id': subvalue.toString(),
                                    'brand_id': brandvalue.toString(),
                                    'unit': 'pc',
                                    for (int i = 0; i < imaglist.length; i++)
                                      'images[$i]': imaglist[i],
                                    'thumbnail': thumbnaiImage,
                                    'tax': '0',
                                    'lang[]': 'en',
                                    'unit_price': PurchasePriceController.text,
                                    'shipping_cost':
                                        ShippingcostController.text,
                                    'description': DescriptionController.text,
                                    'price_type': 'wholesale',
                                    'colors_active': 'true',
                                    'size_active': 'true',
                                    'wholesale_price':
                                        PurchasePriceController.text,
                                    'secret_payment': allowRequests.toString(),

                                    'colors': colorCode.join(','),
                                    'size': sizeVarient.join(','),

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
                                } else if (sizeVarient.isEmpty &&
                                    colorVarient.isNotEmpty) {
                                  if (colorVarient.length < 2) {
                                    addproductmap = {
                                      //new
                                      'name': NmaeController.text,
                                      'sub_name': SubnameController.text,
                                      'category_id': value.toString(),
                                      'sub_category_id': subvalue.toString(),

                                      'brand_id': brandvalue.toString(),
                                      'unit': 'pc',
                                      for (int i = 0; i < imaglist.length; i++)
                                        'images[$i]': imaglist[i],
                                      'thumbnail': thumbnaiImage,
                                      'tax': '0',
                                      'lang[]': 'en',
                                      'unit_price':
                                          PurchasePriceController.text,
                                      'shipping_cost':
                                          ShippingcostController.text,
                                      'description': DescriptionController.text,
                                      'price_type': 'wholesale',
                                      'colors_active': 'true',
                                      'size_active': 'false',
                                      'secret_payment':
                                          allowRequests.toString(),
                                      'wholesale_price':
                                          WholesalePriceController.text,
                                      'colors': colorCode.join(','),

                                      'price_${colorVarient[0]}':
                                          PurchasePriceController.text,
                                      'qty_${colorVarient[0]}':
                                          quantitycontrol.text,
                                      'sku_${colorVarient[0]}': skucontro.text,
                                    };
                                  } else {
                                    addproductmap = {
                                      //new
                                      'name': NmaeController.text,
                                      'sub_name': SubnameController.text,
                                      'category_id': value.toString(),
                                      'sub_category_id': subvalue.toString(),
                                      'brand_id': brandvalue.toString(),
                                      'unit': 'pc',
                                      for (int i = 0; i < imaglist.length; i++)
                                        'images[$i]': imaglist[i],
                                      'thumbnail': thumbnaiImage,
                                      'tax': '0',
                                      'lang[]': 'en',
                                      'unit_price':
                                          PurchasePriceController.text,
                                      'shipping_cost':
                                          ShippingcostController.text,
                                      'description': DescriptionController.text,
                                      'price_type': 'wholesale',
                                      'colors_active': 'true',
                                      'size_active': 'false',
                                      'wholesale_price':
                                          PurchasePriceController.text,
                                      'secret_payment':
                                          allowRequests.toString(),

                                      'colors': colorCode.join(','),

                                      for (int i = 0;
                                          i < combination.length;
                                          i++)
                                        'price_${combination[i]}':
                                            PurchasePriceController.text,
                                      for (int i = 0;
                                          i < combination.length;
                                          i++)
                                        'qty_${combination[i]}':
                                            quantityController[i].text,
                                      for (int i = 0;
                                          i < combination.length;
                                          i++)
                                        'sku_${combination[i]}':
                                            skuController[i].text,
                                    };
                                  }
                                } else {
                                  addproductmap = {
                                    //new
                                    'name': NmaeController.text,
                                    'sub_name': SubnameController.text,
                                    'category_id': value.toString(),
                                    'sub_category_id': subvalue.toString(),

                                    'brand_id': brandvalue.toString(),
                                    'unit': 'pc',
                                    for (int i = 0; i < imaglist.length; i++)
                                      'images[$i]': imaglist[i],
                                    'thumbnail': thumbnaiImage,
                                    'tax': '0',
                                    'lang[]': 'en',
                                    'unit_price': PurchasePriceController.text,
                                    'shipping_cost':
                                        ShippingcostController.text,
                                    'description': DescriptionController.text,
                                    'price_type': 'wholesale',
                                    'colors_active': 'true',
                                    'size_active': 'true',
                                    'secret_payment': allowRequests.toString(),
                                    'wholesale_price':
                                        WholesalePriceController.text,
                                    'colors': colorCode.join(','),
                                    'size': sizeVarient.join(','),

                                    'price_${colorVarient[0]}-${sizeVarient[0]}':
                                        PurchasePriceController.text,
                                    'qty_${colorVarient[0]}-${sizeVarient[0]}':
                                        quantitycontrol.text,
                                    'sku_${colorVarient[0]}-${sizeVarient[0]}':
                                        skucontro.text,
                                  };
                                }

                                print(addproductmap);

                                await DataApiService.instance
                                    .addProduct(addproductmap, context);
                                setState(() {
                                  loader = false;
                                });
                                dialogUploadproduct == false
                                    ? GlobalSnackBar.show(context, snackmessage)
                                    : AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Success',
                                        desc: 'Product Added Successfully',
                                        btnOkOnPress: () {
                                          images.clear();
                                          myImages.clear();
                                          imagesfile.clear();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) => navBar(
                                                      index: 1, see: 0)));
                                        },
                                      ).show();
                              }
                            }
                          }
                        },
                        child: loader
                            ? spinkit
                            : Text(
                                'Upload Now',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.sp),
                              ),
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Future<void> _uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    print('asdfsaf');
    print(pickedFile);
    if (pickedFile != null) {
      pickedImage = pickedFile;
      setState(() {
        _picked = pickedFile;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const imageCropperAddProduct()),
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
                                  'SKU',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                )),
                            Text(
                              'Quantity',
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
                                      return "This field is required";
                                    }
                                  },
                                  controller: skuController[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'SKU',
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
                                            return "This field is required";
                                          }
                                        },
                                        controller: quantityController[index],
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: 'Quantity',
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
                                'SKU',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                          Text(
                            'Quantity',
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
                                    return "This field is required";
                                  }
                                },
                                controller: skuController[index],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'SKU',
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
                                          return "This field is required";
                                        }
                                      },
                                      controller: quantityController[index],
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Quantity',
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
}
