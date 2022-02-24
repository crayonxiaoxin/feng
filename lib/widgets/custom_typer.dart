import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class CustomTyperAnimatedText extends AnimatedText {
  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 40 milliseconds.
  final Duration speed;

  /// The [Curve] of the rate of change of animation over time.
  ///
  /// By default it is set to Curves.linear.
  final Curve curve;

  final List<String> textList;
  final List<TextStyle> textStyleList;
  late List<int> positionList;

  CustomTyperAnimatedText(
    this.textList,
    this.textStyleList, {
    TextAlign textAlign = TextAlign.start,
    this.speed = const Duration(milliseconds: 40),
    this.curve = Curves.linear,
  }) : super(
          text: list2String(textList),
          textAlign: textAlign,
          textStyle: null,
          duration: speed * list2String(textList).characters.length,
        ) {
    positionList = list2StringPositions(textList);
  }

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
    var newList = list2StringGetSub(textList, count);
    print("newList $newList");
    return Wrap(
      children: [
        ...newList
            .asMap()
            .map((index, e) {
              return MapEntry(
                  index,
                  Text(
                    e,
                    textAlign: textAlign,
                    style: textStyleList[newList.indexOf(e)],
                  ));
            })
            .values
            .toList()
      ],
    );
  }

  @override
  Widget completeText(BuildContext context) {
    var newList = textList;
    return Wrap(
      children: [
        ...newList
            .asMap()
            .map((index, e) {
              return MapEntry(
                  index,
                  Text(
                    e,
                    textAlign: textAlign,
                    style: textStyleList[newList.indexOf(e)],
                  ));
            })
            .values
            .toList()
      ],
    );
  }
}

String list2String(List<String> list) {
  String str = "";
  for (var element in list) {
    str += element;
  }
  return str;
}

List<int> list2StringPositions(List<String> list) {
  var text = "";
  var positionList = <int>[];
  for (var element in list) {
    positionList.add(0 + text.length);
    text += element;
  }
  print("positions $positionList");
  return positionList;
}

List<String> list2StringGetSub(List<String> list, int count) {
  if (count == 0) return [];
  if (count == list.length) return list;
  var positions = list2StringPositions(list);
  var index = count - 1;
  var newList = <String>[];
  var tmpLen = 0;
  for (var i = 0; i < positions.length; i++) {
    // todo: 这里遍历有问题
    // [0, 7, 10]
    // count	index
    // 0   			[]
    //
    // 1   	0		list[0][0,1]
    // 2		1		list[0][0,2]
    // 3   	2		list[0][0,3]
    // 4   	3		list[0][0,4]
    // 5   	4		list[0][0,5]
    // 6   	5		list[0][0,6]
    // 7   	6		list[0]
    //
    // 8   	7		list[0] + list[1][0,1]
    // 9   	8		list[0] + list[1][0,2]

    var value = positions[i];
    var len = list[i].length;
    if (value == index) {
      print("index111 $index, $tmpLen, ${list[i]}");
      newList.add(list[i].substring(0, 1));
      return newList;
    } else if (value > index) {
      print("index222 $index, $tmpLen, ${list[i]}");
      newList.add(list[i].substring(0, index - tmpLen));
      return newList;
    } else if (index >= len) {
      newList.add(list[i]);
      tmpLen += len;
    } else {
      if (index >= len) {
        newList.add(list[i]);
        tmpLen += len;
      } else {
        print("index333 $index, $tmpLen, ${list[i]}");
        var lenCut = index - value;
        newList.add(list[i].substring(0, lenCut + 1));
        tmpLen += lenCut;
      }
    }
  }
  return list;
}
