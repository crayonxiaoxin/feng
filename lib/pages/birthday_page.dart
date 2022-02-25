import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:feng/utils/datetime.dart';
import 'package:feng/utils/lunar_calendar.dart';
import 'package:feng/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/lx_state.dart';

class BirthdayPage extends StatefulWidget {
  const BirthdayPage({Key? key}) : super(key: key);

  @override
  _BirthdayPageState createState() => _BirthdayPageState();
}

class _BirthdayPageState extends LxState<BirthdayPage> {
  static const _colorizeColors = [
    Colors.white,
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.yellow,
    Colors.red,
  ];

  static const _colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    height: 1.3,
    fontWeight: FontWeight.bold,
    fontFamily: "LongCang",
    letterSpacing: 1.5,
    shadows: [Shadow(color: Colors.black, offset: Offset(2, 3), blurRadius: 3)],
  );

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

  final _textStyleEn = const TextStyle(
      fontSize: 20,
      height: 1.3,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
      shadows: [
        Shadow(color: Colors.black, offset: Offset(1, 2), blurRadius: 2)
      ],
      color: Colors.white);

  late LunarCalendar _lunarCalendar;
  late DateTime _currentDateTime;

  @override
  void initState() {
    _currentDateTime = DateTime.now();
    _lunarCalendar = LunarCalendar(_currentDateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasBirthday =
        _lunarCalendar.isJinFengBirthday() || _lunarCalendar.isXinBirthday();
    return AnimatedBackground(
      duration: const Duration(seconds: 5),
      child: hasBirthday ? _birthdayContent(context) : _normalContent(context),
      // child: _normalContent(context),
    );
  }

  _birthdayContent(BuildContext context) {
    String birthdayText = "";
    if (_lunarCalendar.isJinFengBirthday()) {
      birthdayText = "锦凤小仙女\n";
    } else if (_lunarCalendar.isXinBirthday()) {
      birthdayText = "小鑫\n";
    }
    birthdayText += "生日快乐";
    return Stack(
      children: [
        _dateTime(),
        Lottie.asset("assets/anim/birthday.json",
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 6),
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 0),
              repeatForever: true,
              animatedTexts: [
                ColorizeAnimatedText(birthdayText,
                    textAlign: TextAlign.center,
                    textStyle: _colorizeTextStyle,
                    colors: _colorizeColors,
                    speed: const Duration(milliseconds: 500)),
                ColorizeAnimatedText(birthdayText,
                    textAlign: TextAlign.center,
                    textStyle: _colorizeTextStyle,
                    colors: _colorizeColors,
                    speed: const Duration(milliseconds: 500)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _normalContent(BuildContext context) {
    return Stack(
      children: [
        _dateTime(),
        Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Lottie.asset("assets/anim/good.json")),
        // Positioned(bottom: 80, left: 0, right: 0, child: Text("今天，也是充满希望的一天！"))
        Positioned(
            bottom: MediaQuery.of(context).size.height / 5,
            left: 0,
            right: 0,
            child: AnimatedTextKit(
              isRepeatingAnimation: true,
              pause: const Duration(seconds: 0),
              repeatForever: true,
              animatedTexts: [
                ScaleAnimatedText('今天，\n也是充满希望的一天！',
                    duration: const Duration(milliseconds: 1500),
                    scalingFactor: 0.9,
                    textStyle: _textStyle,
                    textAlign: TextAlign.center),
                ScaleAnimatedText('Have a great day today!',
                    duration: const Duration(milliseconds: 1500),
                    scalingFactor: 0.9,
                    textStyle: _textStyleEn,
                    textAlign: TextAlign.center)
              ],
            ))
      ],
    );
  }

  _dateTime() {
    return Positioned(
      top: 16,
      left: 16,
      child: Row(
        children: [
          const SizedBox(width: 1.0, height: 80.0),
          Text('${_currentDateTime.year}年', style: _textStyle),
          const SizedBox(width: 1.0, height: 80.0),
          AnimatedTextKit(
            isRepeatingAnimation: true,
            repeatForever: true,
            animatedTexts: [
              RotateAnimatedText(
                  formatMonthDay(_currentDateTime.month, _currentDateTime.day),
                  textStyle: _textStyle,
                  textAlign: TextAlign.start,
                  duration: const Duration(milliseconds: 1500)),
              RotateAnimatedText(_lunarCalendar.monthDay(),
                  textStyle: _textStyle,
                  textAlign: TextAlign.start,
                  duration: const Duration(milliseconds: 2000))
            ],
          ),
        ],
      ),
    );
  }
}
