import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feng/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/lx_state.dart';
import '../widgets/custom_typer.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends LxState<Page3> {
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

  bool showContent = false;
  bool showColorsContent = false;
  bool showDog = false;

  final _colorizeColors = [
    Colors.white,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.white,
  ];

  String content = "麻烦\n锦凤小仙女\n继续担任\n小鑫人生中的\n最佳女主角";

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      beginColorTween: ColorTween(
          begin: Colors.deepOrangeAccent, end: const Color(0xFFFFA07A)),
      endColorTween: ColorTween(begin: Colors.pink, end: Colors.grey.shade700),
      beginAlign: Alignment.centerLeft,
      endAlign: Alignment.centerRight,
      curve: Curves.bounceInOut,
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Positioned(
              top: 16,
              right: 16,
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 0),
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                animatedTexts: [
                  CustomTyperAnimatedText(
                      textList: ["接下来..."],
                      direction: Axis.vertical,
                      verticalCrossAlignment: CrossAxisAlignment.end,
                      textStyleList: [
                        _textStyle.copyWith(color: Colors.yellow)
                      ]),
                ],
              ),
            ),
            Lottie.asset("assets/anim/hand_heart.json", repeat: false,
                onLoaded: (lottieComposition) {
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  showContent = true;
                });
              });
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  showDog = true;
                });
              });
            }),
            Positioned(
              top: MediaQuery.of(context).size.height / 5,
              child: AnimatedOpacity(
                opacity: showContent && !showColorsContent ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1000),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 0),
                  isRepeatingAnimation: true,
                  displayFullTextOnTap: true,
                  animatedTexts: [
                    TyperAnimatedText(content,
                        textStyle: _textStyle.copyWith(
                            fontSize: 30, color: Colors.white),
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 200),
                        curve: Curves.easeInOutQuad),
                  ],
                  onFinished: () {
                    setState(() {
                      showColorsContent = true;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 5,
              child: AnimatedOpacity(
                opacity: showContent && showColorsContent ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1000),
                child: AnimatedTextKit(
                  pause: const Duration(milliseconds: 0),
                  repeatForever: true,
                  animatedTexts: [
                    ColorizeAnimatedText(
                      content,
                      textAlign: TextAlign.center,
                      textStyle: _textStyle.copyWith(
                          fontSize: 30, color: Colors.white),
                      colors: _colorizeColors,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 36,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                  opacity: showDog ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  child: Lottie.asset("assets/anim/dog.json")),
            )
          ],
        ),
      ),
    );
  }
}
