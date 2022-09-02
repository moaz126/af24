import 'package:af24/Model/GetcategoriesModel.dart';
import 'package:af24/Model/ProductlistModel.dart';
import 'package:af24/Model/SellerOrderDetailsModel.dart';
import 'package:af24/Model/getChatModel.dart';
import 'package:af24/Model/getColors.dart';
import 'package:af24/Model/getNotification.dart';
import 'package:af24/Model/getbrand.dart';
import 'package:af24/Model/getsizeModel.dart';

import 'package:af24/Model/productinfoModel.dart';
import 'package:af24/Model/stockoutModel.dart';

import 'package:flutter/cupertino.dart';

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

String imagepath = '';
String thumbnail = '';
String imageName = '';
String thumbnaiImage = '';

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

/* class combination {
  final String color;
  final String size;
  combination({required this.color, required this.size});
}

List<combination> comb = [];
 */