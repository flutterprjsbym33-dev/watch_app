import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatch/features/product/view/bloc/productstatecubit.dart';
import 'package:whatch/features/product/view/widget/catoList.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  @override
  void initState() {
    super.initState();
    context.read<ProductStateCubit>().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {

    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.only(top: 4,left: 8,right: 8,bottom: 12),
          child: Card(
            elevation: 4,
            color: Colors.white.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: GoogleFonts.ibmPlexSans(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Catogories(),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
