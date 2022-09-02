/*       Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: Colors.black12, width: 1.8)),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: DropdownButtonFormField(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              icon: Icon(Icons.keyboard_arrow_down),
                              hint: Text('Category'),
                              // value: dropdownvalue,
                              items: catergorylist.map((CategoryModel item) {
                                return DropdownMenuItem(
                                  value: item.id.toString(),
                                  child: Text(
                                    item.name,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  showsub = true;
                                  print(newValue);
                                  dropdownvalue = newValue;
                                  for (var model in catergorylist) {
                                    print("hello");
                                    print(model.id);
                                    if (model.id.toString() ==
                                        newValue.toString()) {
                                      print('in if');
                                      setState(() {
                                        subcat = model;
                                      });
                                    }
                                  }
                                  // subcat = newValue;
                                  // print('category');
                                  // print(subcat!.id);
                                  // print(subcat!.name);
                                  // value = subcat!.id;
                                  // print(value);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      showsub == true
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                height: 40,
                                width: MediaQuery.of(context).size.width / 2.3,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black12, width: 1.8)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    hint: Text('Sub Category'),
                                    value: dropdown2,
                                    items: subcat!.subCategories
                                        .map((CategoryModel item) {
                                      return DropdownMenuItem(
                                        value: item.name.toString(),
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdown2 = newValue!;
                                        subcat = newValue as CategoryModel?;
                                        print('subcategory');
                                        subvalue = subcat!.id;
                                        print(subvalue);

                                        print(subvalue);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                ), */