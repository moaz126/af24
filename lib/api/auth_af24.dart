import 'dart:convert';
import 'package:af24/Model/GetcategoriesModel.dart';
import 'package:af24/Model/ProductlistModel.dart';
import 'package:af24/Model/getbrand.dart';

import 'package:af24/Model/productinfoModel.dart';
import 'package:af24/Model/shippingCostModel.dart';
import 'package:af24/Model/stockoutModel.dart';
import 'package:af24/api/global_variable.dart';

import 'package:af24/api/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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

  Future uploadImage(Map<String, dynamic> uploadimg, context) async {
    String url = baseUrl + uploadImage_url;
    print(url);

    try {
      http.Response response = await http.post(Uri.parse(url),
          body: uploadimg,
          headers: {
            "Authorization": "Bearer ${CUSTOMER_TOKEN.value}",
            "Accept": "application/json"
          });

      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Success3');
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

  Future updateStoreInfo(Map<String, dynamic> updatestore, context) async {
    String url = baseUrl + updatestore_url;
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
        StatusCode = '200';
      } else {
        print("unsucess3");
        StatusCode = '403';
      }
    } on Exception {
      rethrow;
    } catch (e) {
      rethrow;
    }
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

  Future updateproducts(int id, String pname, String pSubname) async {
    String url = baseUrl +
        updateproduct_url +
        '/' +
        '$id?name=${pname}&sub_name=${pSubname}&category_id=1&brand_id=1&unit=pc&images[]=2022-07-14-62cf0f8147b41.png&thumbnail=2022-07-14-62cf0f8149791.png&discount_type=percent&tax=10&lang[]=en&unit_price=60&purchase_price=40&discount=20&shipping_cost=15&description=abc&price_type=wholesale';
    print(url);

    try {
      http.Response response = await http.put(Uri.parse(url), headers: {
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
