import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocket_business/Styles.dart';
import 'package:pocket_business/screens/SearchProduct.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../models/Product.dart';
import '../services/ServerManager.dart';
import '../Styles.dart' as styles;
import '../widgets/ProductCard.dart';
import 'NewProductPage.dart';

class ProductGroupPage extends StatefulWidget {
  final String? name;
  final String? object;
  ProductGroupPage( this.object, this.name, {Key? key,});
  @override
  _ProductGroupPageState createState() => _ProductGroupPageState();
}

class _ProductGroupPageState extends State<ProductGroupPage> {
  final List<Product> _productGroups  = [];
  @override
  void initState(){
    ServerManager(context).getProductsRequest(widget.object!, (body) {

      print(body);
      _productGroups.addAll(body);
      setState(() {

      });

    }, (errorCode) { });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
                    var result = res;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return NewProductPage(
                            group: widget.name,
                            ware:  widget.object,
                            barcode: result
                          );
                        },
                      ),
                    ).then((value) => setState((){}));
                  }
                }
            );
          },
          splashColor: styles.Colors.blue,
          backgroundColor: styles.Colors.blue,
          child: const Icon(
            Icons.add,
            color: styles.Colors.white,
          ),
        ),
      ),
      body: Container(
        color: styles.Colors.blue,
        child: SafeArea(
          child: Container(
            color: styles.Colors.white,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                          Text(
                            widget.name!.length > 14
                                ? '${widget.name!.substring(0, 12)}..'
                                : widget.name!,
                            style:styles.TextStyles.blackText26,
                          )],
                      ),
                      Row(
                        children: [
                          IconButton(
                            splashColor: styles.Colors.blue,
                            icon: const Icon(
                              Icons.search,
                              color: styles.Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchProductInGroupPage(
                                        _productGroups,
                                    name: widget.name,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: styles.Colors.blue,
                            ),
                            onPressed: () {
                              //TODO
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Products",
                            style: TextStyles.blackText20
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child:  ListView.builder(
                                  itemCount: _productGroups.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductCard(
                                      product:
                                        _productGroups[index],
                                      docID: _productGroups[index].name,
                                    );
                                  },
                                )

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
