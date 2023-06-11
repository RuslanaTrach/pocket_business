import 'package:flutter/material.dart';
import '../Styles.dart'as styles;
import '../widgets/toast.dart';
import '../models/Product.dart';
import '../services/ServerManager.dart';

class NewProductPage extends StatefulWidget {
  final String? group;
  final String? ware;
  final String? barcode;
  const NewProductPage({Key? key, this.group, this.ware, this.barcode}) : super(key: key);
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {

  final Product newProduct = Product();
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  postNew(Product product){
    var body = "{ \"product_id\":\"5\",\"product_name\":\"${product.name}\",\"product_description\":\"${product.description}\",\"product_price\":${product.cost},\"product_quantity\":${product.quantity},\"ware\":{ \"__type\": \"Pointer\", \"className\": \"Wahehouse\", \"objectId\": \"${widget.ware}\" },\"group\":\"${widget.barcode}\",\"company\":\"${product.company}\" }";
    ServerManager(context).postItemRequest(body, (body) {

      print(body);
      setState(() {

      });

    }, (errorCode) { });
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
            print(newProduct.toString());
            await postNew(newProduct);
//            newProduct.group = group;
           // _firestore
             //   .collection("products")
               // .add(newProduct.toMap())
            //    .then((value) {
             // showTextToast('Added Sucessfully!');
           // }).catchError((e) {
            //  showTextToast('Failed!');
            //});
            //Navigator.of(context).pop();
          },
          splashColor: styles.Colors.blue,
          backgroundColor: styles.Colors.blue,
          child: const Icon(
            Icons.done,
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
                          const Text(
                            "New Product",
                            style: styles.TextStyles.blackText16
                          ),
                        ],
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
                          Row(
                            children: const [
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 50,
                                  ),
                                  margin: const EdgeInsets.only(top: 75),
                                  decoration: const BoxDecoration(
                                    color: styles.Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, bottom: 12,),
                                          child: Text(
                                            "Product Barcode : ${widget.barcode}",
                                            style: styles.TextStyles.blackText16
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: styles.Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: styles.Colors.blue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue: newProduct.name ?? '',
                                            onChanged: (value) {
                                              newProduct.name = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: styles.TextStyles.blackText16,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Product Name",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: styles.TextStyles.blackText16
                                            ),
                                            cursorColor:styles.Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: styles.Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: styles.Colors.blue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                      newProduct.cost == null
                                                          ? ''
                                                          : newProduct.cost
                                                              .toString(),
                                                  onChanged: (value) {
                                                    newProduct.cost =
                                                        int.parse(value);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                    styles.Colors.blue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Cost",
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    hintStyle: styles.TextStyles.blackText16
                                                  ),
                                                  cursorColor:styles.Colors.blue,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: styles.Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      offset:
                                                          Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: styles.Colors.blue,
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                      newProduct.quantity ==
                                                              null
                                                          ? ''
                                                          : newProduct.quantity
                                                              .toString(),
                                                  onChanged: (value) {
                                                    newProduct.quantity =
                                                        int.parse(value);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: styles.TextStyles.blackText16,
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Quantity",
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    hintStyle: styles.TextStyles.blackText16,
                                                  ),
                                                  cursorColor:styles.Colors.blue
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                            color: styles.Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: styles.Colors.blue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            onChanged: (value) {
                                              newProduct.group = value;
                                            },
                                            textInputAction:
                                            TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: styles.TextStyles.blackText16,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Warehouse",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle:styles.TextStyles.blackText16,
                                            ),
                                            cursorColor:styles.Colors.blue
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: styles.Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                                color: styles.Colors.blue,
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue:
                                                newProduct.company ?? '',
                                            onChanged: (value) {
                                              newProduct.company = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: styles.TextStyles.blackText16,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Company",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: styles.TextStyles.blackText16,
                                            ),
                                            cursorColor:styles.Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: styles.Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 3),
                                                blurRadius: 6,
                                                color: styles.Colors.blue,
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue:
                                                newProduct.description ?? '',
                                            onChanged: (value) {
                                              newProduct.description = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: styles.TextStyles.blackText16,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Description",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle:styles.TextStyles.blackText16,
                                            ),
                                            cursorColor:styles.Colors.blue,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
