
import 'package:flutter/material.dart';
import '../models/Product.dart';
import '../screens/ProductDetailsPage.dart';
import '../Styles.dart' as styles;

class ProductCard extends StatelessWidget {
  final Product? product;
  final String? docID;
  const ProductCard({Key? key, this.product, this.docID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              docID: docID,
              product: product,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 110,
        decoration: BoxDecoration(
          color: styles.Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 6,
              color: const Color(0xff000000).withOpacity(0.06),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [

            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product!.name ?? '',
                    maxLines: 1,
                    style: styles.TextStyles.blackText20,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        product!.group ?? '-',
                        maxLines: 1,
                        style: styles.TextStyles.blackText12
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                          top: 2,
                          right: 5,
                        ),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                          color: styles.Colors.blue,
                        ),
                      ),
                      Text(
                        product!.company ?? '-',
                        maxLines: 1,
                        style: styles.TextStyles.blackText12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    // width: 100,
                    child: Text(
                      product!.description ?? '-',
                      maxLines: 3,
                      style: styles.TextStyles.blackText12
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${product!.cost ?? '-'} uah",
                    style: styles.TextStyles.blackText15
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "${product!.quantity ?? '-'}\nAvailable",
                        style: styles.TextStyles.blackText12,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
