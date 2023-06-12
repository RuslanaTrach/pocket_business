import 'dart:convert';
import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Styles.dart' as styles;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import '../screen/Home.dart';
import '../services/AuthenticationService.dart';
import '../services/ServerManager.dart';
import 'CodePage.dart';

class RegisterPage extends StatefulWidget {
  String email;
  RegisterPage(this.email, {super.key});
  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  final auth0 = Auth0("dev-s8m3mg8ibtuewaan.us.auth0.com", "X4ZUOs1c0Tf38snx5uPAJcia9ShgJtZI");
  String from = "email";

  UserProfile? user;
  final storage = FlutterSecureStorage();




  Future<void> saveAccessToken(String token, bool? isVerified) async {
    var verifiedString = "false";
    if (isVerified == true) {
      verifiedString = "true";
    }


    var value = verifiedString; //await storage.read(key: "isVerified");
    setState(() {
      storage.write(key: "token", value: token);
      storage.write(key: "isVerified", value: verifiedString);

      bool boolValue = value.toString().toLowerCase() == "true";


    });
  }


  Future<void> apiLogin(final String usernameOrEmail, final String password,
      void Function(String message) onError) async {
    String token;
    try {
      final result = await auth0.api.login(
          usernameOrEmail: usernameOrEmail,
          password: password,
          connectionOrRealm: 'Username-Password-Authentication');
      token = result.idToken;
    } on ApiException catch (e) {
      print(e);
      token = e.toString();
      onError("Invalid Auth data");
      return;
    }
    storage.write(key: "token", value: token);
    if (!mounted) return;

    //saveAccessToken(token, isVerified);
  }
  _registrationAction() async {
    var body = "{ \"email\":\"${widget.email}\","
        "\"name\":\"${_emailController.text}\","
        "\"is_admin\":false}";
    print(body);
    await ServerManager(context).postUserRequest(body, (body) async {
      await storage.write(key: "isAdmin", value: 'false');
      await storage.write(key: "email", value: _emailController.text);
      print(body.toString());
      setState(() {
      });
      Navigator.push(context,
          CupertinoPageRoute(
              builder: (context) =>
                  Home()));
    }, (errorCode) { });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    var emailField = Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(52, 26, 52, 16),
        decoration: const BoxDecoration(
            border: Border.fromBorderSide(BorderSide(
                color: Color.fromRGBO(216, 216, 228, 1), width: 1.0)),
            color: styles.Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(37))),
        child: TextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.name,
            style: styles.TextStyles.redText16,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                hintText: "Enter Your Name", //Localization.of(context)?.trans('email'),
                hintStyle: styles.TextStyles.greyText15, //redText16,
                border: InputBorder.none),
            onChanged: (String value) {
              //  setState(() {
              //});
            }));



    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: styles.Colors.backgroundGrey,
            body: InkWell(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Stack(children: [
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 70,
                          height: 70,
                          child: Image.asset("res/drawable/splash.png"),
                        ),
                        const SizedBox(height: 29),
                        Container(
                          color: styles.Colors.white,
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 26),
                              const Text(
                                "Sign up",
                                style: styles.TextStyles.blackText26,
                              ),

                              emailField,
                              Container(
                                height: 64,
                                margin: EdgeInsets.only(
                                    left: 50, right: 50, bottom: 24),
                                child: InkWell(
                                  onTap: () {
                                    _registrationAction();

                                  },
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'res/drawable/button_background.png'),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Next',
                                        style: styles.TextStyles.whiteText20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ]),
            )));
  }
}
