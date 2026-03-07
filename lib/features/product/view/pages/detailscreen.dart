import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:whatch/features/product/view/pages/producr.dart';
import 'package:whatch/features/product/view/widget/productcolor.dart';
import 'package:whatch/utils/appConstant.dart';

import '../../domain/productentity/product.dart';
import 'detailpage.dart';

class DetailScreen extends StatelessWidget {
  final Watch product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: product.images.length,
        itemBuilder: (context, index) {
          return DetailPage(
            product: product,
            image: product.images[index],
            color: ProductColors.palette[index % ProductColors.palette.length], // later dynamic
          );
        },
      ),
    );
  }
}
