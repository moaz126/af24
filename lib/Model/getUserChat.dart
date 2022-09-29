// To parse required this JSON data, do
//
//     final getUserChatModel = getUserChatModelFromJson(jsonString);

import 'dart:convert';

List<GetUserChatModel> getUserChatModelFromJson(String str) =>
    List<GetUserChatModel>.from(
        json.decode(str).map((x) => GetUserChatModel.fromJson(x)));

class GetUserChatModel {
  GetUserChatModel({
    required this.id,
    required this.userId,
    required this.sellerId,
    required this.message,
    required this.sentByCustomer,
    required this.sentBySeller,
    required this.seenByCustomer,
    required this.seenBySeller,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.shopId,
    required this.messageData,
    required this.specialMessage,
    required this.lastMessage,
    required this.customer,
  });

  int id;
  int userId;
  int sellerId;
  String message;
  int sentByCustomer;
  int sentBySeller;
  int seenByCustomer;
  int seenBySeller;
  int status;
  DateTime createdAt;
  DateTime? updatedAt;
  int shopId;
  dynamic messageData;
  bool specialMessage;
  String lastMessage;
  dynamic customer;

  factory GetUserChatModel.fromJson(Map<String, dynamic> json) =>
      GetUserChatModel(
        id: json["id"],
        userId: json["user_id"],
        sellerId: json["seller_id"],
        message: json["message"],
        sentByCustomer: json["sent_by_customer"],
        sentBySeller: json["sent_by_seller"],
        seenByCustomer: json["seen_by_customer"],
        seenBySeller: json["seen_by_seller"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        shopId: json["shop_id"],
        messageData: json["message_data"],
        specialMessage: json["special_message"],
        lastMessage: json["last_message"],
        customer: json["customer"] != null
            ? Customer.fromJson(json["customer"])
            : null,
      );
}

class Customer {
  Customer({
    required this.id,
    required this.name,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.image,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.streetAddress,
    required this.country,
    required this.city,
    required this.zip,
    required this.houseNo,
    required this.apartmentNo,
    required this.cmFirebaseToken,
    required this.isActive,
    required this.paymentCardLastFour,
    required this.paymentCardBrand,
    required this.paymentCardFawryToken,
    required this.loginMedium,
    required this.socialId,
    required this.isPhoneVerified,
    required this.temporaryToken,
    required this.isEmailVerified,
    required this.walletBalance,
    required this.loyaltyPoint,
    required this.title,
    required this.dOB,
    required this.newsletter,
    required this.folowed,
  });

  int id;
  dynamic name;
  String fName;
  String lName;
  String phone;
  String image;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic streetAddress;
  dynamic country;
  dynamic city;
  dynamic zip;
  dynamic houseNo;
  dynamic apartmentNo;
  String? cmFirebaseToken;
  int isActive;
  dynamic paymentCardLastFour;
  dynamic paymentCardBrand;
  dynamic paymentCardFawryToken;
  dynamic loginMedium;
  dynamic socialId;
  int isPhoneVerified;
  String? temporaryToken;
  int isEmailVerified;
  dynamic walletBalance;
  dynamic loyaltyPoint;
  String title;
  String? dOB;
  String? newsletter;
  String? folowed;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        image: json["image"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        streetAddress: json["street_address"],
        country: json["country"],
        city: json["city"],
        zip: json["zip"],
        houseNo: json["house_no"],
        apartmentNo: json["apartment_no"],
        cmFirebaseToken: json["cm_firebase_token"],
        isActive: json["is_active"],
        paymentCardLastFour: json["payment_card_last_four"],
        paymentCardBrand: json["payment_card_brand"],
        paymentCardFawryToken: json["payment_card_fawry_token"],
        loginMedium: json["login_medium"],
        socialId: json["social_id"],
        isPhoneVerified: json["is_phone_verified"],
        temporaryToken:
            json["temporary_token"] == null ? null : json["temporary_token"],
        isEmailVerified: json["is_email_verified"],
        walletBalance: json["wallet_balance"],
        loyaltyPoint: json["loyalty_point"],
        title: json["title"],
        dOB: json["d_o_b"],
        newsletter: json["newsletter"],
        folowed: json["folowed"] == null ? null : json["folowed"],
      );
}
