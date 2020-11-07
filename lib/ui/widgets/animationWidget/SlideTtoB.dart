import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:meta/meta.dart';

// SlideBtoT = SlideAnimation Bottom to Top
enum SlideTtoBProps { translate }

class SlideTtoB extends StatelessWidget {
  final double delay;
  final Widget child;
  SlideTtoB({
    Key key,
    @required this.delay,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween()
      ..add(
        SlideTtoBProps.translate,
        Tween(begin: -200.0, end: 0.0),
        Duration(milliseconds: 500),
        Curves.easeOut,
      );
    return CustomAnimation(
        delay: Duration(milliseconds: (500 * delay).round()),
        duration: tween.duration,
        tween: tween,
        child: child,
        builder: (context, child, animation) {
          return Transform.translate(
            offset: Offset(animation.get(SlideTtoBProps.translate),
                animation.get(SlideTtoBProps.translate)),
            child: child,
          );
        });
  }
}
