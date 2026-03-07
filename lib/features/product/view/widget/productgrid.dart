import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:whatch/features/product/view/bloc/productstates.dart';
import 'package:whatch/features/product/view/widget/productBackground.dart';
import 'package:whatch/features/product/view/widget/productShimmer.dart';
import 'package:whatch/utils/appConstant.dart';
import '../bloc/productstatecubit.dart';
import '../pages/detailscreen.dart';




class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});



  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProductStateCubit, ProductMainState>(
      builder: (context, state) {

        if (state is ProductLoadingState) {
          return SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (context,index)=>Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShiimerProduct(),
                  ),
                childCount: 4

              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 5,
                childAspectRatio: 0.7,
              ));
        }

        if (state is ProductFetchedSuccessState) {

          final products = state.products;

          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final product = products[index];

                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {

                      final itemHeight = constraints.maxHeight;
                      final itemWidth = constraints.maxWidth;

                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 1000),
                        child: SlideAnimation(
                          verticalOffset: 80.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                onTap: (){
                                  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailScreen(product: product),
                                    ),
                                  );

                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [

                                    /// BACKGROUND CARD (90%)
                                    Positioned(
                                      top: itemHeight * 0.12,
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(16),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 12,
                                              color: Colors.black12,
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,

                                          children: [
                                            SizedBox(
                                              child: ProductBackGroundCard(title: product.title,
                                                  price: product.price, itemHeight: itemHeight),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),

                                    /// IMAGE (80%)
                                    Positioned(
                                      top: 0,
                                      left: itemWidth * 0.1,
                                      right: itemWidth * 0.1,
                                      height: itemHeight * 0.7,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Image.network(
                                            product.thumbnail,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: products.length,
            ),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}