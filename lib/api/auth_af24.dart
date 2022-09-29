import 'dart:convert';
import 'package:af24/Model/GetcategoriesModel.dart';
import 'package:af24/Model/ProductlistModel.dart';
import 'package:af24/Model/SellerOrderDetailsModel.dart';
import 'package:af24/Model/SellerOrderListModel.dart';
import 'package:af24/Model/getAllLinks.dart';
import 'package:af24/Model/getChatModel.dart';
import 'package:af24/Model/getLinkModel.dart';
import 'package:af24/Model/getNotification.dart';
import 'package:af24/Model/getSecretModel.dart';
import 'package:af24/Model/getSecretUserModel.dart';
import 'package:af24/Model/getUserChat.dart';
import 'package:af24/Model/getbrand.dart';
import 'package:af24/Model/getsizeModel.dart';
import 'package:af24/Screens/login.dart';
import 'package:af24/constants.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'package:af24/Model/ShopInfoModel.dart';
import 'package:af24/Model/shippingCostModel.dart';
import 'package:af24/Model/stockoutModel.dart';
import 'package:af24/api/global_variable.dart';

import 'package:af24/api/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Model/getColors.dart';
import '../Model/getDashboard.dart';
/* import 'package:streaming_plug/Models/SearchPageModel.dart';
import 'package:streaming_plug/api_services/urls.dart';

import '../Models/HomePageModel.dart';
import '../Screens/Widget/global_variable.dart'; */

class DataApiService {
  DataApiService._();

  static final DataApiService _instance = DataApiService._();

  static DataApiService get instance => _instance;

  Future getlogintoken(Map<String, dynamic> data, context) async {
    String url = baseUrl + url_login;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: data, headers: {'Accept': "application/json"});
      print(response.body);
      final result = jsonDecode(response.body);
      print(result.containsKey('token'));
      print(result.containsKey('message'));
      if (result.containsKey('token')) {
        SnackMessage = 'Login Successfully';
        CUSTOMER_TOKEN.value = result['token'];

        StatusCode = '200';
        setUserLoggedIn(true);
        saveUserDataToken(
          token: CUSTOMER_TOKEN.value,
        );
      } else {
        SnackMessage = result['message'];
      }
      return result.containsKey('token');
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getSignUptoken(Map<String, dynamic> body, context) async {
    String url = baseUrl + register_url;
    StatusCode = '403';
    print(url);
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: body, headers: {'Accept': 'application/json'});

      final result = jsonDecode(response.body);
      print(result);
      StatusCode = response.statusCode.toString();

