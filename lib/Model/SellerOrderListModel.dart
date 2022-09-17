
import 'getUserChat.dart';

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
  dynamic discountType;
  String? couponCode;
  int? shippingMethodId;
  int? shippingCost;
  String? orderGroupId;
  String? verificationCode;
  int? sellerId;
  String? sellerIs;
  String? shippingAddressData;
  dynamic deliveryManId;
  dynamic orderNote;
  int? billingAddress;
  BillingAddressData? billingAddressData;
  String? orderType;
  int? extraDiscount;
  dynamic extraDiscountType;
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

}
