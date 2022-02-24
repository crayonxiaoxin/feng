import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feng/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
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
      beginColorTween:
          ColorTween(begin: Colors.deepPurple, end: Colors.blue.shade700),
      endColorTween: ColorTween(begin: Colors.blueGrey, end: Colors.yellow),
      beginAlign: Alignment.topRight,
      endAlign: Alignment.bottomLeft,
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
                  TyperAnimatedText(
                      "他们所有的设备和仪器\n彷佛\n都是有生命的。\n1234567890\nABCDEFGHIJKLMNOPQRSTUVWXYZ",
                      textStyle: _textStyle,
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 200),
                      curve: Curves.easeInOutQuad)
                ],
              ),
            ),
            Positioned(
                bottom: 16,
                right: 0,
                child: Lottie.asset("assets/anim/rabbit_heart.json",
                    width: MediaQuery.of(context).size.width))
          ],
        ),
      ),
    );
  }
}
