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
      fontSize: 30,
      height: 1.3,
      fontWeight: FontWeight.bold,
      fontFamily: "LongCang",
      letterSpacing: 1.5,
      shadows: [
        Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 2)
      ],
      color: Colors.white);

  final _numberStyle = TextStyle(
      fontSize: 60,
      height: 1.3,
      fontWeight: FontWeight.bold,
      fontFamily: "Roboto",
      letterSpacing: 1.5,
      shadows: const [
        Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 2)
      ],
      color: Colors.pink.shade300);

  bool showEmoji = false;
  bool showDays = false;
  bool showYears = false;

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
        child: _buildContent(),
      ),
    );
  }

  _buildContent() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Positioned(
          top: 36,
          left: 36,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedTextKit(
                pause: const Duration(milliseconds: 0),
                totalRepeatCount: 1,
                animatedTexts: [
                  CustomTyperAnimatedText(
                      textList: ["我们", "在一起"],
                      direction: Axis.vertical,
                      textStyleList: [_textStyle, _textStyle])
                ],
                onFinished: () {
                  setState(() {
                    showDays = true;
                  });
                },
              ),
              if (showDays)
                AnimatedTextKit(
                  pause: const Duration(milliseconds: 0),
                  totalRepeatCount: 1,
                  animatedTexts: [
                    CustomTyperAnimatedText(
                        textList: ["${fallInLoveDays()}", " 天"],
                        textStyleList: [_numberStyle, _textStyle],
                        speed: const Duration(milliseconds: 100))
                  ],
                  onFinished: () {
                    setState(() {
                      showEmoji = true;
                    });
                  },
                ),
              if (showEmoji)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: AnimatedTextKit(
                    pause: const Duration(milliseconds: 0),
                    totalRepeatCount: 1,
                    animatedTexts: [
                      CustomTyperAnimatedText(textList: [
                        "约",
                        fallInLoveYears(),
                        "年，",
                        "相当于",
                        fallInLoveMonths(),
                        "个月"
                      ], textStyleList: [
                        _textStyle.copyWith(fontSize: 16),
                        _numberStyle.copyWith(
                            fontSize: 20, color: Colors.orange.shade200),
                        _textStyle.copyWith(fontSize: 16),
                        _textStyle.copyWith(fontSize: 16),
                        _numberStyle.copyWith(
                            fontSize: 20, color: Colors.orange.shade200),
                        _textStyle.copyWith(fontSize: 16)
                      ])
                    ],
                  ),
                ),
            ],
          ),
        ),
        Align(
          child: AnimatedOpacity(
            opacity: showEmoji ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1500),
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Lottie.asset("assets/anim/couple.json"),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            opacity: showEmoji ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 1500),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 7),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(seconds: 0),
                animatedTexts: [
                  WavyAnimatedText("Since 2020.04.21",
                      textAlign: TextAlign.center,
                      textStyle: _textStyle.copyWith(fontSize: 20, shadows: []))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
