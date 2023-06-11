import 'package:flutter/material.dart';
import 'package:pocket_business/Styles.dart' as styles;

import '../models/Product.dart';
import '../models/Warehouse.dart';
import '../widgets/ProductCard.dart';
import '../widgets/WarehouseCard.dart';

class GlobalSearchPage extends StatefulWidget {
  List<Warehouse> _productGroups;

  GlobalSearchPage(this._productGroups, {Key? key}) : super(key: key);

  @override
  State<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  FocusNode? inputFieldNode;
  String searchQuery = '';
  List<Warehouse>? _items = [];

  @override
  void initState() {
    super.initState();
    inputFieldNode = FocusNode();
  }

  @override
  void dispose() {
    inputFieldNode!.dispose();
    super.dispose();
  }

  void filterSearchResults(String query) {
    setState(() {
      _items = widget._productGroups
          .where(
              (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: styles.Colors.blue,
          child: SafeArea(
              child: Container(
                  color: styles.Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 15,
                      ),
                      width: double.infinity,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: styles.Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_left_rounded,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Expanded(
                            child: TextFormField(
                              focusNode: inputFieldNode,
                              autofocus: true,
                              initialValue: searchQuery,
                              onFieldSubmitted: (value) {
                                setState(() {
                                  searchQuery = value;
                                  FocusScope.of(context)
                                      .requestFocus(inputFieldNode);
                                  filterSearchResults(searchQuery);
                                });
                              },
                              textInputAction: TextInputAction.search,
                              key: UniqueKey(),
                              keyboardType: TextInputType.text,
                              style: styles.TextStyles.blackText24,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Product Name",
                                filled: true,
                                fillColor: Colors.transparent,
                                hintStyle: styles.TextStyles.blackText24,
                              ),
                              cursorColor: styles.Colors.segmentBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _items?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductGroupCard(
                                    name: _items![index].name,
                                    object: _items?[index].objectId,
                                  );
                                })),
                      ),
                    ),
                  ])))),
    );
  }
}
