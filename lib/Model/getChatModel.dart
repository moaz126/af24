class GetChatModel {
  GetChatModel({
    this.id,
    required this.userId,
    required this.sellerId,
    required this.message,
    required this.sentByCustomer,
    required this.sentBySeller,
    this.seenByCustomer,
    this.seenBySeller,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.shopId,
    this.specialMessage,
    this.sentTime,
  });

  int? id;
  int userId;
  int sellerId;
  String message;
  int sentByCustomer;
  int sentBySeller;
  int? seenByCustomer;
  int? seenBySeller;
  int? status;
  DateTime? createdAt;
  dynamic updatedAt;
  int? shopId;
  bool? specialMessage;
  String? sentTime;
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
      specialMessage: json["special_message"],
      sentTime: json['sent_time']);
}
