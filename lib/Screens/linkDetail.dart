import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/orderDetail.dart';
import 'package:af24/api/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:sizer/sizer.dart';

import '../api/auth_af24.dart';
import '../constants.dart';
import '../localization/languages/languages.dart';

class linkDetail extends StatefulWidget {
  final int index;
  linkDetail(this.index);

  @override
  State<linkDetail> createState() => _linkDetailState();
}

class _linkDetailState extends State<linkDetail> {
  bool loader = false;

  TextEditingController _textFieldController = TextEditingController();
  callApi() async {
    setState(() {
      loader = true;
    });
    Map<String, dynamic> getuser = {
      'product_id': productlistContent[widget.index].id.toString()
    };
    // await DataApiService.instance.getSecretUser(getuser, context);
    await DataApiService.instance.getlinkUsers(getuser, context);
/* 
    await DataApiService.instance
        .getAllLinks(productLinks[widget.index].id.toString(), context); */

    setState(() {
      loader = false;
    });
  }

  bool reason = false;

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  bool loaderAlert = false;
  final spinkitalert = SpinKitSpinningLines(
    size: 2.h,
    color: Colors.black,
  );
  bool loaderAccept = false;
  final spinkitAlert = SpinKitSpinningLines(
    size: 2.h,
    color: Colors.black,
  );
  bool loaderReject = false;
  final spinkitReject = SpinKitSpinningLines(
    size: 2.h,
    color: Colors.black,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Offer Detail',
            style: const TextStyle(color: Colors.black),
          ),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          centerTitle: true,
        ),
        body: loader
            ? spinkit
            : getlinkuser.isEmpty
                ? Center(child: Text(Languages.of(context)!.NO_LINKS))
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: HorizontalDataTable(
                          leftHandSideColumnWidth: 80,
                          rightHandSideColumnWidth: 750,
                          isFixedHeader: true,
                          headerWidgets: _getTitleWidget(),
                          leftSideItemBuilder: _generateFirstColumnRow,
                          rightSideItemBuilder: _generateRightHandSideColumnRow,
                          itemCount: getlinkuser.length,
                          rowSeparatorWidget: const Divider(
                            color: Colors.black54,
                            height: 1.0,
                            thickness: 0.0,
                          ),
                          leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                          rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ));
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(Languages.of(context)!.LINK_NO, 100),
      _getTitleItemWidget(Languages.of(context)!.DATE_OF_ORDER, 100),
      _getTitleItemWidget(Languages.of(context)!.CUSTOMER_NAME, 150),
      _getTitleItemWidget(Languages.of(context)!.PRICE, 100),
      _getTitleItemWidget('Quantity', 100),
      _getTitleItemWidget('Size', 100),
      _getTitleItemWidget('Color', 100),
      _getTitleItemWidget('Status', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Center(
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Center(child: Text('${index + 1}')),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                    getlinkuser[index].updatedAt.toString().substring(0, 10)),
              ))
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Center(child: Text(getlinkuser[index].userName.toString())),
          width: 150,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(child: Text(getlinkuser[index].price.toString())),
        ),
        Container(
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(child: Text(getlinkContent[index].quantity.toString())),
        ),
        Container(
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: getlinkuser[index].size == null
                  ? Text('-')
                  : Text(getlinkuser[index].size.toString())),
        ),
        Container(
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
          child: Center(
              child: Container(
            height: 20,
            width: 20,
            color: HexColor(getlinkuser[index].color),
          )),
        ),
        Container(
          // ignore: sort_child_properties_last
          child: Center(
            child: /* ElevatedButton(
              onPressed: () async {
                _textFieldController.text =
                    getlinkContent[index].priceSetBySeller.toString();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: Text(Languages.of(context)!.EDIT_PRICE),
                        content: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          controller: _textFieldController,
                          decoration: const InputDecoration(
                            hintText: "0.00 €",
                          ),
                        ),
                        actions: [
                          FlatButton(
                            textColor: Colors.black,
                            onPressed: () async {
                              setState(() {
                                loaderAlert = true;
                              });

                              await DataApiService.instance.updateLink(
                                  getlinkContent[index].id.toString(),
                                  _textFieldController.text,
                                  context);
                              setState(() {
                                // sizepicker = true;
                                loaderAlert = false;
                              });
                              GlobalSnackBar.show(context, snackmessage);
                              /* 
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            linkDetail(widget.index))); */
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          linkDetail(widget.index)));
                              // Get.off(linkDetail(widget.index));
                            },
                            child: Container(
                                height: 20,
                                width: 50,
                                child: loaderAlert
                                    ? spinkitalert
                                    : Text(Languages.of(context)!.UPDATE)),
                          ),
                        ],
                      );
                    });
                  },
                );
              },
              child: Text(
                'Edit',
                style: TextStyle(color: Colors.white, fontSize: 11.sp),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
            ), */
                getlinkuser[index].requestStatus == '2'
                    ? Padding(
                        padding: const EdgeInsets.only(right: 7.0),
                        child: Text('Offer Accepted'),
                      )
                    : getlinkuser[index].requestStatus == '3'
                        ? Padding(
                            padding: const EdgeInsets.only(right: 7.0),
                            child: Text('Offer Rejected'),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return AlertDialog(
                                      title: const Text('Offered Price  '),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('Price'),
                                                Text(
                                                    /* getlinkuser[index]
                                                                              .price */
                                                    '50')
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('Name'),
                                                Text(getlinkuser[index]
                                                    .userName
                                                    .toString())
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('Quantity'),
                                                Text(getlinkuser[index]
                                                    .quantity
                                                    .toString())
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('Size'),
                                                Text(getlinkuser[index].size ==
                                                        null
                                                    ? '--'
                                                    : getlinkuser[index]
                                                        .size
                                                        .toString())
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text('Color'),
                                                Container(
                                                  height: 20,
                                                  width: 20,
                                                  color: HexColor(
                                                      getlinkuser[index].color),
                                                )
                                              ],
                                            ),
                                            reason
                                                ? TextField(
                                                    onChanged: (value) {},
                                                    controller:
                                                        _textFieldController,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: "Reason",
                                                    ),
                                                  )
                                                : SizedBox()
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        reason
                                            ? FlatButton(
                                                textColor: Colors.black,
                                                onPressed: () async {
                                                  if (_textFieldController
                                                      .text.isNotEmpty) {
                                                    setState(() {
                                                      loaderReject = true;
                                                    });
                                                    Map<String, dynamic>
                                                        sendlink = {
                                                      'request_id':
                                                          getlinkuser[index]
                                                              .id
                                                              .toString(),
                                                      'request_status': '3',
                                                      'reject_reason':
                                                          _textFieldController
                                                              .text,
                                                    };
                                                    await DataApiService
                                                        .instance
                                                        .sendLink(
                                                            sendlink, context);
                                                    setState(() {
                                                      loaderReject = false;
                                                      // sizepicker = true;
                                                    });
                                                    GlobalSnackBar.show(
                                                        context, snackmessage);

                                                    _textFieldController
                                                        .clear();
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                linkDetail(widget
                                                                    .index)));
                                                    reason = false;
                                                  }
                                                },
                                                child: Container(
                                                  height: 20,
                                                  width: 40,
                                                  child: loaderReject
                                                      ? spinkitAlert
                                                      : Text('Send'),
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  FlatButton(
                                                    textColor: Colors.black,
                                                    onPressed: () async {
                                                      setState(() {
                                                        loaderAlert = true;
                                                      });
                                                      Map<String, dynamic>
                                                          sendlink = {
                                                        'request_id':
                                                            getlinkuser[index]
                                                                .id
                                                                .toString(),
                                                        'request_status': '2'
                                                      };
                                                      await DataApiService
                                                          .instance
                                                          .sendLink(sendlink,
                                                              context);
                                                      setState(() {
                                                        loaderAlert = false;
                                                        // sizepicker = true;
                                                      });
                                                      GlobalSnackBar.show(
                                                          context,
                                                          snackmessage);

                                                      Navigator.pop(context);
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  linkDetail(widget
                                                                      .index)));
                                                    },
                                                    child: Container(
                                                      height: 20,
                                                      width: 45,
                                                      child: loaderAlert
                                                          ? spinkitAlert
                                                          : Text('Accept'),
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    textColor: Colors.black,
                                                    onPressed: () async {
                                                      setState(() {
                                                        reason = true;
                                                      });
                                                      /*   setState(
                                                                          () {
                                                                        loaderAlert =
                                                                            true;
                                                                      });
                                                                      Map<String,
                                                                              dynamic>
                                                                          sendlink =
                                                                          {
                                                                        'price':
                                                                            _textFieldController.text,
                                                                        'request_id': getlinkuser[index]
                                                                            .id
                                                                            .toString()
                                                                      };
                                                                      await DataApiService
                                                                          .instance
                                                                          .sendLink(
                                                                              sendlink,
                                                                              context);
                                                                      setState(
                                                                          () {
                                                                        loaderAlert =
                                                                            false;
                                                                        // sizepicker = true;
                                                                      });
                                                                      GlobalSnackBar.show(
                                                                          context,
                                                                          snackmessage);
 */
                                                      /*   Navigator.of(
                                                                              context,
                                                                              rootNavigator: true)
                                                                          .pop(); */
                                                    },
                                                    child: Container(
                                                      height: 20,
                                                      width: 40,
                                                      child: Text('Reject'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                      ],
                                    );
                                  });
                                },
                              );
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            child: const Text(
                              'Offer Detail',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
