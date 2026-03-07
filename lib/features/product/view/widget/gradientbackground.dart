import 'dart:ui';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Color color;

  const GradientBackground({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.55, 1.0],
          colors: [
            color.withOpacity(.95),
            color.withOpacity(.65),
            color.withOpacity(.25),  // light bottom
          ],
        ),
      ),
    );
  }
}