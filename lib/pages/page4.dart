import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feng/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/lx_state.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends LxState<Page4> {
  final _textStyle = const TextStyle(
      fontSize: 30,
      height: 1.3,
      fontWeight: FontWeight.bold,
      fontFamily: "LongCang",
      letterSpacing: 1.5,
      shadows: [
        Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 2)
      ],
      color: Colors.white);

  bool showDog = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      beginColorTween:
          ColorTween(begin: Colors.blue.shade400, end: Colors.blue.shade200),
      endColorTween: ColorTween(begin: Colors.white, end: Colors.white),
      beginAlign: Alignment.topCenter,
      endAlign: Alignment.bottomCenter,
      curve: Curves.bounceInOut,
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Positioned(
              top: 16,
              right: 16,
              child: Lottie.asset("assets/anim/sun.json"),
            ),
            Positioned(
                top: 36,
                left: 16,
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 0),
                  isRepeatingAnimation: true,
                  displayFullTextOnTap: true,
                  animatedTexts: [
                    TyperAnimatedText("未来可期...",
                        textStyle: _textStyle.copyWith(
                            fontSize: 24, color: Colors.white),
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 200),
                        curve: Curves.easeInOutQuad),
                  ],
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                  opacity: showDog ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  child: Lottie.asset("assets/anim/hug.json")),
            )
          ],
        ),
      ),
    );
  }
}
