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

  //welcome
  String get APP_NAME;
  String get WELCOME;
  String get LOGIN;
  String get SIGNUP;

  //login
  String get PHONE_HINT;
  String get PASS_HINT;
  String get FORGOT_PASSWORD;
  String get NO_ACCOUNT;

  //forgot/reset password
  String get EMAIL_VERIFICATION_TEXT;
  String get RESET_PASSWORD;
  String get VERIFICATION_CODE_HINT;
  String get NEW_PASS_HINT;
  String get CONFIRM_PASS_HINT;
  String get PASSWORD_MISMATCH ;
  String get CODE_MISMATCH;

  //signup
  String get NAME_HINT;
  String get EMAIL_HINT;
  String get GENDER;
  String get MALE;
  String get FEMALE;
  String get AGE;
  String get COUNTRY;
  String get SELECT_COUNTRY;
  String get CITY;
  String get SELECT_CITY;
  String get AREA;
  String get SELECT_AREA;
  String get ZONE;
  String get SELECT_ZONE;
  String get TERMS_CONDITIONS;
  String get VERIFICATION_CODE_SENT;
  String get AGREE_TERMS;
  String get ALREADY_ACCOUNT;
  String get INVALID_NAME;
  String get INVALID_EMAIL;
  String get INVALID_AGE;
  String get INVALID_PASSWORD;
  String get PASSWORD_LENGTH;
  String get INVALID_PHONE;
  String get INVALID_MOBILE_NUMBER;
  String get REQUIRED;
  String get SKIP;
  String get UNDER;
  String get ABOVE;
  String get PLEASE_WAIT;

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
  String get ARCHIVE;
  String get WINNERS;
  String get PROFILE;
  String get WISHLIST;

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
  String get TOTAL_APP_DOWNLOADS;
  String get TODAY_LOTTERY_VALUE;
  String get TODAY_LOTTERY_PRIZE;
  String get NUMBER_OF_WINNERS;
  String get VALUE;
  String get NO_LOTTERY;

}
