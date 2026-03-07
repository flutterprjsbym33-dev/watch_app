import 'package:flutter/material.dart';
import 'package:whatch/utils/appConstant.dart';

import '../widgests/Bannerss.dart';
import '../widgests/appbar.dart';
import '../widgests/topcurve.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {

    final media = MediaQuery.of(context);

    final screenHeight = media.size.height;
    final screenWidth  = media.size.width;
    final topPadding   = media.padding.top;

    /// TOTAL HEADER INCLUDING SAFE AREA
    final headerHeight = (screenHeight * 0.35) - topPadding;

    final appBarHeight = headerHeight * 0.22;
    final bannerHeight = headerHeight * 0.78;

    final curveHeight = screenHeight * 0.40;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: headerHeight + topPadding,
        width: screenWidth,
        child: Stack(
          children: [

            /// background
            SizedBox(
              height: curveHeight,
              width: screenWidth,
              child: const Topcurve(),
            ),

            Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: SizedBox(
                    height: appBarHeight,
                    child: CustomAppBar(
                      height: appBarHeight,
                      width: screenWidth,
                    ),
                  ),
                ),

                SizedBox(
                  height: bannerHeight,
                  child: Bannerss(height: bannerHeight),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}