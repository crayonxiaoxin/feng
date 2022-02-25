import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class CustomTyperAnimatedText extends AnimatedText {
  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 200 milliseconds.
  final Duration speed;

  /// The [Curve] of the rate of change of animation over time.
  ///
  /// By default it is set to Curves.linear.
  final Curve curve;

  final Axis direction;

  final List<String> textList;
  final List<TextStyle> textStyleList;
  final WrapCrossAlignment horizontalCrossAlignment;
  final CrossAxisAlignment verticalCrossAlignment;

  CustomTyperAnimatedText({
    required this.textList,
    required this.textStyleList,
    this.direction = Axis.horizontal,
    TextAlign textAlign = TextAlign.start,
    this.speed = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
    this.horizontalCrossAlignment = WrapCrossAlignment.center,
    this.verticalCrossAlignment = CrossAxisAlignment.start,
  }) : super(
          text: list2String(textList),
          textAlign: textAlign,
          textStyle: null,
          duration: speed * list2String(textList).characters.length,
        );

  late Animation<double> _typingText;

  @override
  Duration get remaining => speed * (textCharacters.length - _typingText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typingText = CurveTween(
      curve: curve,
    ).animate(controller);
  }

  /// Widget showing partial text, up to [count] characters
  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    /// Output of CurveTween is in the range [0, 1] for majority of the curves.
    /// It is converted to [0, textCharacters.length].
    final count =
        (_typingText.value.clamp(0, 1) * textCharacters.length).round();

    assert(count <= textCharacters.length);
    return customTextWidget(count);
  }

  Widget customTextWidget(int count) {
    var newList = getSubStrListByIndex(textList, count);
    var children = [
      ...newList
          .asMap()
          .map((index, e) {
            var item = Text(e,
                textAlign: textAlign, style: textStyleList[newList.indexOf(e)]);
            return MapEntry(index, item);
          })
          .values
          .toList()
    ];
    return direction == Axis.horizontal
        ? Wrap(crossAxisAlignment: horizontalCrossAlignment, children: children)
        : Column(
            children: children, crossAxisAlignment: verticalCrossAlignment);
  }

  @override
  Widget completeText(BuildContext context) {
    return customTextWidget(textCharacters.length);
  }
}

String list2String(List<String> list) {
  String str = "";
  for (var element in list) {
    str += element;
  }
  return str;
}

List<int> strList2LenList(List<String> list) {
  var lenList = <int>[];
  for (var element in list) {
    lenList.add(element.length);
  }
  return lenList;
}

List<String> getSubStrListByIndex(List<String> list, int count) {
  if (count == 0) return [];
  var positions = strList2LenList(list);
  var newList = <String>[];
  // 范围上限
  var tmpLenUpper = 0;
  // 范围下限
  var tmpLenLower = 0;
  for (var i = 0; i < positions.length; i++) {
    var len = positions[i];
    tmpLenUpper += len;
    if (count == tmpLenUpper) {
      newList.add(list[i]);
      return newList;
    } else if (count < tmpLenUpper) {
      /// 假设 [7,3,2]
      /// count
      /// 1 < 7   1
      /// 2 < 7   2
      /// 3 < 7   3
      /// 4 < 7   4
      /// 5 < 7   5
      /// 6 < 7   6
      /// 7 = 7
      /// 8 < 10  1  8-7
      /// 9 < 10  2  9-7
      /// 10= 10
      /// 11< 12  1  11-10
      /// 12= 12
      newList.add(list[i].substring(0, count - tmpLenLower));
      return newList;
    } else {
      newList.add(list[i]);
      tmpLenLower += len;
    }
  }
  return list;
}
