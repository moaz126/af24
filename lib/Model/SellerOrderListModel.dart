// To parse required this JSON data, do
//
//     final sellerOrderListModel = sellerOrderListModelFromJson(jsonString);

import 'dart:convert';

List<SellerOrderListModel> sellerOrderListModelFromJson(String str) => List<SellerOrderListModel>.from(json.decode(str).map((x) => SellerOrderListModel.fromJson(x)));

String sellerOrderListModelToJson(List<SellerOrderListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SellerOrderListModel {
  SellerOrderListModel({
    required this.id,
    required this.customerId,
    required this.customerType,
    required this.paymentStatus,
    required this.orderStatus,
    required this.paymentMethod,
    required this.transactionRef,
    required this.orderAmount,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.discountAmount,
    required this.discountType,
    required this.couponCode,
    required this.shippingMethodId,
    required this.shippingCost,
    required this.orderGroupId,
    required this.verificationCode,
    required this.sellerId,
    required this.sellerIs,
    required this.shippingAddressData,
    required this.deliveryManId,
    required this.orderNote,
    required this.billingAddress,
    required this.billingAddressData,
    required this.orderType,
    required this.extraDiscount,
    required this.extraDiscountType,
    required this.checked,
    required this.shippingType,
    required this.deliveryType,
    required this.deliveryServiceName,
    required this.thirdPartyDeliveryTrackingId,
    required this.customer,
    required this.shipping,
  });

  int? id;
  int? customerId;
  String? customerType;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  String? transactionRef;
  double? orderAmount;
  int? shippingAddress;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? discountAmount;
  dynamic? discountType;
  String? couponCode;
  int? shippingMethodId;
  int? shippingCost;
  String? orderGroupId;
  String? verificationCode;
  int? sellerId;
  String? sellerIs;
  String? shippingAddressData;
  dynamic? deliveryManId;
  dynamic? orderNote;
  int? billingAddress;
  BillingAddressData? billingAddressData;
  String? orderType;
  int? extraDiscount;
  dynamic? extraDiscountType;
  int? checked;
  String? shippingType;
  String? deliveryType;
  String? deliveryServiceName;
  String? thirdPartyDeliveryTrackingId;
  Customer? customer;
  Shipping? shipping;

  factory SellerOrderListModel.fromJson(Map<String, dynamic> json) => SellerOrderListModel(
    id: json["id"],
    customerId: json["customer_id"],
    customerType: json["customer_type"],
    paymentStatus: json["payment_status"],
    orderStatus: json["order_status"],
    paymentMethod: json["payment_method"],
    transactionRef: json["transaction_ref"],
    orderAmount: json["order_amount"].toDouble(),
    shippingAddress: json["shipping_address"] == null ? null : json["shipping_address"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    discountAmount: json["discount_amount"],
    discountType: json["discount_type"],
    couponCode: json["coupon_code"] == null ? null : json["coupon_code"],
    shippingMethodId: json["shipping_method_id"],
    shippingCost: json["shipping_cost"],
    orderGroupId: json["order_group_id"],
    verificationCode: json["verification_code"],
    sellerId: json["seller_id"],
    sellerIs: json["seller_is"],
    shippingAddressData: json["shipping_address_data"] == null ? null : json["shipping_address_data"],
    deliveryManId: json["delivery_man_id"],
    orderNote: json["order_note"],
    billingAddress: json["billing_address"] == null ? null : json["billing_address"],
    billingAddressData: json["billing_address_data"] == null ? null : BillingAddressData.fromJson(json["billing_address_data"]),
    orderType: json["order_type"],
    extraDiscount: json["extra_discount"],
    extraDiscountType: json["extra_discount_type"],
    checked: json["checked"],
    shippingType: json["shipping_type"],
    deliveryType: json["delivery_type"] == null ? null : json["delivery_type"],
    deliveryServiceName: json["delivery_service_name"] == null ? null : json["delivery_service_name"],
    thirdPartyDeliveryTrackingId: json["third_party_delivery_tracking_id"] == null ? null : json["third_party_delivery_tracking_id"],
    customer: Customer.fromJson(json["customer"]),
    shipping: json["shipping"] == null ? null : Shipping.fromJson(json["shipping"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "customer_type": customerType,
    "payment_status": paymentStatus,
    "order_status": orderStatus,
    "payment_method": paymentMethod,
    "transaction_ref": transactionRef,
    "order_amount": orderAmount,
    "shipping_address": shippingAddress == null ? null : shippingAddress,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "discount_amount": discountAmount,
    "discount_type": discountType,
    "coupon_code": couponCode == null ? null : couponCode,
    "shipping_method_id": shippingMethodId,
    "shipping_cost": shippingCost,
    "order_group_id": orderGroupId,
    "verification_code": verificationCode,
    "seller_id": sellerId,
    "seller_is": sellerIs,
    "shipping_address_data": shippingAddressData == null ? null : shippingAddressData,
    "delivery_man_id": deliveryManId,
    "order_note": orderNote,
    "billing_address": billingAddress == null ? null : billingAddress,
    "billing_address_data": billingAddressData == null ? null : billingAddressData!.toJson(),
    "order_type": orderType,
    "extra_discount": extraDiscount,
    "extra_discount_type": extraDiscountType,
    "checked": checked,
    "shipping_type": shippingType,
    "delivery_type": deliveryType == null ? null : deliveryType,
    "delivery_service_name": deliveryServiceName == null ? null : deliveryServiceName,
    "third_party_delivery_tracking_id": thirdPartyDeliveryTrackingId == null ? null : thirdPartyDeliveryTrackingId,
    "customer": customer!.toJson(),
    "shipping": shipping == null ? null : shipping!.toJson(),
  };
}

class BillingAddressData {
  BillingAddressData({
    required this.id,
    required this.customerId,
    required this.contactPersonName,
    required this.addressType,
    required this.address,
    required this.city,
    required this.zip,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.isBilling,
  });

  int id;
  int customerId;
  String contactPersonName;
  String addressType;
  String address;
  String city;
  String zip;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic state;
  dynamic country;
  String latitude;
  String longitude;
  int isBilling;

  factory BillingAddressData.fromJson(Map<String, dynamic> json) => BillingAddressData(
    id: json["id"],
    customerId: json["customer_id"],
    contactPersonName: json["contact_person_name"],
    addressType: json["address_type"],
    address: json["address"],
    city: json["city"],
    zip: json["zip"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    state: json["state"],
    country: json["country"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isBilling: json["is_billing"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "contact_person_name": contactPersonName,
    "address_type": addressType,
    "address": address,
    "city": city,
    "zip": zip,
    "phone": phone,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "state": state,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
    "is_billing": isBilling,
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
  });

  int? id;
  dynamic? name;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  dynamic? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? streetAddress;
  dynamic? country;
  dynamic? city;
  dynamic? zip;
  dynamic? houseNo;
  dynamic? apartmentNo;
  dynamic? cmFirebaseToken;
  int? isActive;
  dynamic? paymentCardLastFour;
  dynamic? paymentCardBrand;
  dynamic? paymentCardFawryToken;
  dynamic? loginMedium;
  dynamic? socialId;
  int? isPhoneVerified;
  String? temporaryToken;
  int? isEmailVerified;
  dynamic? walletBalance;
  dynamic? loyaltyPoint;
  String? title;
  String? dOB;
  String? newsletter;
  dynamic? folowed;

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
    temporaryToken: json["temporary_token"] == null ? null : json["temporary_token"],
    isEmailVerified: json["is_email_verified"],
    walletBalance: json["wallet_balance"],
    loyaltyPoint: json["loyalty_point"],
    title: json["title"],
    dOB: json["d_o_b"],
    newsletter: json["newsletter"],
    folowed: json["folowed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "f_name": fName,
    "l_name": lName,
    "phone": phone,
    "image": image,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "street_address": streetAddress,
    "country": country,
    "city": city,
    "zip": zip,
    "house_no": houseNo,
    "apartment_no": apartmentNo,
    "cm_firebase_token": cmFirebaseToken,
    "is_active": isActive,
    "payment_card_last_four": paymentCardLastFour,
    "payment_card_brand": paymentCardBrand,
    "payment_card_fawry_token": paymentCardFawryToken,
    "login_medium": loginMedium,
    "social_id": socialId,
    "is_phone_verified": isPhoneVerified,
    "temporary_token": temporaryToken == null ? null : temporaryToken,
    "is_email_verified": isEmailVerified,
    "wallet_balance": walletBalance,
    "loyalty_point": loyaltyPoint,
    "title": title,
    "d_o_b": dOB,
    "newsletter": newsletter,
    "folowed": folowed,
  };
}

class Shipping {
  Shipping({
    required this.id,
    required this.creatorId,
    required this.creatorType,
    required this.title,
    required this.cost,
    required this.duration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int creatorId;
  String creatorType;
  String title;
  int cost;
  String duration;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Shipping.fromJson(Map<String, dynamic> json) => Shipping(
    id: json["id"],
    creatorId: json["creator_id"],
    creatorType: json["creator_type"],
    title: json["title"],
    cost: json["cost"],
    duration: json["duration"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "creator_id": creatorId,
    "creator_type": creatorType,
    "title": title,
    "cost": cost,
    "duration": duration,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
