import 'dart:async';
import 'dart:convert';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Styles.dart' as styles;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

import '../screens/Home.dart';
import '../services/AuthenticationService.dart';
import '../services/ServerManager.dart';
import 'RegisterPage.dart';

class CodePage extends StatefulWidget {
  String email;
   CodePage(this.email, {super.key});
  @override
  State createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  int secondsRemaining = 60;
  bool enableResend = false;
  bool emailExist = false;
  late Timer timer;
  final auth0 = Auth0("dev-s8m3mg8ibtuewaan.us.auth0.com", "X4ZUOs1c0Tf38snx5uPAJcia9ShgJtZI");
  //final auth0 = Auth0("iamcompany.eu.auth0.com", "GBWhjQd1AdPTW5uUAKf0n0fRppnlplnk");//Auth0("dev-q6znxg2d2ymu1fbq.us.auth0.com", "reUmvpDpZqtl5S76F3WqA1Asa1QqveDe");
  //
  final storage = FlutterSecureStorage();

  final _passwordVisible = false;

  @override
  initState() {
    super.initState();
    startTimer();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (secondsRemaining == 0) {
          setState(() {
            enableResend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            enableResend = false;
            secondsRemaining--;
          });
        }
      },
    );
  }
  /*final PageRouteBuilder _homeRoute = PageRouteBuilder(
    pageBuilder: (BuildContext context, _, __) {
      return MainPage();
    },
  );*/




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

      ServerManager(context).getUserRequest(widget.email, (body) async {
          if(body == null) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    RegisterPage(widget.email),
              ),
            );
          }else{
            if(body.isAdmin == true){
              await storage.write(key: "isAdmin", value: 'true');
            }else{
              await storage.write(key: "isAdmin", value: 'false');
            }
            Navigator.push(context,
                CupertinoPageRoute(
                    builder: (context) =>
                        Home()));
          }
      }, (errorCode) {
       // Dialogs().alert(context, Localization.of(context)!.trans("error"), Localization.of(context)!.trans("invalid_auth_data"), () {

        });
      });
    }


  _loginAction() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    try {
      SignInWithEmail signInWithEmail = SignInWithEmail();

      String token;
      // Platform messages may fail, so we use a try/catch PlatformException.
      // We also handle the message potentially returning null.
      try {
        final credentials = await signInWithEmail.sendCode(_emailController.text, widget.email);
        var body = jsonDecode(credentials);
        token = body['id_token'];
        var accessToken = body['access_token'];
        print(token);
        print(credentials);
        var userInfo = await auth0.api.userProfile(accessToken: accessToken);
        print(userInfo.isEmailVerified);


        saveAccessToken(token, userInfo.isEmailVerified);

      } on ApiException catch (e) {
        token = e.toString();
        return;
      }
    }catch(e){}

    // apiLogin("bogonoss@gmail.com", "P@ssw0rd");
    // apiLogin("bogonossd@gmail.com", "Qwerty123");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    var emailField = Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(52, 26, 52, 16),
      decoration:const BoxDecoration(
        border: Border.fromBorderSide(BorderSide(
            color: Color.fromRGBO(216, 216, 228, 1),
            width: 1.0)),
          color: styles.Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(37))),
      child: TextFormField(
            controller: _emailController,
            focusNode: _emailFocus,
            keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.number,
            style: styles.TextStyles.redText16,
            textAlign: TextAlign.center,
            decoration:  InputDecoration(
                hintText: 'Код',
                hintStyle: styles.TextStyles.placeholderText18,
                border: InputBorder.none),
            onChanged: (String value) {
            //  setState(() {
              //});
            })
    );

    return WillPopScope(
        onWillPop: () async => true,
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
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Hello",
                                    style: styles.TextStyles.blackText26,
                                  ),

                                  const SizedBox(height: 26),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Please, enter code sent on",
                                    style: styles.TextStyles.blackText12,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    widget.email,
                                    style: styles.TextStyles.redTextMedium12,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "And check SPAM holder",
                                    style: styles.TextStyles.blackText12,
                                  ),
                                  emailField,
                                  Container(
                                    height: 64,
                                    margin: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                                    child: InkWell(
                                      onTap: () {
                                       _loginAction();
                                      },
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Image.asset(
                                                  'res/drawable/button_background.png'),
                                          const SizedBox(width: 10),
                                          const Text(
                                            "Continue",
                                            style: styles.TextStyles.whiteText20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: 40,
                                      child:enableResend?
                                      SizedBox(
                                        height: 31,
                                        width: 200,
                                        child: InkWell(
                                          onTap: () {
                                            secondsRemaining = 60;
                                            startTimer();
                                          },
                                          child: Stack(
                                            alignment: AlignmentDirectional.center,
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            children: [Image.asset(
                                                'res/drawable/button_background.png'),
                                              const SizedBox(width: 10),
                                              Text(
                                                "Resend code",
                                                style: styles.TextStyles.whiteText12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      :Stack(
                                        alignment: Alignment.topCenter,
                                       // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                        const Text("You can resend the code",
                                      textAlign: TextAlign.center,
                                      style: styles.TextStyles.blackText12),
                                            Padding(padding: const EdgeInsets.only(top:15),
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                const Padding(padding: EdgeInsets.only(top:2),
                                                child:Text("${"in"} ",
                                                    style: styles.TextStyles.blackText12)),
                                       Text('$secondsRemaining',
                                            style: styles.TextStyles.redText16, textAlign: TextAlign.end),
                                const Padding(padding: EdgeInsets.only(top:2),
                                    child:Text("sec",
                                            style: styles.TextStyles.blackText12))])),
                                      ]),
                                  ),
                                  const SizedBox(height: 24),

                                ],
                              ),
                            ),
                          ],
                        )),

                  const SizedBox(height: 30),
                  ]),
                )));
  }
}
