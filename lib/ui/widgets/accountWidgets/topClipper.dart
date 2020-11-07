import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class TopClipper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: TopClip(),
        child: Container(
          decoration: BoxDecoration(color: pColor1),
          height: getPropHeight(120),
        ),
      ),
    );
  }
}

class TopClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Offset cPoint1 = Offset(size.width / 4, size.height / 4);
    Offset cPoint2 = Offset(size.width - 50, size.height - 30);
    Offset ePoint = Offset(size.width, 0.0);

    Path path = Path();
    path.lineTo(0.0, size.height);
    path.cubicTo(
        cPoint1.dx, cPoint1.dy, cPoint2.dx, cPoint2.dy, ePoint.dx, ePoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
