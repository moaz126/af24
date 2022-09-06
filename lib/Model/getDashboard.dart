// To parse this JSON data, do
//
//     final getDashboardModel = getDashboardModelFromJson(jsonString);

import 'dart:convert';

GetDashboardModel getDashboardModelFromJson(String str) =>
    GetDashboardModel.fromJson(json.decode(str));

String getDashboardModelToJson(GetDashboardModel data) =>
    json.encode(data.toJson());

class GetDashboardModel {
  GetDashboardModel({
    required this.confirmOrder,
    required this.cancelledOrder,
    required this.returnedOrder,
    required this.outForDelivery,
    required this.delieved,
    required this.xAxis,
    required this.yAxis,
    required this.messages,
  });

  int confirmOrder;
  int cancelledOrder;
  int returnedOrder;
  int outForDelivery;
  int delieved;
  List<int> xAxis;
  List<int> yAxis;
  List<Message> messages;

  factory GetDashboardModel.fromJson(Map<String, dynamic> json) =>
      GetDashboardModel(
        confirmOrder: json["confirm order"],
        cancelledOrder: json["cancelled order"],
        returnedOrder: json["returned order"],
        outForDelivery: json["out for delivery"],
        delieved: json["delieved"],
        xAxis: List<int>.from(json["x-axis"].map((x) => x)),
        yAxis: List<int>.from(json["y-axis"].map((x) => x)),
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "confirm order": confirmOrder,
        "cancelled order": cancelledOrder,
        "returned order": returnedOrder,
        "out for delivery": outForDelivery,
        "delieved": delieved,
        "x-axis": List<dynamic>.from(xAxis.map((x) => x)),
        "y-axis": List<dynamic>.from(yAxis.map((x) => x)),
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  Message({
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
    required this.sellerInfo,
    required this.customer,
    required this.shop,
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
  MessageData? messageData;
  bool specialMessage;
  SellerInfo sellerInfo;
  Customer? customer;
  Shop shop;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
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
        messageData: json["message_data"] == null
            ? null
            : MessageData.fromJson(json["message_data"]),
        specialMessage: json["special_message"],
        sellerInfo: SellerInfo.fromJson(json["seller_info"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        shop: Shop.fromJson(json["shop"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "seller_id": sellerId,
        "message": message,
        "sent_by_customer": sentByCustomer,
        "sent_by_seller": sentBySeller,
        "seen_by_customer": seenByCustomer,
        "seen_by_seller": seenBySeller,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt,
        "shop_id": shopId,
        "message_data": messageData == null ? null : messageData,
        "special_message": specialMessage,
        "seller_info": sellerInfo,
        "customer": customer == null ? null : customer,
        "shop": shop,
      };
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
    required this.followedSeller,
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
  String cmFirebaseToken;
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
  String dOB;
  String newsletter;
  String? folowed;
  String? followedSeller;

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
        followedSeller:
            json["followed_seller"] == null ? null : json["followed_seller"],
      );
}

enum CustomerEmail { ZAIN_GMAIL_COM, DUMMYPERSONA_GMAIL_COM }

enum CustomerFName { RIDA, DUMMY }

enum FollowedSeller { THE_11321631 }

enum Folowed { THE_115 }

enum CustomerImage { DEF_PNG }

enum CustomerLName { RIDA, PERSONA }

enum TemporaryToken { E3_Q3_KSIR_GT_B3_TU_WE4_DY_Q3_Y1_QQ_X76_RKZH3_IN1_RJ_OZ }

class MessageData {
  MessageData({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.actualPrice,
  });

  String productId;
  String productName;
  String quantity;
  String actualPrice;

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        actualPrice: json["actual_price"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "actual_price": actualPrice,
      };
}

class SellerInfo {
  SellerInfo({
    required this.id,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.image,
    required this.email,
    required this.password,
    required this.status,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.bankName,
    required this.branch,
    required this.accountNo,
    required this.holderName,
    required this.authToken,
    required this.salesCommissionPercentage,
    required this.gst,
    required this.cmFirebaseToken,
    required this.posStatus,
  });

  int id;
  String fName;
  String lName;
  String phone;
  String image;
  String email;
  String password;
  String status;
  String rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  String bankName;
  String branch;
  String accountNo;
  String holderName;
  String authToken;
  dynamic salesCommissionPercentage;
  dynamic gst;
  String cmFirebaseToken;
  int posStatus;

  factory SellerInfo.fromJson(Map<String, dynamic> json) => SellerInfo(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        image: json["image"],
        email: json["email"],
        password: json["password"],
        status: json["status"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bankName: json["bank_name"],
        branch: json["branch"],
        accountNo: json["account_no"],
        holderName: json["holder_name"],
        authToken: json["auth_token"],
        salesCommissionPercentage: json["sales_commission_percentage"],
        gst: json["gst"],
        cmFirebaseToken: json["cm_firebase_token"],
        posStatus: json["pos_status"],
      );
}

enum AuthToken {
  SW_Z6_AU_IA76_UW_H2_J_QR_YT_GR_IT2_PB_TQE_XC_MFX033_DK_TQ4_S_C_JFXK62
}

enum BankName { K_BANK }

enum Branch { SEOUL_GANGNAM }

enum SellerInfoEmail { SELLER_AF24_COM }

enum SellerInfoFName { JOHN }

enum HolderName { CINDY }

enum SellerInfoImage { THE_2022071362_CEAF08_E03_EF_PNG }

enum SellerInfoLName { DOE }

enum Password {
  THE_2_Y_10_C_POS_Q0_FCTV_ZB_SSU_UBC4_T_0_CBC_ST_S_KGN_V8_JOK_ITQGRH_AYFJ2_K0_C
}

enum RememberToken {
  S_R9_XQTS82_R0_GVVPNCG_LX_TIB_EHXOQF_QO_D0_V9_B_XN_Q_RSU9_UK43_EQZ70_E_NL_DFR_RL
}

enum Status { APPROVED }

class Shop {
  Shop({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.address,
    required this.contact,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.banner,
  });

  int id;
  int sellerId;
  String name;
  String address;
  String contact;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  String banner;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        sellerId: json["seller_id"],
        name: json["name"],
        address: json["address"],
        contact: json["contact"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        banner: json["banner"],
      );
}

enum Address { ABC }

enum Banner { THE_2022071362_CEAF0904772_PNG }

enum ShopImage { THE_2022071362_CEAF0903_CFB_PNG }

enum Name { CHAI_NASHTA }
