import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feng/widgets/custom_typer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/datetime.dart';
import '../widgets/animated_background.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _textStyle = const TextStyle(
      fontSize: 20,
      height: 1.3,
      fontWeight: FontWeight.bold,
      fontFamily: "LongCang",
      letterSpacing: 1.5,
      shadows: [
        Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 2)
      ],
      color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      beginColorTween: ColorTween(
          begin: Colors.indigoAccent, end: Colors.cyanAccent.shade700),
      endColorTween:
          ColorTween(begin: Colors.greenAccent, end: Colors.deepPurpleAccent),
      beginAlign: Alignment.topLeft,
      endAlign: Alignment.bottomRight,
      curve: Curves.bounceIn,
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 0),
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                animatedTexts: [
                  TyperAnimatedText("我们\n一起走过了\n${fallInLoveDays()}天",
                      textStyle: _textStyle,
                      textAlign: TextAlign.start,
                      speed: const Duration(milliseconds: 200),
                      curve: Curves.easeInOutQuad)
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: AnimatedTextKit(
                pause: const Duration(milliseconds: 2000),
                // repeatForever: true,
                totalRepeatCount: 1,
                animatedTexts: [
                  CustomTyperAnimatedText([
                    "我们一起走过了",
                    "${fallInLoveDays()}",
                    "天"
                  ], [
                    TextStyle(color: Colors.red, fontFamily: "LongCang"),
                    TextStyle(
                        color: Colors.blue,
                        fontFamily: "LongCang",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    TextStyle(
                      color: Colors.red,
                      fontFamily: "LongCang",
                    )
                  ], speed: Duration(seconds: 1))
                ],
              ),
            ),
            Lottie.asset("assets/anim/kiss.json")
          ],
        ),
      ),
    );
  }
}
