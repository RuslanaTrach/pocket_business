
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_business/auth/LoginPage.dart';
import '../Styles.dart' as styles;
import '../models/Warehouse.dart';
import '../services/MenuBottom.dart';
import '../widgets/ConfirmDialog.dart';
import '../screen/GlobalSearchPage.dart';
import '../services/ServerManager.dart';
import '../widgets/WarehouseCard.dart';
import '../widgets/toast.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Warehouse> _productGroups  =[];
    @override
  void initState(){
      ServerManager(context).getItemsRequest((body) {
        for(Warehouse i in body) {
          _productGroups.add(i);
        }
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    "Add Warehouse",
                    style: styles.TextStyles.blackText20,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: styles.Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                              color: const Color(0xff000000).withOpacity(0.16),
                            ),
                          ],
                        ),
                        height: 50,
                        child: TextField(
                          textInputAction: TextInputAction.next,
                          key: UniqueKey(),
                          controller: _newProductGroup,
                          keyboardType: TextInputType.text,
                          style: styles.TextStyles.blackText15,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Warehouse Name",
                            filled: true,
                            fillColor: Colors.transparent,
                            hintStyle:  styles.TextStyles.blackText15,
                          ),
                          cursorColor: styles.Colors.selectedBlack,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_newProductGroup.text != null &&
                              _newProductGroup.text != "") {
                            try {
                              /*//final DocumentSnapshot<Map<String, dynamic>>
                                //  _doc ={};// await _firestore
                                      //.collection("utils")
                                      //.doc("productGroups")
                                      //.get();
                              final List<dynamic> _tempList =
                                  _doc.data()!['list'] as List<dynamic>;
                              if (_tempList.contains(_newProductGroup.text)) {
                                showTextToast("Group Name already created");
                              } else {
                                _tempList.add(_newProductGroup.text);
                                _firestore
                                    .collection('utils')
                                    .doc("productGroups")
                                    .update({'list': _tempList});
                                showTextToast("Added Successfully");
                              }*/
                            } catch (e) {
                              showTextToast("An Error Occured!");
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            _newProductGroup.text = "";
                          } else {
                            showTextToast("Enter Valid Name!");
                          }
                        },
                        child: Container(
                          height: 45,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: styles.Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 3),
                                blurRadius: 6,
                                color:
                                    const Color(0xff000000).withOpacity(0.16),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Done",
                              style: styles.TextStyles.whiteText15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          splashColor: styles.Colors.blue,
          backgroundColor:styles.Colors.blue,
          child: const Icon(
            Icons.add,
            color: styles.Colors.white,
          ),
        ),
      ),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Homepage",
                          style: styles.TextStyles.blackText26
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
                                        GlobalSearchPage(_productGroups),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.power_settings_new,
                                color: styles.Colors.blue,
                              ),
                              onPressed: () {
                                showConfirmDialog(
                                    context,
                                    "Want to Logout?",
                                    "No",
                                    "Yes", () {
                                  Navigator.of(context).pop();
                                }, () {
                                  const storage = FlutterSecureStorage();
                                  storage.write(key: "token", value: null);
                                  Navigator.push(context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              LoginPage()));
                                });
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

                            const SizedBox(height: 20),
                            const Text(
                              "Warehouse",
                              style: styles.TextStyles.blackText20,
                            ),
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
                                      itemCount: _productGroups.length,
                                      itemBuilder: (context, index) {
                                        return ProductGroupCard(
                                          name: _productGroups[index].name,
                                          object: _productGroups[index].objectId,
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
