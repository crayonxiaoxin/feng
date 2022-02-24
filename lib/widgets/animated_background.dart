import 'package:flutter/material.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';

enum _GradientTween { begin, end }

class AnimatedBackground extends StatelessWidget {
  final Widget? child;
  final Duration duration;
  final ColorTween? beginColorTween;
  final ColorTween? endColorTween;
  final Alignment beginAlign;
  final Alignment endAlign;
  final Curve curve;
  late var _tween;

  AnimatedBackground(
      {Key? key,
      this.child,
      this.duration = const Duration(seconds: 3),
      this.beginColorTween,
      this.endColorTween,
      this.beginAlign = Alignment.topCenter,
      this.endAlign = Alignment.bottomCenter,
      this.curve = Curves.easeInOutQuad})
      : super(key: key) {
    _tween = MultiTween<_GradientTween>()
      ..add(
          _GradientTween.begin,
          beginColorTween ??
              ColorTween(begin: Colors.orange, end: Colors.lightBlue.shade900))
      ..add(
          _GradientTween.end,
          endColorTween ??
              ColorTween(begin: Colors.purple, end: Colors.blue.shade300));
  }

  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<MultiTweenValues<_GradientTween>>(
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                value.get(_GradientTween.begin),
                value.get(_GradientTween.end)
              ])),
          child: child,
        );
      },
      tween: _tween,
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}
