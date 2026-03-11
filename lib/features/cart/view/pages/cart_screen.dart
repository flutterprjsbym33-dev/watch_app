import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:intl/intl.dart';

import 'package:whatch/app/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import 'package:whatch/features/cart/view/bloc/cart_states.dart';
import 'package:whatch/features/cart/view/bloc/catt_main_cubit.dart';
import 'package:whatch/features/cart/view/widget/CartCheckOutSection.dart';
import 'package:whatch/features/cart/view/widget/cart_peritem.dart';

import '../../../product/view/bloc/cart_selector-cubit/CartSelectorCubit.dart';
import '../../../product/view/bloc/cart_selector-cubit/cart_selector_index.dart';
import '../../../product/view/widget/productShimmer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();

    context.read<CartManagerCubit>().getAllCartItems();
    context.read<BottomNavCubitHide>().show();
  }

  @override
  Widget build(BuildContext context) {
    final visible = context.watch<BottomNavCubitHide>().state;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return BlocListener<CartSelectorCubit, CartCheckOutState>(
      listener: (_,state){
        if(state.selectedIndex.isNotEmpty || state.isAllSelected){
          context.read<BottomNavCubitHide>().hide();
        }else{
          context.read<BottomNavCubitHide>().show();
        }

      },
      child:  Scaffold(
          appBar: AppBar(
            title: Text(
              'My Cart',
              style: GoogleFonts.aldrich(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// CHECKOUT SECTION
          bottomNavigationBar: visible
              ? null
              : SizedBox(
            height: height * 0.12,
            width: double.infinity,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: CartCheckOutSection(),
            ),
          ),

          /// BODY
          body: BlocBuilder<CartManagerCubit, CartMainState>(
            builder: (context, state) {
              if (state is GetAllCartItemsLoadingState) {
                return ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) =>  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Shimmer(child: ShiimerProduct()),
                    ),
                  ),
                );
              }

              if (state is GetAllCartItemsSuccessState) {
                return ListView.separated(
                  separatorBuilder: (context, _) =>
                  const SizedBox(height: 15),
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final rawDate = state.cartItems[index].dateTime;
                    final formattedDate =
                    DateFormat('yyyy-MM-dd').format(rawDate);

                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(formattedDate),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Container(
                          height: height * 0.16,
                          width: double.infinity,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return CartPerItem(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                cartItem: state.cartItems[index],
                                index: index,
                                items: state.cartItems,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }

              return const Center(
                child: Text("No Items Available"),
              );
            },
          ),
        )

    );
  }
}