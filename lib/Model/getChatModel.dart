// To parse this JSON data, do
//
//     final getChatModel = getChatModelFromJson(jsonString);

import 'dart:convert';

List<GetChatModel> getChatModelFromJson(String str) => List<GetChatModel>.from(
    json.decode(str).map((x) => GetChatModel.fromJson(x)));

String getChatModelToJson(List<GetChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetChatModel {
  GetChatModel({
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
  dynamic updatedAt;
  int shopId;
  dynamic messageData;
  bool specialMessage;
  SellerInfo sellerInfo;
  Customer customer;
  Shop shop;

  factory GetChatModel.fromJson(Map<String, dynamic> json) => GetChatModel(
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
        updatedAt: json["updated_at"],
        shopId: json["shop_id"],
        messageData: json["message_data"],
        specialMessage: json["special_message"],
        sellerInfo: SellerInfo.fromJson(json["seller_info"]),
        customer: Customer.fromJson(json["customer"]),
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
        "updated_at": updatedAt,
        "shop_id": shopId,
        "message_data": messageData,
        "special_message": specialMessage,
        "seller_info": sellerInfo,
        "customer": customer,
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
  String? fName;
  String? lName;
  String phone;
  String? image;
  String? email;
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
        temporaryToken: json["temporary_token"],
        isEmailVerified: json["is_email_verified"],
        walletBalance: json["wallet_balance"],
        loyaltyPoint: json["loyalty_point"],
        title: json["title"],
        dOB: json["d_o_b"],
        newsletter: json["newsletter"],
        folowed: json["folowed"],
        followedSeller: json["followed_seller"],
      );
}

enum CustomerEmail { ZAIN_GMAIL_COM }

enum CustomerFName { RIDA }

enum FollowedSeller { THE_1 }

enum Folowed { THE_115 }

enum CustomerImage { DEF_PNG }

enum CustomerLName { RIDA }

enum TemporaryToken { EKH_HVNZY_LMI_L_MH_LS_G9_MQ_NE_UZJ_OKNS2_QHMS31_ZZ_GK }

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
  String? fName;
  String? lName;
  String phone;
  String? image;
  String? email;
  String? password;
  String? status;
  String? rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  String? bankName;
  String? branch;
  String accountNo;
  String? holderName;
  String? authToken;
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
  RQNPS3_RABS0_XT4_KZVRQ_YWJZ8_MHT1_L338_AR_KQU_E0_P0_T4_UMTB_IU_Z
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
  THE_0_DH_F9_WT51_K_AZHM_W_RVX_LE_B2_ZJV_NF3_Y_GU8_JT_D_YA_RDCP67_V_HYC8_J_R4_E_DQ_OQGBDV
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
  String? name;
  String? address;
  String contact;
  String? image;
  DateTime createdAt;
  DateTime updatedAt;
  String? banner;

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
