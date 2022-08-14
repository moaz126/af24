import 'package:flutter/cupertino.dart';

class OrderConfirmedDetails{
  final String Image;
  final String DateOfOrder;
  final String UserID;
  final int OrderNo;
  final String Size;
  final String Color;
  final int Qty;
  final int HSCODE;
  final int Price;
  final String Delivery;

  OrderConfirmedDetails({
    required this.Image,
    required this.DateOfOrder,
    required this.UserID,
    required this.OrderNo,
    required this.Size,
    required this.Color,
    required this.Qty,
    required this.HSCODE,
    required this.Price,
    required this.Delivery,
  });
}

List<OrderConfirmedDetails> orderproductdetails = [
  OrderConfirmedDetails(Image: 'assets/png (9).png', DateOfOrder: "16/11/22",UserID: 'ABC123',OrderNo: 560852,Size: 'L',Color: 'black',Qty: 1,HSCODE: 123,Delivery: 'XYZ',Price: 1500),
  OrderConfirmedDetails(Image: 'assets/png (1).png', DateOfOrder: "16/11/22",UserID: 'ABC123',OrderNo: 560852,Size: 'L',Color: 'black',Qty: 1,HSCODE: 123,Delivery: 'XYZ',Price: 1500),
  OrderConfirmedDetails(Image: 'assets/png (8).png', DateOfOrder: "16/11/22",UserID: 'ABC123',OrderNo: 560852,Size: 'L',Color: 'black',Qty: 1,HSCODE: 123,Delivery: 'XYZ',Price: 1500),
];