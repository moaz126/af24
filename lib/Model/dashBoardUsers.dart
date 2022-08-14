import 'package:flutter/material.dart';

class dashBoardUsers{
  String title,subtitle, imagepath, time;
  dashBoardUsers({required this.title, required this.subtitle, required this.imagepath,required this.time});

}

List<dashBoardUsers> listofUsers=[
  dashBoardUsers(title: 'Emily Dove',subtitle: 'Yes its possible',imagepath: 'assets/png (2).png',time: '09:00 pm'),
  dashBoardUsers(title: 'Ramin Nasibov',subtitle: 'Yes its possible',imagepath: 'assets/png (3).png',time: '09:00 pm'),
  dashBoardUsers(title: 'Rahabi Khan',subtitle: 'Yes its possible',imagepath: 'assets/png (6).png',time: '09:00 pm'),
  dashBoardUsers(title: 'Lily Dove',subtitle: 'Yes its possible',imagepath: 'assets/png (4).png',time: '09:00 pm'),
  dashBoardUsers(title: 'Miacheal',subtitle: 'Yes its possible',imagepath: 'assets/png (5).png',time: '09:00 pm'),
  dashBoardUsers(title: 'Alina',subtitle: 'Yes its possible',imagepath: 'assets/png (2).png',time: '09:00 pm'),
];

class firstButton{
  int number;
  String first,second;

  firstButton({required this.number, required this.first, required this.second});

}

List<firstButton> fbtn=[
  firstButton(number: 40, first: 'Issued', second: 'Payment Page'),
  firstButton(number: 19, first: 'Order', second: 'Confirmed'),
  firstButton(number: 7, first: 'Out for', second: 'Delivery'),
];