import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:listadecontatos/pages/main_home_page.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Image.asset(
              "assets/icon/icon.png",
              height: 80,
            ),
            Transform.translate(
              offset: Offset(-20, 0),
              child: SizedBox(
                width: 250,
                child: DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Horizon',
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText(
                          'Practical',
                          duration: Duration(milliseconds: 1000),
                        ),
                        RotateAnimatedText(
                          'Organized',
                          duration: Duration(milliseconds: 1000),
                        ),
                        RotateAnimatedText(
                          'Essential',
                          duration: Duration(milliseconds: 1000),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: Duration(milliseconds: 800),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      onFinished: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child:
                                MainHomePage(title: 'Flutter Demo Home Page'),
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeInOut,
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
