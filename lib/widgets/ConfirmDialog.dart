import 'package:flutter/material.dart';
import '../Styles.dart' as styles;

void showConfirmDialog(BuildContext context, String title, String action1title,
    String action2title, Function action1, Function action2,) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: styles.TextStyles.blackText16,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    action1();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 12),
                    child: Text(
                      action1title,
                      style: styles.TextStyles.blackText12,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    action2();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 12),
                    child: Text(
                      action2title,
                      style: styles.TextStyles.blackText12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