      if (result is String) {
        SnackMessage = 'Account created successfully';
      } else {
        SnackMessage = result['message'];
        print(SnackMessage);
      }
      return result is String;
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getshopinfo() async {
    String url = baseUrl + shop_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        shopinfoContent = shopinfoModel.fromJson(result);
        print('success');
        print(shopinfoContent.image);
      } else {
        print("unsucess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future forgotPassword(String email) async {
    String url = baseUrl + forgot_pass_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'identity': email
      }, headers: {
        "Accept": "application/json",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return result;
      } else {
        print("unsucess");
        return result;
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future changeStatus(String id, String status, context) async {
    String url = baseUrl + changeStatus_url + '/' + id;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'id': id,
        'order_status': status
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        GlobalSnackBar.show(context, result['message']);
        return result;
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess");
        return result;
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future changePymentStatus(String id, String status, context) async {
    String url = baseUrl + paymentStatus_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'order_id': id,
        'payment_status': status
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        GlobalSnackBar.show(context, 'Payment Status Updated Successfully');
        return result;
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess");
        return result;
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future seenNotification(String id, context) async {
    String url = baseUrl + seen_notification_url + id + '/seen';
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // GlobalSnackBar.show(context, 'Payment Status Updated Successfully');
        return result;
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess");
        return result;
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getproductlist(context) async {
    String url = baseUrl + productlist_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        productlistContent = List<ListElement>.from(
            result['list'].map((x) => ListElement.fromJson(x)));

        thumbnail = result['thumbnail_path'];
        imagepath = result['images_path'];
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getLinksProduct(context) async {
    String url = baseUrl + productlist_url + '?for_links=true';

    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        productLinks = List<ListElement>.from(
            result['list'].map((x) => ListElement.fromJson(x)));

        thumbnail = result['thumbnail_path'];
        imagepath = result['images_path'];
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getmainproductlist() async {
    String url = baseUrl + productlist_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        productlistContent = List<ListElement>.from(
            result['list'].map((x) => ListElement.fromJson(x)));
        /*  thumbnail = List<ProductlistModel>.from(
            result.map((x) => ProductlistModel.fromJson(x))); */
        thumbnail = result['thumbnail_path'];
        imagepath = result['images_path'];
        print('1010101010');

        print(thumbnail);
        print(imagepath);
        //print(result[0]['images_path']);
      } else if (response.statusCode == 401) {
        // GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getCategoryList(context) async {
    String url = baseUrl + Getacategory_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        print(result["data"]);
        print("divider");
        catergorylist = List<CategoryModel>.from(
            result['data'].map((x) => CategoryModel.fromJson(x)));
        print(catergorylist[0].subCategories[0].name);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());
        GlobalSnackBar.show(context, 'Session Expired!');
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getcolorlist() async {
    String url = baseUrl + colors_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        print(result["data"]);
        print("divider");
        colorList = List<ColorsModel>.from(
            result['data'].map((x) => ColorsModel.fromJson(x)));
        print(colorList[0].name);
        /*  colorList.insert(
            0, ColorsModel(id: 555, name: 'Add More', code: 'code')); */
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getsizelist() async {
    String url = baseUrl + getSize_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        print(result["data"]);
        print("divider");
        sizeList = List<SizeModel>.from(
            result['data'].map((x) => SizeModel.fromJson(x)));
        print(sizeList[0].label);
        /*  sizeList.insert(0, SizeModel(label: 'Add More')); */
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getShippingCost() async {
    String url = baseUrl + shippingcost_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        print(result["all_category_shipping_cost"]);
        print("divider");
        categorycostlist = List<AllCategoryShippingCost>.from(
            result['all_category_shipping_cost']
                .map((x) => AllCategoryShippingCost.fromJson(x)));
        print(categorycostlist[0].cost);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getBrand() async {
    String url = baseUrl + getbrand_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        print(result);
        print("divider");
        brandlist = List<GetBrandModel>.from(
            result.map((x) => GetBrandModel.fromJson(x)));
        print(brandlist[0].name);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getStockOut() async {
    String url = baseUrl + stockout_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Success');
        print(result);
        print("divider");
        stockout = List<StockOutModel>.from(
            result.map((x) => StockOutModel.fromJson(x)));
        print(stockout[0].limit);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future addProduct(Map<String, dynamic> addproduct, context) async {
    String url = baseUrl + addproduct_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: addproduct,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });

      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        StatusCode == '200';
        dialogUploadproduct = true;
        print('Success3');
        snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        dialogUploadproduct = false;
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        dialogUploadproduct = false;
        StatusCode == '403';
        snackmessage = result['message'];
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future sendOrderDetail(Map<String, dynamic> save, context) async {
    String url = baseUrl + saveOrderDetail;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: save,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });

      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
      } else if (response.statusCode == 401) {
        dialogUploadproduct = false;
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        dialogUploadproduct = false;
        StatusCode == '403';
        snackmessage = result['message'];
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future sendLink(Map<String, dynamic> sendlink, context) async {
    String url = baseUrl + sendLink_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: sendlink,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });

      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        snackmessage = result['message'];
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future logout(int id) async {
    String url = baseUrl + 'v2/seller/' + id.toString() + logout_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
        "Accept": "application/json"
      });
      print(response.body);
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future addSize(String size, context) async {
    String url = baseUrl + addSize_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'label': size
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
        "Accept": "application/json"
      });

      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (result['success'] == false) {
          return false;
        } else {
          return true;
        }

        // snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future addColor(Map<String, dynamic> color, context) async {
    String url = baseUrl + addColor_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: color,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });

      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (result['success'] == false) {
          return false;
        } else {
          return true;
        }

        // snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /* Future uploadImage(String uploadimg, context) async {
    String url = baseUrl + uploadImage_url;
    print(url);
    var headers = {
      "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      "Accept": "application/json"
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({'type': 'product'});
    request.files.add(await http.MultipartFile.fromPath('images', uploadimg));
    
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String ans = await response.stream.bytesToString();

    final result = jsonDecode(ans);

    if (response.statusCode == 200) {
     
      print('success');
      print(result['image_name']);
    } else {
     
      print('unccess');
    }
    
  } */

  Future uploadImage(Map<String, dynamic> uploadimg, context) async {
    String url = baseUrl + uploadImage_url;
    print(url);

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: uploadimg,
        headers: {
          "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
          "Accept": "application/json"
        },
      );

      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        print('ddddddddddddddddddddddddddddd');
        print(result['image_name']);
        snackmessage = result['image_name'];
        imageName = result['image_name'];
        imaglist.add(imageName);
        print(imaglist);
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future updateProfileContent(String image, String type) async {
    String url = baseUrl + uploadImage_url;

    print(url);
    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
    };
    print(type);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'type': type,
    });
    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String ans = await response.stream.bytesToString();
    final result = jsonDecode(ans);

    if (response.statusCode == 200) {
      print("sssss");
      print(result);
      imageName = result['image_name'];
      if (type == 'thumbnail') {
        thumbnaiImage = imageName;
      } else {
        imaglist.add(imageName);
        imageditlist.add(imageName);
      }
      print('thumbnail');
      print(thumbnaiImage);
      print(imageditlist);
      return result;
    } else if (response.statusCode == 401) {
      Get.offAll(Login());

      print("unsuccess");
    } else {
      print(response.reasonPhrase);
    }

    //
    // print(url);
    // try {
    //   var response =
    //       await http.post(Uri.parse(url), body: body, headers: {
    //     "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
    //   });
    //  // response.files.add(await http.MultipartFile.fromPath('image', '/C:/Users/Zunair Shahid/Pictures/WBS.png'));
    //   // print(response.body);
    //   final result = jsonDecode(response.body);
    //   return result;
    // } on Exception {
    //   rethrow;
    // } catch (e) {
    //   rethrow;
    // }
  }

  Future getSellerOrderList(context) async {
    String url = baseUrl + getSellerOrderList_url;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Seller Order');
        print(result);
        print("List");
        sellerOrderList = List<SellerOrderListModel>.from(
            result.map((x) => SellerOrderListModel.fromJson(x)));
        print(sellerOrderList.length);
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("Seller Order List");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getSecretMessage(Map<String, dynamic> body, context) async {
    String url = baseUrl + secret_url;
    print(url);

    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getSecretList = List<GetSecretModel>.from(
            result["list"]["comments"].map((x) => GetSecretModel.fromJson(x)));
        print(getSecretList.length);
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired!');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getlinkUsers(Map<String, dynamic> body, context) async {
    String url = baseUrl + getlinkuser_url;
    print(url);

    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getlinkuser = List<GetlinkModel>.from(
            result["list"].map((x) => GetlinkModel.fromJson(x)));
        print(getSecretList.length);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getAllLinks(String id, context) async {
    String url = baseUrl + allLink_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'product_id': id
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getlinkContent = List<GetAllLinks>.from(
            result["list"].map((x) => GetAllLinks.fromJson(x)));
        print(getlinkContent.length);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future updateLink(String id, String price, context) async {
    String url = baseUrl + updateLink_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'id': id,
        'price': price
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        print(getlinkContent.length);
        snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future sendSecretMessage(Map<String, dynamic> body, context) async {
    String url = baseUrl + sendSecretMsg_url;
    print(url);

    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('success');
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getSellerOrderDetails(String id) async {
    String url = baseUrl + getSellerOrderDetails_url + id;
    print(url);

    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Seller Order');
        print(result);
        print("Details");
        sellerOrderDetails = List<SellerOrderDetailsModel>.from(
            result.map((x) => SellerOrderDetailsModel.fromJson(x)));
        print(sellerOrderDetails.length);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("Seller Order Details");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future updateStoreInfo(
      String name, String number, String address, String file, context) async {
    String url = baseUrl + updatestore_url;
    print(url);
    print(url);
    var headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      "name": name,
      "contact": number,
      "address": address,
    });
    if (file != '') {
      request.files.add(await http.MultipartFile.fromPath('image', file));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String ans = await response.stream.bytesToString();
    final result = jsonDecode(ans);

    if (response.statusCode == 200) {
      snackmessage = result;
      print("sssss");
      print(result);

      return result;
    } else if (response.statusCode == 401) {
      Get.offAll(Login());

      print("unsuccess");
    } else {
      print(response.reasonPhrase);
    }
    /* try {
      http.Response response = await http.post(Uri.parse(url),
          body: updatestore,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });

      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        StatusCode = '200';
        snackmessage = result;
      } else {
        print("unsucess3");
        StatusCode = '403';
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    } */
  }

  Future sellerinfoupdate() async {
    String url = baseUrl + sellerUpdate_url;
    print(url);

    try {
      http.Response response = await http.put(Uri.parse(url), body: {
        'f_name': 'Test',
        'l_name': 'Seller',
        'bank_name': 'Dummy Bank',
        'branch': 'xyz',
        'account_no': '1111111111111111',
        'holder_name': 'Test Seller',
        'phone': '0334545456',
        'password': 'pakistan'
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
        "Accept": "application/json"
      });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future updatestore(Map<String, dynamic> updatestore, context) async {
    String url = baseUrl + Updatestore_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: updatestore,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getNotification(String body, context) async {
    String url = baseUrl + notification_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'user_id': body
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
        "Accept": "application/json"
      });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');

        getNotifiationList = List<GetNotificationModel>.from(
            result.map((x) => GetNotificationModel.fromJson(x)));
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future sendMessage(Map<String, dynamic> body, context) async {
    String url = baseUrl + sendMessage_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: body,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');

        /*  getNotifiationList = List<GetNotificationModel>.from(
            result.map((x) => GetNotificationModel.fromJson(x))); */
        print(response.body);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getChat(Map<String, dynamic> body, context) async {
    String url = baseUrl + getChat_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: body,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        getChatList = List<GetChatModel>.from(
            result.map((x) => GetChatModel.fromJson(x)));
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getDashboard() async {
    String url = baseUrl + getDashboard_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
        "Accept": "application/json"
      });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        print(response.body);
        getDashboardContent = GetDashboardModel.fromJson(result);
        return true;
      } else if (response.statusCode == 401) {
        return false;
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getUserChat(context) async {
    String url = baseUrl + getUser_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
        "Accept": "application/json"
      });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        print(response.body);
        getUserList = List<GetUserChatModel>.from(
            result.map((x) => GetUserChatModel.fromJson(x)));
      } else if (response.statusCode == 401) {
        GlobalSnackBar.show(context, 'Session Expired');
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getmainUserChat() async {
    String url = baseUrl + getUser_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
        "Accept": "application/json"
      });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');

        getUserList = List<GetUserChatModel>.from(
            result.map((x) => GetUserChatModel.fromJson(x)));
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future updateFcmToken() async {
    String url = baseUrl + updateToken_url;
    String fsmToken = '';

    await FirebaseMessaging.instance.getToken().then((value) async {
      print(value);
      fsmToken = value.toString();
      print("fsmToken");
      print(fsmToken);
    });

    print(url);
    try {
      print('Hello');
      http.Response response = await http.post(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      }, body: {
        'cm_firebase_token': fsmToken,
      });
      print("response.body firebase token");
      print(response.body);
      if (response.statusCode == 200) {
        print('Follow Brand ');
        print(fsmToken);
        print('List');
      } else {
        print('List');
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getSecretUser(Map<String, dynamic> body, context) async {
    String url = baseUrl + secretUser_url;
    print(url);

    try {
      http.Response response =
          await http.post(Uri.parse(url), body: body, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        secretUserList = List<GetSecretUser>.from(
            result["list"].map((x) => GetSecretUser.fromJson(x)));
        print(getSecretList.length);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsuccess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future setCategoryCost(Map<String, dynamic> categoryCost, context) async {
    String url = baseUrl + setCategory_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: categoryCost,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future updateproducts(
      int id, Map<String, dynamic> updateproduct, context) async {
    String url = baseUrl + updateproduct_url + '/' + '$id';
    print(url);

    try {
      http.Response response = await http.put(Uri.parse(url),
          body: updateproduct,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        snackmessage = result['message'];
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteProduct(String index) async {
    String url = baseUrl + delete_url + '/' + index;
    print(url);

    try {
      http.Response response = await http.delete(Uri.parse(url), headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
        "Accept": "application/json"
      });
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        snackmessage = result['message'];
        print(result['message']);
      } else if (response.statusCode == 401) {
        Get.offAll(Login());

        print("unsuccess");
      } else {
        print("unsucess3");
        snackmessage = 'Something bad happend!';
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /* Future getSearchContent(String userName) async {
    String url = baseUrl + searchContent;
    print(url);
    print(userName);
    print(CUSTOMER_TOKEN.value);
    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        'value': userName
      }, headers: {
        "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
      });
      print(response.body);
      final result = jsonDecode(response.body);
      if (result['success']) {
        searchModelContent = List<SearchPageModel>.from(
            result['data'].map((x) => SearchPageModel.fromJson(x)));
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  } */
}
