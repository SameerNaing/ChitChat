import 'package:flutter/material.dart';

import 'package:chit_chat/ui/ui.dart';

class BottomClipper extends StatelessWidget {
  const BottomClipper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: BottomClip(),
        child: Container(
          decoration: BoxDecoration(
            color: pColor1,
          ),
          height: getPropHeight(150),
          width: SizeConfig.screenWidth,
        ),
      ),
    );
  }
}

class BottomClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Offset cPoint1 = Offset(size.width - 20, size.height - 20);
    Offset cPoint2 = Offset(size.width / 4, size.height / 4);
    Offset ePoint = Offset(0, size.height);

    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    path.cubicTo(
        cPoint1.dx, cPoint1.dy, cPoint2.dx, cPoint2.dy, ePoint.dx, ePoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
