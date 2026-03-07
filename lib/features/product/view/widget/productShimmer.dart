import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../utils/appConstant.dart';

class ShiimerProduct extends StatelessWidget {
  const ShiimerProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer
      (child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Shimmer(
        duration: Duration(seconds: 3), //Default value
        interval: Duration(seconds: 3), //Default value: Duration(seconds: 0)
        color: Colors.white, //Default value
        colorOpacity: 0, //Default value
        enabled: true, //Default value
        direction: ShimmerDirection.fromLTRB(),  //Default Value
        child: Container(
          color: AppConstant.darkGrey,
        ),
      ),
    ),);
  }
}
