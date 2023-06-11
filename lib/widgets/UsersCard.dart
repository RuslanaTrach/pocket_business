import 'package:flutter/material.dart';
import '../models/User.dart';
import '../screen/ProductWarhousePage.dart';
import '../Styles.dart' as styles;


class UsersCard extends StatelessWidget {
  final User user;

  const UsersCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {

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
            user!.name!,
            style: styles.TextStyles.blackText16,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // TODO: Add counter
        ),
      ),
    );
  }
}
