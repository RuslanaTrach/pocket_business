import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../Styles.dart' as styles;

import '../screen/Home.dart';
import '../screen/NewProductPage.dart';

class MenuBottom extends StatefulWidget {
  MenuBottom(this._menuPosition, {super.key});
  final MenuPosition _menuPosition;


  @override
  State<StatefulWidget> createState() => _MenuBottomState(_menuPosition);

}

class _MenuBottomState extends State<MenuBottom> {
  late final MenuPosition _menuPosition;

  _MenuBottomState(this._menuPosition);

  void _onMenuPositionClick(MenuPosition menuPosition) async {
    print(menuPosition);

    if (menuPosition == _menuPosition && menuPosition != MenuPosition.main) return;
    StatefulWidget? page;
    switch (menuPosition) {
      case MenuPosition.main:
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
                      group: "",
                      barcode: result
                  );
                },
              ),
            );
          }
        });
        break;
      case MenuPosition.star:
        //page = MarathonsPage();
        break;
      case MenuPosition.profile:
        //page = ProfilePage();
        break;
      case MenuPosition.shop:
      //page = ProfilePage();
        break;
      case MenuPosition.statistic:
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Home(),
          ),
        );
        break;
    }
     if (page == null) return;

  }

  @override
  void initState() {
    super.initState();

  }
  getData() async {

    isAdmin = await FlutterSecureStorage().read(key: "isAdmin");
  }
  String? isAdmin;
  late int orderIndex;
  late String id;
  List<dynamic> send = [];
  List<Map<String,Object>> myOrdersList =[];
  List<Map<String,Object>> inputRequest = [];


  // getToken() async {
  //   String token = await storage.read(key: "token");
  //   String refreshtoken = await storage.read(key:"refresh_token").then((refreshToken){
  //     return refreshToken;
  //   });
  //   return token;
  // }

  @override
  Widget build(BuildContext context) {
    var itemMain = buildMenuItem(MenuPosition.main);
    var itemStatistic = buildMenuItem(MenuPosition.statistic);
    var itemProfile = buildMenuItem(MenuPosition.profile);

    return BottomAppBar(
      elevation: 1,
        color: styles.Colors.blue,
        child:  Container(
          margin: EdgeInsets.only(top: 2),
        height: 62 + MediaQuery.of(context).viewInsets.bottom,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(19, 78, 119, 48),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
        child:
        Column(
          children: [
            isAdmin =="true"?
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  itemStatistic,
                  itemMain,
                  itemProfile
                ]):
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  itemStatistic,
                  itemMain
                ])
          ],
        )
        )
    );
  }

  Widget buildMenuItem(MenuPosition menuPosition) {
    String icon;
    switch (menuPosition) {
      case MenuPosition.main:
        icon = 'res/drawable/scan.png';

        break;
      case MenuPosition.statistic:
        icon = 'res/drawable/statistic.png';
        break;
      case MenuPosition.star:
        icon = 'res/drawable/star.png';
        break;
      case MenuPosition.shop:
        icon = 'res/drawable/shop.png';
        break;
      case MenuPosition.profile:
        menuPosition == _menuPosition?
        icon = 'res/drawable/profile_active.png'
            :icon = 'res/drawable/profile.png';
        break;
    }

    return Expanded(
      child: Opacity(
          // opacity: menuPosition == _menuPosition ? 1 : .5,
          opacity: 1,
          child: Center(
            child: Wrap(children: <Widget>[
              InkWell(
                child:
                SizedBox(
                    height: 60,
                    width: 60,//menuPosition == MenuPosition.main?60: menuPosition == MenuPosition.star?40:34,
                    child: Image.asset(icon)), //color: menuPosition == _menuPosition ? styles.Colors.white : styles.Colors.inactiveWhite),),

                onTap: () => _onMenuPositionClick(menuPosition),
              ),
            ]),
          )),
    );
  }
}

enum MenuPosition { main, shop, profile, statistic, star}

class Message{
  final String title;
  final String body;
  final String? action;

  const Message({
    required this.title,
    required this.body,
    this.action
  });
}

