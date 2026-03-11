import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../app/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import 'package:whatch/features/cart/view/bloc/catt_main_cubit.dart';
import 'package:whatch/features/product/view/bloc/cart_selector-cubit/cart_selector_index.dart';
import 'package:whatch/utils/appConstant.dart';

class CartPerItem extends StatelessWidget {
  final height;
  final width;
  int index;
  CartItem cartItem;
  List<CartItem> items;

  CartPerItem({
    super.key,
    required this.height,
    required this.width,
    required this.cartItem,
    required this.index,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartSelectorCubit>().state;

    final rawDate = cartItem.dateTime;
    final formattedDate = DateFormat('yyyy-MM-dd').format(rawDate);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Card(
        elevation: 4,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// SELECT CHECKBOX
            Center(
              child: IconButton(
                onPressed: () {
                  context.read<CartSelectorCubit>().selectIndex(index, items);

                },
                icon: state.selectedIndex.contains(index) ||
                    state.isAllSelected
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank_rounded),
              ),
            ),

            /// PRODUCT IMAGE
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    cartItem.selectedItemImage,
                    height: height,
                    width: width * 0.18,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 5),

            /// PRODUCT DETAILS
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TITLE
                    Text(
                      cartItem.title,
                      style: GoogleFonts.akatab(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// DESCRIPTION
                    Text(
                      cartItem.discrip,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.akatab(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// PRICE + QTY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// PRICE
                        Text(
                          "\$.${cartItem.subtotal.toStringAsFixed(2)}",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.akatab(
                            color: AppConstant.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        /// QUANTITY CONTROL
                        Row(
                          children: [
                            Container(
                              height: height * 0.15,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade300,
                              ),
                              child: Center(
                                child: IconButton(
                                  padding: const EdgeInsets.only(top: 9),
                                  icon: const Icon(Icons.maximize_sharp,
                                      size: 15),
                                  onPressed: () {
                                    context
                                        .read<CartManagerCubit>()
                                        .decreasseCartQty(
                                      cartItem.id,
                                      cartItem.selectedItemImage,
                                    );
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            Text('${cartItem.qunantity}'),

                            const SizedBox(width: 8),

                            Container(
                              height: height * 0.15,
                              width: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey.shade300,
                              ),
                              child: Center(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.add, size: 15),
                                  onPressed: () {
                                    context
                                        .read<CartManagerCubit>()
                                        .increaseCartQty(
                                      cartItem.id,
                                      cartItem.selectedItemImage,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}