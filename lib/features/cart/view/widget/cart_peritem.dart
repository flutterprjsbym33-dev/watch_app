import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import 'package:whatch/utils/appConstant.dart';
import 'package:intl/intl.dart';

class CartPerItem extends StatelessWidget {
  final height, width;
  CartItem cartItem;

  CartPerItem({super.key, required this.height, required this.width, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final rawDate = cartItem.dateTime;
    final formattedDate = DateFormat('yyyy-MM-dd').format(rawDate);

    return  Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8),
      child: Card(
        elevation: 4,
        child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Keep this as start
                children: [
                  // Leading select Icon - Centered vertically
                  Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check_box_outline_blank_rounded),
                    ),
                  ),

                  // Selected cart image - Centered vertically
                  Center(
                    child: Container(

                      decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15)

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
                  SizedBox(width: 5,),

                  // Title for cartitem - Aligned from top
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start, // Start from top
                        children: [
                          Text(
                            cartItem.title,
                            style: GoogleFonts.akatab(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            cartItem.discrip,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.akatab(
                              fontWeight: FontWeight.w200,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "\$ ${cartItem.price}",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.akatab(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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
