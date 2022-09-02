import 'package:af24/api/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dashBoard.dart';
import 'newBar.dart';

class products extends StatefulWidget {
  final int index;
  products(this.index);

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
  bool chat = true;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1594223274512-ad4803739b7c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=757&q=80',
    'https://images.unsplash.com/photo-1591561954557-26941169b49e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1591561954555-607968c989ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=596&q=80',
    'https://images.unsplash.com/photo-1605733513597-a8f8341084e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=929&q=80',
    'https://images.unsplash.com/photo-1605733513597-a8f8341084e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=929&q=80',
  ];
  int commentNumber = 3;
  final List<String> message = [
    'I really want to buy this',
    'Are you sure',
    'Yes',
    'I will get you the payment link'
  ];
  final List<String> text2 = [
    'L***y',
    'Seller',
  ];

  final List<String> img = [
    'assets/images/alexander-popov-kx1r9Fgqe7s-unsplash.jpg'
  ];
  final controller1 = CarouselController();
  int count = 3;
  int activeIndex = 0;
  int _counter = 0;
  int _counter2 = 0;

  _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: newNavBar(
        index: 2,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 11.0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
               /*  Image.asset(
                  'assets/icons/Seller app icon (6).png',
                  height: 3.7.h,
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      color: Colors.orange[700],
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  padding: EdgeInsets.only(right: 2),
                  //color: Colors.blue,
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.black, fontSize: 8),
                  ),
                ) */
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          child: Column(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            CarouselSlider(
                              carouselController: controller1,
                              items: [
                                for (int i = 0; i < productlistContent[widget.index].images.length; i++)
                                  //1st Image of Slider
                                  Container(
                                    margin: EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0.0),
                                      image: DecorationImage(
                                        image:NetworkImage('http://becknowledge.com/af24/storage/app/public/product/' +
                                              productlistContent[widget.index]
                                                  .images[i],),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              ],

                              //Slider Container properties
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    activeIndex = index;
                                  });
                                },
                                height: 280.0,
                                enlargeCenterPage: true,
                                autoPlay: false,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 1.0,
                              ),
                            ),
                            SizedBox(
                              height: 5.sp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 2.0),
                                        child: Text(
                                          '$_counter',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            _incrementCounter();
                                          },
                                          child: Image.asset(
                                            "assets/icons/Seller app icon (12).png",
                                            height: 17.sp,
                                            color: Colors.grey[500],
                                          )),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '$_counter',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Container(
                                        child: InkWell(
                                            onTap: () {
                                              _incrementCounter();
                                            },
                                            child: Image.asset(
                                              "assets/icons/Seller app icon (13).png",
                                              height: 17.sp,
                                              color: Colors.grey[500],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            AnimatedSmoothIndicator(
                              activeIndex: activeIndex,
                              count: productlistContent[widget.index].images.length,
                              curve: Curves.bounceInOut,
                              effect: SlideEffect(
                                radius: 2,
                                dotHeight: 3,
                                dotWidth: 15,
                                activeDotColor: Colors.black.withOpacity(0.7),
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(productlistContent[widget.index].brandName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 30),
                              textDirection: TextDirection.ltr),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(productlistContent[widget.index].slug.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w400),
                              textDirection: TextDirection.ltr),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Row(
                            children: [
                              Text(productlistContent[widget.index].unitPrice.toString(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textDirection: TextDirection.ltr),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "W",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.lineThrough),
                              )
                            ],
                          ),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/icons/Seller app icon (20).png',
                                height: 23.sp,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("No Exchange No refunds",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 248, 133, 66))),
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/icons/Seller app icon (12).png',
                                height: 23.sp,
                                color: Colors.grey[500],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        child: FlatButton(
                          child: Text(
                            'Contact seller',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          color: Color.fromARGB(255, 0, 0, 0),
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        height: 50,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            "+ More Description".toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Color.fromARGB(255, 124, 123, 123)),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(2)),
                        height: 50,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            "Create Alert for Similar Items",
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Color.fromARGB(255, 124, 123, 123)),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.1),
                        height: 6.h,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Row(
                            children: [
                              Text(
                                "Quality control",
                                style: TextStyle(
                                    fontSize: 13.25.sp,
                                    color: Colors.black.withOpacity(0.4)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,
                                  color: Colors.black.withOpacity(0.4))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text("Seller",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 30),
                              textDirection: TextDirection.ltr),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/Seller app icon (7).png',
                                  height: 9.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 0.1.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Madam Queen " + ('shop').toUpperCase(),
                                        style: TextStyle(fontSize: 2.h),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/Seller app icon (15).png',
                                              height: 2.h,
                                            ),
                                            SizedBox(
                                              width: 0.3.h,
                                            ),
                                            Text("Czech Republic    ",
                                                style: TextStyle(fontSize: 2.h))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 25.w,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Follow"),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Text(
                                "Comment",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 3.h),
                              ),
                            ),
                            alignment: AlignmentDirectional.topStart,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Proceed to payment(2) / Payment completed(5)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 1.2.h,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.5),
                        height: 3.h,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text("L***y",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17.sp),
                                        textDirection: TextDirection.ltr),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 25,
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    "06-15-2022",
                                    style: TextStyle(fontSize: 9.sp),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 32,
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    chat = !chat;
                                  });
                                },
                                child: SizedBox(
                                  width: 60,
                                  child: Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/icons/Seller app icon (16).png',
                                            height: 3.5.h,
                                            color: Colors.grey[700],
                                          ),
                                          Container(
                                            height: 20,
                                            width: 8,
                                            child: Text(
                                              '$commentNumber',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black.withOpacity(0.4),
                                        size: 3.5.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              chat
                  ? Container(
                      color: Colors.grey.withOpacity(0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          for (int i = 0; i < message.length; i++)
                            for (int j = 0; j < text2.length; j++)
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 50, child: Text(text2[j])),
                                    Text(":  "),
                                    SizedBox(
                                        width: 200, child: Text(message[i])),
                                  ],
                                ),
                              ),
                          Padding(
                            padding: const EdgeInsets.only(left: 90.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Buy Now',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left: 10, top: 5),
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.send),
                                hintText: "  Leave the first comment.",
                                hintStyle: TextStyle(color: Colors.white),
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              style: TextStyle(height: 0.1),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 10,
                    ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
