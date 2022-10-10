// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  //general
  String get NO_ADDS_FOUND;
  String get NO_NOTIFICATIONS;
  String get SAVE;
  String get SEND;
  String get SUBMIT;
  String get ALL;
  String get OK;
  String get ZERO_SAR;
  String get SAR;
  String get TO;
  String get VALIDATOR;
  //Awesome Dialog message
  String get ERROR;
  String get SUCCESS;
  String get EXIT;
  String get LOGOUT_TEXT;
  String get LOGOUT_SUCCESS;
  String get UPDATE_SUCCESS;
  String get MATCH_FOUND;
  String get ALREADY_SIZE;
  String get ALREADY_COLOR;
  String get DELETE_TEXT;
  String get CHANGE_STATUS;
  String get STATUS_TEXT;
  String get SAVE_SUCCESS;
  String get PRODUCT_ADDED;
  String get VARIENT_MSG;
  String get SESSION_EXPIRE;
  String get STATUS_UPDATE;

  //Global snakebar message
  String get ADD_CLR_SZ;
  String get UPLOAD_IMAGE;
  String get ENTER_EMAIL;
  String get PASS_ERROR;
  String get PASS_NOMATCH;



  //welcome
  String get APP_NAME;
  String get WELCOME;

  //login
  String get EMAIL;
  String get EMAIL_HINT;
  String get PASSWORD;
  String get REMEBER_ME;
  String get FORGOT_PASSWORD;
  String get LOGIN;
  String get NO_ACCOUNT;
  String get SIGNUP;

  //forgot/reset password
  String get EMAIL_VERIFICATION_TEXT;
  String get EMAIL_SEND;

  //signup
  String get FIRST_NAME;
  String get LAST_NAME;
  String get MOBILE_NUMBER;
  String get NUMBER_HINT;
  String get PASSWORD_MSG;
  String get CONFIRM_PASS;
  String get SHOP_NAME;
  String get SHOP_ADDRESS;
  String get REGISTER;
  String get ALREADY;

  //OTP
  String get VERIFICATION;
  String get ENTER_OTP;
  String get VERIFY;
  String get NO_OTP;
  String get RESEND_CODE;

  //bottom navigation
  String get YES;
  String get NO;
  String get EXIT_APP_TEXT;
  String get HOME;
  String get PRODUCTS;
  String get SELL;
  String get NOTIFICATION;
  String get MY_ORDERS;

  //drawer
  String get DASHBOARD;
  String get NOTIFICATIONS;
  String get PRIVACY_POLICY;
  String get ABOUT_US;
  String get LOGOUT;

  //winners page
  String get NO_WINNERS_FOUND;
  String get GROUP;
  String get WINNING_DATE;
  String get SELECT_DATE;
  String get ALL_WINNERS;
  String get PRIZE_MONEY;

  //profile page
  String get PROFILE_UPDATED;

  //dashboard
  String get ISSUED;
  String get EDIT_PROFILE;
  String get PAYMENT_PAGE;
  String get ORDER;
  String get CONFIRMED;
  String get DELIVERED;
  String get PENDING;
  String get PROCESSING;
  String get CANCELLED;
  String get MY_STORE;
  String get EARNINGS;
  String get CATTING_WITH;
  String get VIEW_ALL;


  //My products page
  String get EDIT;
  String get DELETE;
  String get NO_PRODUCTS;

  //Sell
  String get UPLOAD_PRODUCT;
  String get PRODUCT_DETAIL;
  String get ADD_IMAGES;
  String get PRODUCT_NAME;
  String get SUB_NAME;
  String get CATEGORY;
  String get SUB_CATEGORY;
  String get BRANDS;
  String get STATUS;
  String get SIZE;
  String get COLOR;
  String get ADD_MORE_SIZE;
  String get ADD_NEW_SIZE;
  String get ADD_MORE_COLOR;
  String get ADD;
  String get PICK_COLOR;
  String get COLOR_NAME;
  String get GENERATE_VARIANTS;
  String get SKU;
  String get QUANTITY;
  String get SHIPPING_COST;
  String get COMPANY;
  String get WHOLESALE_PRICE;
  String get CONSUMER_PRICE;
  String get ALLOW_BUY;
  String get DESCRIPTION;
  String get DESC_HINT;
  String get UPLOAD_NOW;
  String get PICK_IMAGE;
  String get CAMERA;
  String get GALLERY;
  //Chat Notification page
  String get MY_MESSAGES;
  //INBOX
  String get QUICK_ANSWER;
  String get WRITE_MESS;
  String get NO_MESSAGES;
  //order
  String get MY_ORDER;
  String get SEARCH_DATE;
  String get ALL_ORDERS;
  String get ORDERS_NO;
  String get NO_ORDERS;
  String get DATE_OF_ORDER;
  String get CUSTOMER_ID;
  String get TRAKING_ID;
  String get ENTER_TRAK_ID;
  String get DELIVERY_ID;
  String get ENTER_DELIV_ID;
  String get ORDER_DETAIL;
  String get DETAILS;
  String get SAVE_DETAILS;
  //Order details
  String get ORDERS_DETAILS;
  String get ORDER_NO;
  String get METHOD;
  String get ORDER_STATUS;
  String get PYMENT_STATUS;
  String get CUSTOMER_DETAIL;
  String get NAME;
  String get CONTACT;
  String get ADDRESS;
  String get SUB_TOTAL;
  String get TAX;
  String get DISCOUNT;
  String get COUPON;
  String get SHIPPING_FEE;
  String get TOTAL_AMOUNT;
  String get GRAND_TOTAL;
  //payment links
  String get PAYMENT_LINKS;
  String get EMPTY_LIST;
  //EDIT PAYMENT LINKS
  String get EDIT_PAYMENT_LINKS;
  String get LINK_NO;
  String get CUSTOMER_NAME;
  String get PRICE;
  String get EDIT_PRICE;
  String get UPDATE;
  String get NO_LINKS;
  //Product Detail
  String get PRODUCT_DETAIL_TITLE;
  String get COMMENT;
  String get REQUEST;
  String get NO_COMMENT;
  String get NO_REQUEST;
  String get LEAVE_COMMENT;

  //edit product
  String get EDIT_PRODUCT;
  //Crop Image
  String get CROP_IMAGE;
  String get CROPPER;


}
