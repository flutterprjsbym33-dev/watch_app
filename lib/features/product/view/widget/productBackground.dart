import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/appConstant.dart';

class ProductBackGroundCard extends StatelessWidget {
  String title,price;
  final itemHeight;
   ProductBackGroundCard({super.key,
    required this.title,
    required this.price,
     required this.itemHeight
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0,bottom: 6,left: 6,right: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ibmPlexSans(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$$price",
                  style: GoogleFonts.ibmPlexMono(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      )
                  ),
                ),
                SizedBox(
                  height: itemHeight*0.1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Image.asset('assets/images/plus.png'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
