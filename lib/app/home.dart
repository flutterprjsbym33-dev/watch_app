import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatch/app/widgets/appbar.dart';
import 'package:whatch/features/banners/view/pages/Banners.dart';
import 'package:whatch/features/product/view/pages/producr.dart';
import 'package:whatch/features/product/view/widget/productgrid.dart';

import 'bloc/bottom_nav_bloc/bottom_nav_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   _HomeScreenState();

   final ScrollController _controller = ScrollController();

   double lastOffset = 0;
   final double threshold = 20;

   @override
   void initState() {
     super.initState();

     _controller.addListener(() {

       double currentOffset = _controller.offset;
       double difference = currentOffset - lastOffset;

       if (difference > threshold) {
         context.read<BottomNavCubitHide>().hide();
         lastOffset = currentOffset;
       }

       else if (difference < -threshold) {
         context.read<BottomNavCubitHide>().show();
         lastOffset = currentOffset;
       }

     });
   }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size;
    return
      Scaffold(
        body:
           CustomScrollView(
             controller: _controller,
            slivers: [
             Banners(),
              Product(),
              ProductGrid()
          
          
          
            ],
          ));


  }
}
