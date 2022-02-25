import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feng/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/lx_state.dart';
import '../widgets/custom_typer.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends LxState<Page2> {
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

  final _cities = ["广州", "深圳", "珠海", "江门"];
  bool showNumber = false;
  bool showCities = false;

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
              top: 36,
              left: 36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedTextKit(
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 0),
                    isRepeatingAnimation: false,
                    displayFullTextOnTap: true,
                    animatedTexts: [
                      TyperAnimatedText("我们一起解锁了",
                          textStyle: _textStyle.copyWith(
                              fontSize: 30, color: Colors.white),
                          textAlign: TextAlign.center,
                          speed: const Duration(milliseconds: 150),
                          curve: Curves.easeInOutQuad),
                    ],
                    onFinished: () {
                      setState(() {
                        showNumber = true;
                      });
                    },
                  ),
                  if (showNumber)
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 0),
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true,
                      animatedTexts: [
                        CustomTyperAnimatedText(
                          textList: [
                            "${_cities.length}",
                            " 个城市，包括",
                          ],
                          textStyleList: [
                            _textStyle.copyWith(
                                fontSize: 50,
                                color: Colors.orange,
                                fontFamily: "Roboto"),
                            _textStyle.copyWith(height: 2),
                          ],
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      onFinished: () {
                        setState(() {
                          showCities = true;
                        });
                      },
                    ),
                  if (showCities)
                    AnimatedTextKit(
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 0),
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true,
                      animatedTexts: [
                        TyperAnimatedText(_cities.join("、"),
                            textStyle:
                                _textStyle.copyWith(color: Colors.yellow),
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 100),
                            curve: Curves.easeInOutQuad),
                      ],
                    ),
                ],
              ),
            ),
            Positioned(
                bottom: 56,
                right: 0,
                child: Lottie.asset("assets/anim/rabbit_heart.json",
                    width: MediaQuery.of(context).size.width))
          ],
        ),
      ),
    );
  }
}
