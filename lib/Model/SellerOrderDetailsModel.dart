import 'package:af24/Model/ProductlistModel.dart';

class SellerOrderDetailsModel {
  SellerOrderDetailsModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.sellerId,
    required this.productDetails,
    required this.qty,
    required this.price,
    required this.tax,
    required this.discount,
    required this.deliveryStatus,
    required this.orderStatus,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.shippingMethodId,
    required this.variant,
    required this.variation,
    required this.discountType,
    required this.isStockDecreased,
    required this.refundRequest,
    required this.userEmail,
    required this.userName,
    required this.userContact,
    required this.paymentMethod,
    required this.shippingData,
  });

  int id;
  int orderId;
  int productId;
  int sellerId;
  ProductDetails productDetails;
  int qty;
  int price;
  double tax;
  double discount;
  String deliveryStatus;
  String orderStatus;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic shippingMethodId;
  String variant;
  String? variation;
  String? discountType;
  int? isStockDecreased;
  int? refundRequest;
  String userEmail;
  String userName;
  String userContact;
  String paymentMethod;
  ShippingAddressData shippingData;

  factory SellerOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      SellerOrderDetailsModel(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        sellerId: json["seller_id"],
        productDetails: ProductDetails.fromJson(json["product_details"]),
        qty: json["qty"],
        price: json["price"],
        paymentMethod: json["payment_method"],
        tax: json["tax"].toDouble(),
        discount: json["discount"].toDouble(),
        deliveryStatus: json["delivery_status"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        shippingMethodId: json["shipping_method_id"],
        variant: json["variant"],
        variation: json["variation"],
        discountType: json["discount_type"],
        isStockDecreased: json["is_stock_decreased"],
        refundRequest: json["refund_request"],
        userEmail: json["user_email"],
        userName: json["user_name"],
        userContact: json["user_contact"],
        shippingData:
            ShippingAddressData.fromJson(json["shipping_address_data"]),
      );
}

class ProductDetails {
  ProductDetails({
    required this.id,
    required this.addedBy,
    required this.userId,
    required this.name,
    required this.slug,
    required this.categoryIds,
    required this.brandId,
    required this.unit,
    required this.minQty,
    required this.refundable,
    required this.images,
    required this.thumbnail,
    required this.featured,
    required this.flashDeal,
    required this.videoProvider,
    required this.videoUrl,
    required this.colors,
    required this.variantProduct,
    required this.attributes,
    required this.choiceOptions,
    required this.variation,
    required this.published,
    required this.unitPrice,
    required this.purchasePrice,
    required this.tax,
    required this.taxType,
    required this.discount,
    required this.discountType,
    required this.currentStock,
    required this.details,
    required this.freeShipping,
    required this.attachment,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.featuredStatus,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaImage,
    required this.requestStatus,
    required this.deniedNote,
    required this.shippingCost,
    required this.multiplyQty,
    required this.tempShippingCost,
    required this.isShippingCostUpdated,
    required this.reviewsCount,
    required this.translations,
    required this.reviews,
  });

  int id;
  String addedBy;
  int userId;
  String name;
  String slug;
  List<CategoryId> categoryIds;
  int brandId;
  String unit;
  int minQty;
  int refundable;
  List<String> images;
  String thumbnail;
  dynamic featured;
  dynamic flashDeal;
  String videoProvider;
  dynamic videoUrl;
  List<dynamic> colors;
  int variantProduct;
  List<dynamic> attributes;
  List<dynamic> choiceOptions;
  List<Variation> variation;
  int published;
  int unitPrice;
  double purchasePrice;
  int tax;
  dynamic taxType;
  dynamic discount;
  dynamic discountType;
  dynamic currentStock;
  dynamic details;
  dynamic freeShipping;
  dynamic attachment;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  dynamic featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int requestStatus;
  dynamic deniedNote;
  dynamic shippingCost;
  dynamic multiplyQty;
  dynamic tempShippingCost;
  dynamic isShippingCostUpdated;
  int reviewsCount;
  List<dynamic> translations;
  List<dynamic> reviews;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        categoryIds: List<CategoryId>.from(
            json["category_ids"].map((x) => CategoryId.fromJson(x))),
        brandId: json["brand_id"],
        unit: json["unit"],
        minQty: json["min_qty"],
        refundable: json["refundable"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"],
        featured: json["featured"],
        flashDeal: json["flash_deal"],
        videoProvider: json["video_provider"],
        videoUrl: json["video_url"],
        colors: List<dynamic>.from(json["colors"].map((x) => x)),
        variantProduct: json["variant_product"],
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
        variation: List<Variation>.from(
            json["variation"].map((x) => Variation.fromJson(x))),
        published: json["published"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"].toDouble(),
        tax: json["tax"],
        taxType: json["tax_type"],
        discount: json["discount"],
        discountType: json["discount_type"],
        currentStock: json["current_stock"],
        details: json["details"],
        freeShipping: json["free_shipping"],
        attachment: json["attachment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        featuredStatus: json["featured_status"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImage: json["meta_image"],
        requestStatus: json["request_status"],
        deniedNote: json["denied_note"],
        shippingCost: json["shipping_cost"],
        multiplyQty: json["multiply_qty"],
        tempShippingCost: json["temp_shipping_cost"],
        isShippingCostUpdated: json["is_shipping_cost_updated"],
        reviewsCount: json["reviews_count"],
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
      );
}

class CategoryId {
  CategoryId({
    required this.id,
    required this.position,
  });

  String id;
  int position;

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position,
      };
}

class ShippingAddressData {
  ShippingAddressData({
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

  factory ShippingAddressData.fromJson(Map<String, dynamic> json) =>
      ShippingAddressData(
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
