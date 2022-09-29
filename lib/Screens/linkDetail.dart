import 'package:af24/Screens/navBar.dart';
import 'package:af24/Screens/orderDetail.dart';
import 'package:af24/api/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:sizer/sizer.dart';

import '../api/auth_af24.dart';
import '../constants.dart';

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

    await DataApiService.instance
        .getAllLinks(productLinks[widget.index].id.toString(), context);

    setState(() {
      loader = false;
    });
  }

  final spinkit = SpinKitSpinningLines(
    size: 5.h,
    color: Colors.black,
  );
  bool loaderAlert = false;
  final spinkitalert = SpinKitSpinningLines(
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
            'Edit Payment Link',
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
            : getlinkContent.isEmpty
                ? Center(child: Text('No Links Found'))
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: HorizontalDataTable(
                          leftHandSideColumnWidth: 80,
                          rightHandSideColumnWidth: 450,
                          isFixedHeader: true,
                          headerWidgets: _getTitleWidget(),
                          leftSideItemBuilder: _generateFirstColumnRow,
                          rightSideItemBuilder: _generateRightHandSideColumnRow,
                          itemCount: getlinkContent.length,
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
      _getTitleItemWidget('Link No.', 100),
      _getTitleItemWidget('Date of Order', 100),
      _getTitleItemWidget('Customer Name', 150),
      _getTitleItemWidget('Price', 100),
      _getTitleItemWidget('Edit', 100),
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
                child: Text(getlinkContent[index]
                    .updatedAt
                    .toString()
                    .substring(0, 10)),
              ))
            ],
          ),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Center(child: Text(getlinkContent[index].userName)),
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
          child: Center(
              child: Text(getlinkContent[index].priceSetBySeller.toString())),
        ),
        Container(
          // ignore: sort_child_properties_last
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                _textFieldController.text =
                    getlinkContent[index].priceSetBySeller.toString();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: const Text('Enter Price in €'),
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
                                    : Text('Update')),
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
