import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'timer.dart';
import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

void main() {
  runApp(const MyApp());
}

const textColor = Color.fromARGB(255, 184, 181, 181);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(221, 27, 27, 27),
      body: Center(
        child: SizedBox(
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 40,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: textColor),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('Pomodor',
                    speed: const Duration(milliseconds: 100))
              ],
              displayFullTextOnTap: true,
              isRepeatingAnimation: false,
              onFinished: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage();
  int session = 1;
  final textColor = Color.fromARGB(255, 184, 181, 181);

  callBack(int session) {
    this.session = session;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(221, 27, 27, 27),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 60, 12, 12),
            child: TitleBar(),
          ),
          TimerDisplay(),
        ],
      ),
    );
  }
}

class TitleBar extends StatelessWidget {
  const TitleBar();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(children: [
      Align(
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                color: textColor,
              ),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            )),
      ),
      Expanded(
        child: Text(
          'Pomodor Timer',
          style: TextStyle(
              color: textColor,
              fontFamily: 'Pacifico',
              fontWeight: FontWeight.bold,
              fontSize: 25),
          textAlign: TextAlign.center,
        ),
      )
    ]);
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
