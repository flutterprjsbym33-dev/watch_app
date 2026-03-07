import 'package:flutter/material.dart';
import 'package:whatch/utils/appConstant.dart';

class Topcurve extends StatelessWidget {
  const Topcurve({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ClipPath(
      clipper: TopCurveClipper(),
      child: Container(

        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.brown.shade500,
              Colors.grey.shade400
            ])
        ),
      ),
    );

  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 60,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

