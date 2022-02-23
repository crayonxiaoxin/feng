import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  final Color? color;

  const Page1({Key? key, this.color}) : super(key: key);

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
    return Container(
      color: widget.color,
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
                  TyperAnimatedText(
                      "他们所有的设备和仪器\n彷佛\n都是有生命的。\n1234567890\nABCDEFGHIJKLMNOPQRSTUVWXYZ",
                      textStyle: _textStyle,
                      textAlign: TextAlign.end,
                      speed: const Duration(milliseconds: 200),
                      curve: Curves.easeInOutQuad)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
