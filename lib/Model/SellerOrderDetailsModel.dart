// To parse required this JSON data, do
//
//     final sellerOrderDetailsModel = sellerOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

List<SellerOrderDetailsModel> sellerOrderDetailsModelFromJson(String str) =>
    List<SellerOrderDetailsModel>.from(
        json.decode(str).map((x) => SellerOrderDetailsModel.fromJson(x)));

String sellerOrderDetailsModelToJson(List<SellerOrderDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic shippingMethodId;
  String variant;
  String variation;
  String discountType;
  int isStockDecreased;
  int refundRequest;
  String userEmail;
  String userName;
  String userContact;

  factory SellerOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      SellerOrderDetailsModel(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        sellerId: json["seller_id"],
        productDetails: ProductDetails.fromJson(json["product_details"]),
        qty: json["qty"],
        price: json["price"],
        tax: json["tax"].toDouble(),
        discount: json["discount"].toDouble(),
        deliveryStatus: json["delivery_status"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "seller_id": sellerId,
        "product_details": productDetails.toJson(),
        "qty": qty,
        "price": price,
        "tax": tax,
        "discount": discount,
        "delivery_status": deliveryStatus,
        "payment_status": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "shipping_method_id": shippingMethodId,
        "variant": variant,
        "variation": variation,
        "discount_type": discountType,
        "is_stock_decreased": isStockDecreased,
        "refund_request": refundRequest,
        "user_email": userEmail,
        "user_name": userName,
        "user_contact": userContact,
      };
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
  List<dynamic> variation;
  int published;
  int unitPrice;
  double purchasePrice;
  int tax;
  String taxType;
  int discount;
  String discountType;
  int currentStock;
  String details;
  int freeShipping;
  dynamic attachment;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  int featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int requestStatus;
  dynamic deniedNote;
  int shippingCost;
  int multiplyQty;
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
        variation: List<dynamic>.from(json["variation"].map((x) => x)),
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "added_by": addedBy,
        "user_id": userId,
        "name": name,
        "slug": slug,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x.toJson())),
        "brand_id": brandId,
        "unit": unit,
        "min_qty": minQty,
        "refundable": refundable,
        "images": List<dynamic>.from(images.map((x) => x)),
        "thumbnail": thumbnail,
        "featured": featured,
        "flash_deal": flashDeal,
        "video_provider": videoProvider,
        "video_url": videoUrl,
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "variant_product": variantProduct,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "choice_options": List<dynamic>.from(choiceOptions.map((x) => x)),
        "variation": List<dynamic>.from(variation.map((x) => x)),
        "published": published,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "tax": tax,
        "tax_type": taxType,
        "discount": discount,
        "discount_type": discountType,
        "current_stock": currentStock,
        "details": details,
        "free_shipping": freeShipping,
        "attachment": attachment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "featured_status": featuredStatus,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_image": metaImage,
        "request_status": requestStatus,
        "denied_note": deniedNote,
        "shipping_cost": shippingCost,
        "multiply_qty": multiplyQty,
        "temp_shipping_cost": tempShippingCost,
        "is_shipping_cost_updated": isShippingCostUpdated,
        "reviews_count": reviewsCount,
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
      };
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
