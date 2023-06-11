import 'dart:convert';
import 'dart:developer';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Styles.dart' as styles;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

import '../services/AuthenticationService.dart';
import '../widgets/toast.dart';
import 'CodePage.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final auth0 = Auth0("dev-s8m3mg8ibtuewaan.us.auth0.com", "X4ZUOs1c0Tf38snx5uPAJcia9ShgJtZI");
  final storage = FlutterSecureStorage();


  Future<void> saveAccessToken(String token, bool? isVerified) async {
    setState(() {
      storage.write(key: "token", value: token);
    });
  }


  _registrationAction() async {

    String email = _emailController.text;
      SignInWithEmail signInWithEmail = SignInWithEmail();

      String token;
      try {
        final credentials = await signInWithEmail.signUp(_emailController.text);
        var body = jsonDecode(credentials);
        token = body['id_token'];
        print(credentials);
      } on ApiException catch (e) {
        token = e.toString();
        return;
      }
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) =>
              CodePage(_emailController.text),
        ),
      );

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
            keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.emailAddress,
            style: styles.TextStyles.redText16,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                hintText: "E-mail", //Localization.of(context)?.trans('email'),
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
                      children: [ Container(
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
                              Text(
                                "Sign in",
                                style: styles.TextStyles.blackText26,
                              ),
                             // Container(
                             //   child: loginWithSocial,
                             // ),
                              emailField,
                              Container(
                                height: 64,
                                margin: EdgeInsets.only(
                                    left: 50, right: 50, bottom: 24),
                                child: InkWell(
                                  onTap: () {
                                    bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(_emailController.text);
                                    if (emailValid) {
                                      _registrationAction();

                                    } else {
                                      showTextToast('Please, enter valid email');
                                    }
                                  },
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'res/drawable/button_background.png'),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Continue',
                                        style: styles.TextStyles.whiteText20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    )),
              ]),
            )));
  }
}
