import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../models/User.dart';
import '../screen/ProductWarhousePage.dart';
import '../Styles.dart' as styles;


class UsersCard extends StatefulWidget {
  final User user;

  const UsersCard({Key? key, required this.user}) : super(key: key);

  @override
  _UsersCardState createState() => _UsersCardState();
}

class _UsersCardState extends State<UsersCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {

        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
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
          child: Row(children: [Text(
            widget.user!.name!,
            style: styles.TextStyles.blackText16,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),Padding(
          padding: const EdgeInsets.fromLTRB(10, 3, 10, 2),
          child: FlutterSwitch(
            height: 31.0,
            width: 51.0,
            padding: 2.0,
            toggleSize: 28.0,
            borderRadius: 18.0,
            inactiveColor: Color.fromRGBO(87, 85, 85, 1),
            activeColor: Color.fromRGBO(248, 97, 49, 1),
            value:  widget.user.isAdmin!,
            onToggle: (value) {
              setState(() {
                widget.user.isAdmin = value;
              });
            },
          ),
        )])
          // TODO: Add counter
        ),
      ),
    );
  }
}
