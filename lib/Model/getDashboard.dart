class GetDashboardModel {
  GetDashboardModel({
    required this.confirmOrder,
    required this.cancelledOrder,
    required this.returnedOrder,
    required this.outForDelivery,
    required this.delieved,
    required this.pending,
    required this.xAxis,
    required this.yAxis,
    required this.issued_payment_count,
    required this.processing_count,
  });

  int confirmOrder;
  int cancelledOrder;
  int returnedOrder;
  int outForDelivery;
  int pending;
  int issued_payment_count;
  int processing_count;
  dynamic delieved;
  List<String> xAxis;
  List<int> yAxis;

  factory GetDashboardModel.fromJson(Map<String, dynamic> json) =>
      GetDashboardModel(
        confirmOrder: json["confirm order"],
        cancelledOrder: json["cancelled order"],
        returnedOrder: json["returned order"],
        outForDelivery: json["out for delivery"],
        delieved: json["delivered"],
        pending: json["pedning order"],
        issued_payment_count: json["issued_payment_count"],
        processing_count: json["processing_order"],
        xAxis: List<String>.from(json["x-axis"].map((x) => x)),
        yAxis: List<int>.from(json["y-axis"].map((x) => x)),
      );
}
