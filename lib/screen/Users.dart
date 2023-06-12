
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_business/auth/LoginPage.dart';
import 'package:pocket_business/widgets/UsersCard.dart';
import '../Styles.dart' as styles;
import '../models/User.dart';
import '../models/Warehouse.dart';
import '../widgets/MenuBottom.dart';
import '../widgets/ConfirmDialog.dart';
import '../screen/GlobalSearchPage.dart';
import '../services/ServerManager.dart';
import '../widgets/WarehouseCard.dart';
import '../widgets/toast.dart';

class Users extends StatefulWidget {
  const Users({super.key});
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {

  List<User> users  =[];
    @override
  void initState(){
      ServerManager(context).getUsersRequest((body) {
          users.addAll(body);
          setState(() {

          });

      }, (errorCode) { });
      super.initState();
  }

final TextEditingController _newProductGroup = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MenuBottom(MenuPosition.main),

      body: //DoubleBackToCloseApp(
        //snackBar: const SnackBar(
        //  content: Text('Tap back again to leave'),
        //),
 //       child:
       Container(
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
                      left: 20,
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Users",
                          style: styles.TextStyles.blackText26
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
                              child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                      ),
                                      itemCount: users.length,
                                      itemBuilder: (context, index) {
                                        return UsersCard(
                                          user: users[index],
                                          key: UniqueKey(),
                                        );}

                              ),
                            )
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
