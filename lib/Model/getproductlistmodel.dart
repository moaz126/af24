// To parse this JSON data, do
//
//     final getProductListModel = getProductListModelFromJson(jsonString);

import 'dart:convert';

GetProductListModel getProductListModelFromJson(String str) =>
    GetProductListModel.fromJson(json.decode(str));

String getProductListModelToJson(GetProductListModel data) =>
    json.encode(data.toJson());

class GetProductListModel {
  GetProductListModel({
    required this.list,
    required this.imagesPath,
    required this.thumbnailPath,
  });

  List<ListElement> list;
  String imagesPath;
  String thumbnailPath;

  factory GetProductListModel.fromJson(Map<String, dynamic> json) =>
      GetProductListModel(
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        imagesPath: json["images_path"],
        thumbnailPath: json["thumbnail_path"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "images_path": imagesPath,
        "thumbnail_path": thumbnailPath,
      };
}

class ListElement {
  ListElement({
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
    required this.priceType,
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
    required this.subName,
    required this.reviewsCount,
    required this.translations,
    required this.reviews,
  });

  int id;
  String addedBy;
  int userId;
  String name;
  String slug;
  String categoryIds;
  int brandId;
  String unit;
  int minQty;
  int refundable;
  String images;
  String thumbnail;
  dynamic featured;
  dynamic flashDeal;
  String videoProvider;
  dynamic videoUrl;
  String colors;
  int variantProduct;
  String attributes;
  String choiceOptions;
  String variation;
  int published;
  int unitPrice;
  int purchasePrice;
  String priceType;
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
  String metaTitle;
  String metaDescription;
  String metaImage;
  int requestStatus;
  dynamic deniedNote;
  int shippingCost;
  int multiplyQty;
  dynamic tempShippingCost;
  dynamic isShippingCostUpdated;
  String subName;
  int reviewsCount;
  List<dynamic> translations;
  List<dynamic> reviews;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        categoryIds: json["category_ids"],
        brandId: json["brand_id"],
        unit: json["unit"],
        minQty: json["min_qty"],
        refundable: json["refundable"],
        images: json["images"],
        thumbnail: json["thumbnail"],
        featured: json["featured"],
        flashDeal: json["flash_deal"],
        videoProvider: json["video_provider"],
        videoUrl: json["video_url"],
        colors: json["colors"],
        variantProduct: json["variant_product"],
        attributes: json["attributes"],
        choiceOptions: json["choice_options"],
        variation: json["variation"],
        published: json["published"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        priceType: json["price_type"],
        tax: json["tax"],
        taxType: json["tax_type"] == null ? null : json["tax_type"],
        discount: json["discount"],
        discountType: json["discount_type"],
        currentStock:
            json["current_stock"] == null ? null : json["current_stock"],
        details: json["details"],
        freeShipping: json["free_shipping"],
        attachment: json["attachment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        featuredStatus: json["featured_status"],
        metaTitle: json["meta_title"] == null ? null : json["meta_title"],
        metaDescription:
            json["meta_description"] == null ? null : json["meta_description"],
        metaImage: json["meta_image"] == null ? null : json["meta_image"],
        requestStatus: json["request_status"],
        deniedNote: json["denied_note"],
        shippingCost: json["shipping_cost"],
        multiplyQty: json["multiply_qty"],
        tempShippingCost: json["temp_shipping_cost"],
        isShippingCostUpdated: json["is_shipping_cost_updated"],
        subName: json["sub_name"],
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
        "category_ids": categoryIds,
        "brand_id": brandId,
        "unit": unit,
        "min_qty": minQty,
        "refundable": refundable,
        "images": images,
        "thumbnail": thumbnail,
        "featured": featured,
        "flash_deal": flashDeal,
        "video_provider": videoProvider,
        "video_url": videoUrl,
        "colors": colors,
        "variant_product": variantProduct,
        "attributes": attributes,
        "choice_options": choiceOptions,
        "variation": variation,
        "published": published,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "price_type": priceType,
        "tax": tax,
        "tax_type": taxType == null ? null : taxType,
        "discount": discount,
        "discount_type": discountType,
        "current_stock": currentStock == null ? null : currentStock,
        "details": details,
        "free_shipping": freeShipping,
        "attachment": attachment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "featured_status": featuredStatus,
        "meta_title": metaTitle == null ? null : metaTitle,
        "meta_description": metaDescription == null ? null : metaDescription,
        "meta_image": metaImage == null ? null : metaImage,
        "request_status": requestStatus,
        "denied_note": deniedNote,
        "shipping_cost": shippingCost,
        "multiply_qty": multiplyQty,
        "temp_shipping_cost": tempShippingCost,
        "is_shipping_cost_updated": isShippingCostUpdated,
        "sub_name": subName,
        "reviews_count": reviewsCount,
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
      };
}
