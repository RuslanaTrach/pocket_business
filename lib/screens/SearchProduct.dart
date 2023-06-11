import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Styles.dart' as styles;
import '../models/Product.dart';
import '../widgets/ProductCard.dart';

class SearchProductInGroupPage extends StatefulWidget {
  final String? name;
  List<Product>? products;
  SearchProductInGroupPage(this.products, {Key? key,  this.name}) : super(key: key);

  @override
  State<SearchProductInGroupPage> createState() =>
      _SearchProductInGroupPageState();
}

class _SearchProductInGroupPageState extends State<SearchProductInGroupPage> {
  FocusNode? inputFieldNode;
  String query = '';
  List<Product>? items_ = [];

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
        items_ = widget.products
            ?.where(
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
                          initialValue: query,
                          onFieldSubmitted: (value) {
                            setState(() {
                              query = value;
                              FocusScope.of(context)
                                  .requestFocus(inputFieldNode);
                              filterSearchResults(query);
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
                            hintStyle: styles.TextStyles.blackText24
                          ),
                          cursorColor: styles.Colors.blue,
                        ),
                      ),
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
                          const SizedBox(height: 20),
                          Expanded(
                            child: query.isEmpty
                                ? const SizedBox()
                                : ListView.builder(
                                        itemCount: items_?.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ProductCard(
                                            product: items_?[index],
                                            docID: items_?[index].id,
                                          );
                                        },
                                  ),
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
