import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:meta/meta.dart';

// FadeTtoB = FadeAnimation Slide Top to Bottom
enum FadeTtoBProp { opacity, translateY }

class FadeTtoB extends StatelessWidget {
  final double delay;
  final Widget child;
  FadeTtoB({
    Key key,
    @required this.delay,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween()
      ..add(
        FadeTtoBProp.opacity,
        Tween(begin: 0.0, end: 1.0),
        Duration(milliseconds: 500),
      )
      ..add(
        FadeTtoBProp.translateY,
        Tween(begin: -30.0, end: 0.0),
        Duration(milliseconds: 500),
        Curves.easeOut,
      );
    return CustomAnimation(
        delay: Duration(milliseconds: (500 * delay).round()),
        duration: tween.duration,
        tween: tween,
        child: child,
        builder: (context, child, animation) {
          return Opacity(
              opacity: animation.get(FadeTtoBProp.opacity),
              child: Transform.translate(
                offset: Offset(0, animation.get(FadeTtoBProp.translateY)),
                child: child,
              ));
        });
  }
}
