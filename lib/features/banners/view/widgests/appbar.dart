import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatch/features/banners/view/widgests/Bannerss.dart';
import 'package:whatch/utils/appConstant.dart';

class CustomAppBar extends StatelessWidget {
  final double height;
  final double width;

  const CustomAppBar({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height*0.85,
            width: width * 0.35,
            child: Image.asset('assets/images/logo2.png'),
          ),

          Row(
            children: const [
              Icon(Icons.notifications, size: 28),
              SizedBox(width: 8),
              Icon(Icons.menu, size: 28),
            ],
          ),
        ],
      ),
    );
  }
}