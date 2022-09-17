import 'package:af24/Screens/chatNotification.dart';
import 'package:af24/Screens/dashBoard.dart';
import 'package:af24/Screens/OrdersList.dart';
import 'package:af24/Screens/MyProducts.dart';
import 'package:af24/Screens/uploadProduct.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class navBar extends StatefulWidget {
  navBar({Key? key, required this.index, required this.see}) : super(key: key);
  final int index;
  final int see;

  @override
  _navBarState createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  late var screens;
  int index = 0;
  int see = 1;
  int _selectedIndex = -1;

  @override
  void initState() {
    see = widget.see;
    index = widget.index;
    screens = [
      dashBoard(),
      newsFeedMain(),
      uploadProduct(),
      chatNotification(),
      newOrderConfirmed(),
    ];
    _selectedIndex = index;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: see == 1 ? dashBoard() : screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            see = 0;
            index = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(.60),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: index == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset('assets/icons/home.png',
                                height: 3.h),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset('assets/icons/home-1.png',
                                height: 3.h),
                          ),
                  ),
                  Text('Home')
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: index == 1
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset('assets/icons/Document.png',
                                height: 3.h),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset('assets/icons/Document-1.png',
                                height: 3.h),
                          ),
                  ),
                  Text('Products')
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: index == 2
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset('assets/icons/plus.png',
                                height: 3.h),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset('assets/icons/plus-1.png',
                                height: 3.h),
                          ),
                  ),
                  Text('Sell')
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: index == 3
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                  'assets/icons/Notification.png',
                                  height: 3.h),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                  'assets/icons/Notification-1.png',
                                  height: 3.h),
                            )),
                  Text('Notification')
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: index == 4
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset('assets/icons/My Page.png',
                                  height: 3.h),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset('assets/icons/My Page-1.png',
                                  height: 3.h),
                            )),
                  Text('My page')
                ],
              ),
              label: ''),
        ],
      ),
    );
  }
}
