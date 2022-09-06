import 'package:af24/Model/GetcategoriesModel.dart';
import 'package:af24/Model/ProductlistModel.dart';
import 'package:af24/Model/SellerOrderDetailsModel.dart';
import 'package:af24/Model/getChatModel.dart';
import 'package:af24/Model/getColors.dart';
import 'package:af24/Model/getDashboard.dart';
import 'package:af24/Model/getLinkModel.dart';
import 'package:af24/Model/getNotification.dart';
import 'package:af24/Model/getSecretModel.dart';
import 'package:af24/Model/getSecretUserModel.dart';
import 'package:af24/Model/getUserChat.dart';
import 'package:af24/Model/getbrand.dart';
import 'package:af24/Model/getsizeModel.dart';

import 'package:af24/Model/productinfoModel.dart';
import 'package:af24/Model/stockoutModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/SellerOrderListModel.dart';
import '../Model/shippingCostModel.dart';

final CUSTOMER_TOKEN = ValueNotifier("");

late shopinfoModel shopinfoContent;
List<ListElement> productlistContent = [];

List<CategoryModel> catergorylist = [];
List<AllCategoryShippingCost> categorycostlist = [];
List<GetBrandModel> brandlist = [];
List<StockOutModel> stockout = [];
List<ColorsModel> colorList = [];
List<SizeModel> sizeList = [];
List<String> imaglist = [];
List<String> imageditlist = [];
List<SellerOrderListModel> sellerOrderList = [];
List<SellerOrderDetailsModel> sellerOrderDetails = [];
List<GetNotificationModel> getNotifiationList = [];
List<GetChatModel> getChatList = [];
List<GetUserChatModel> getUserList = [];
List<GetSecretModel> getSecretList = [];
List<GetSecretUser> secretUserList = [];
List<GetlinkModel> getlinkuser = [];
// List<GetDashboardModel> getDashboardContent = [];
GetDashboardModel? getDashboardContent;

String imagepath = '';
String thumbnail = '';
String imageName = '';
String thumbnaiImage = '';
XFile? pickedImage;
String snackmessage = '';
String? ProductName;
String? SubName;
String? Category_id;
String? Brand_id;
String? Unit;
String? AddImage;
String? Thumbnail;
String? Discount_type;
String? Unit_price;
String? Purchase_price;
String? Discount;
String? Shipping_Cost;
String? Description;
String? Price_type;
String StatusCode = '403';
String SnackMessage = "";
List<String> myImages = [];

/* class combination {
  final String color;
  final String size;
  combination({required this.color, required this.size});
}

List<combination> comb = [];
 */


void setUserLoggedIn(bool key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLoggedIn", key);
}

Future getUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var log = prefs.getBool("isLoggedIn") ?? false;
  return log;
}

void saveUserDataToken({@required token}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString("token", token);
}
Future getUserDataToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? result = pref.getString("token");
  return result;
}