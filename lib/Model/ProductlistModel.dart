import 'dart:convert';

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
    required this.size,
    required this.subName,
    required this.reviewsCount,
    required this.categoryName,
    required this.brandName,
    required this.translations,
    required this.reviews,
    required this.subCategoryName,
    required this.likes,
    required this.comments,
    required this.colorsList,
    required this.wholesalePrice,
  });

  int id;
  dynamic addedBy;
  int userId;
  String name;
  String slug;
  List<CategoryIds> categoryIds;
  int brandId;
  dynamic unit;
  int minQty;
  int refundable;
  List<dynamic> images;
  String thumbnail;
  int? featured;
  dynamic flashDeal;
  dynamic videoProvider;
  dynamic videoUrl;
  dynamic colors;
  int variantProduct;
  dynamic attributes;
  dynamic choiceOptions;
  List<Variation> variation;
  int published;
  int unitPrice;
  double purchasePrice;
  dynamic priceType;
  double tax;
  String? taxType;
  double discount;
  String? discountType;
  int? currentStock;
  String? details;
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
  dynamic size;
  String subName;
  int reviewsCount;
  dynamic categoryName;
  String brandName;
  List<dynamic> translations;
  List<Review> reviews;
  String? subCategoryName;
  int? likes;
  int? comments;
  List<ColorsList> colorsList;
  dynamic wholesalePrice;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        addedBy: json["added_by"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        categoryIds: List<CategoryIds>.from(
            json["category_ids"].map((x) => CategoryIds.fromJson(x))),
        brandId: json["brand_id"],
        unit: json["unit"],
        minQty: json["min_qty"],
        refundable: json["refundable"],
        images: jsonDecode(json["images"]),
        thumbnail: json["thumbnail"],
        featured: json["featured"] == null ? null : json["featured"],
        flashDeal: json["flash_deal"],
        videoProvider: json["video_provider"],
        videoUrl: json["video_url"],
        colors: jsonDecode(json["colors"]),
        variantProduct: json["variant_product"],
        attributes: json["attributes"],
        choiceOptions: json["choice_options"],
        variation: List<Variation>.from(
            json["variation"].map((x) => Variation.fromJson(x))),
        published: json["published"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"].toDouble(),
        priceType: json["price_type"],
        tax: json["tax"].toDouble(),
        taxType: json["tax_type"] == null ? null : json["tax_type"],
        discount: json["discount"].toDouble(),
        discountType:
            json["discount_type"] == null ? null : json["discount_type"],
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
        size: json["size"] == null ? null : json["size"],
        subName: json["sub_name"],
        reviewsCount: json["reviews_count"],
        categoryName: json["category_name"],
        brandName: json["brand_name"],
        likes: json["likes"],
        comments: json["comments"],
        translations: List<dynamic>.from(json["translations"].map((x) => x)),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        subCategoryName: json["sub_category_name"] == null
            ? null
            : json["sub_category_name"],
        colorsList: List<ColorsList>.from(
            json["colorsList"].map((x) => ColorsList.fromJson(x))),
        wholesalePrice: json["wholesale_price"],
      );
}

class Review {
  Review({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.comment,
    required this.attachment,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int productId;
  int customerId;
  String comment;
  dynamic attachment;
  int rating;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        productId: json["product_id"],
        customerId: json["customer_id"],
        comment: json["comment"],
        attachment: json["attachment"],
        rating: json["rating"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class Variation {
  Variation({
    required this.type,
    required this.price,
    required this.sku,
    required this.qty,
  });

  String type;
  int price;
  dynamic sku;
  dynamic qty;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        type: json["type"],
        price: json["price"],
        sku: json["sku"] == null ? null : json["sku"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
        "sku": sku == null ? null : sku,
        "qty": qty,
      };
}

class CategoryIds {
  CategoryIds({
    required this.id,
    required this.position,
  });

  dynamic id;
  dynamic position;

  factory CategoryIds.fromJson(Map<String, dynamic> json) => CategoryIds(
        id: json["id"],
        position: json["position"],
      );
}

class ColorsList {
  ColorsList({
    required this.id,
    required this.name,
    required this.code,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String code;
  dynamic userId;
  DateTime createdAt;
  DateTime updatedAt;

  factory ColorsList.fromJson(Map<String, dynamic> json) => ColorsList(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
