import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pocket_business/auth/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pocket_business/screen/Home.dart';
String? jwt;

final storage = FlutterSecureStorage();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'PAT0PI3YSbkN4wknJpSAuvHtPbspR1ECof6TUF1X';
  const keyClientKey = 'Xim0Q3IWzPuahzFcWFBK54fwubMXZoRF2ddbZ3nD';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  jwt = await storage.read(key: "token");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Widget> op = {1: MyHomePage(''), 2: MyHomePage('')};
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          unselectedWidgetColor: Color.fromRGBO(248, 97, 49, 0.19),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          splash: 'res/drawable/splash.png',
          splashIconSize: 300,
          nextScreen: jwt == null || jwt.toString().isEmpty ? LoginPage() : Home(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
        )
      /*Scaffold(
          body: CustomSplash(
            imagePath: 'res/drawable/splash.png',
            backGroundColor: Colors.white,
            animationEffect: 'zoom-in',
            logoSize: 1,
            home:  MyHomePage("crbrs"),
            customFunction: duringSplash,
            duration: 1500,
            type: CustomSplashType.StaticDuration,
            outputAndHome: op,
          )
      ),*/
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title, {super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
