import 'package:flutter/material.dart';
import '../screens/ProductWarhousePage.dart';
import '../Styles.dart' as styles;


class ProductGroupCard extends StatelessWidget {
  final String? name;
  final String? object;

  const ProductGroupCard({Key? key, this.object, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ProductGroupPage(
                  object,

                  name,
                );
              },
            ),
          );
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: styles.Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 6,
                color: const Color(0xff000000).withOpacity(0.16),
              ),
            ],
          ),
          child: Text(
            name!,
            style: const TextStyle(
              fontFamily: "Nunito",
              fontSize: 20,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // TODO: Add counter
        ),
      ),
    );
  }
}
