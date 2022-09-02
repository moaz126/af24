import 'dart:convert';
import 'package:af24/Model/GetcategoriesModel.dart';
import 'package:af24/Model/ProductlistModel.dart';
import 'package:af24/Model/SellerOrderDetailsModel.dart';
import 'package:af24/Model/SellerOrderListModel.dart';
import 'package:af24/Model/getChatModel.dart';
import 'package:af24/Model/getNotification.dart';
import 'package:af24/Model/getbrand.dart';
import 'package:af24/Model/getsizeModel.dart';

import 'package:af24/Model/productinfoModel.dart';
import 'package:af24/Model/shippingCostModel.dart';
import 'package:af24/Model/stockoutModel.dart';
import 'package:af24/api/global_variable.dart';

import 'package:af24/api/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Model/getColors.dart';
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

      print(CUSTOMER_TOKEN.value);
      if (response.statusCode == 200) {
        SnackMessage = 'Login Successfully';
        CUSTOMER_TOKEN.value = result['token'];
        StatusCode = '200';
      } else {
        print(result['errors'][0]['message']);
        SnackMessage = result['errors'][0]['message'];
      }
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
      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
      );

      final result = jsonDecode(response.body);
      // Customer_Token.value = (result['token']);
      print("fhfvbkf abgfb jwegfkasvkag fbashfoi");

      // SignUpCode = jsonDecode(response.statusCode.toString());
      print(response.statusCode);
      StatusCode = response.statusCode.toString();
      if (response.statusCode == 200) {
        SnackMessage = 'Account created successfully';
      } else {
        print('sgvcznxfgfbvsvfcgfbvc');
        print(result['errors'][0]['message']);
        SnackMessage = result['errors'][0]['message'];
        print(SnackMessage);
      }
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
        //print('Success');
        /*  shopinfoContent = shopinfoModel(
            id: 2,
            sellerId: 2,
            name: 'muneeb',
            address: 'address',
            contact: '',
            image: '',
            createdAt: DateTime(12),
            updatedAt: DateTime(12),
            banner: '',
            rating: 5,
            ratingCount: 5); */
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

  Future getproductlist() async {
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
      } else {
        print("unsucess");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getCategoryList() async {
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
      } else {
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
        print('Success3');
        snackmessage = result['message'];
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

  Future getSellerOrderList() async {
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
      } else {
        print("Seller Order List");
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getSellerOrderDetails(int id) async {
    String url = baseUrl + getSellerOrderDetails_url + id.toString();
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
    request.files.add(await http.MultipartFile.fromPath('image', file));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String ans = await response.stream.bytesToString();
    final result = jsonDecode(ans);

    if (response.statusCode == 200) {
      print("sssss");
      print(result);

      return result;
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
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
        print(response.body);
        getChatList = List<GetChatModel>.from(
            result.map((x) => GetChatModel.fromJson(x)));
      } else {
        print("unsucess3");
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
