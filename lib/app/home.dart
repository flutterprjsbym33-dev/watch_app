import 'package:flutter/material.dart';
import 'package:whatch/app/widgets/appbar.dart';
import 'package:whatch/features/banners/view/pages/Banners.dart';
import 'package:whatch/features/product/view/pages/producr.dart';
import 'package:whatch/features/product/view/widget/productgrid.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size;
    return
      Scaffold(
        body: CustomScrollView(
          slivers: [
           Banners(),
            Product(),
            ProductGrid()



          ],
        ),
      );

  }
}
