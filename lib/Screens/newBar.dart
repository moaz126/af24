import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/MyProducts.dart';
import 'package:af24/Screens/productDetail.dart';
import 'package:af24/Screens/uploadProduct.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'chatNotification.dart';
import 'dashBoard.dart';
import 'OrdersList.dart';

class newNavBar extends StatefulWidget {
  int index = -1;

  newNavBar({this.index = -1});

  @override
  _newNavBarState createState() => _newNavBarState();
}

class _newNavBarState extends State<newNavBar> {
  int _selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    _selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => navBar(
                    index: index,
                    see: 0,
                  )));
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(.60),
        selectedFontSize: 7,
        unselectedFontSize: 7,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: _selectedIndex == 1
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
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: _selectedIndex == 2
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
                  Text(
                    'Products',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: _selectedIndex == 3
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
                  Text(
                    'Sell',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: _selectedIndex == 4
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
                  Text(
                    'Notification',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: _selectedIndex == 5
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
                  Text(
                    'My Orders',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              label: ''),
        ]);
  }
}
