import 'package:flutter/material.dart';
import 'package:whatch/utils/appConstant.dart';
class CtustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
 final Size height;
   CtustomAppBar({super.key,required this.height}):preferredSize= Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
           title: Row(
             children: [
               Expanded(
                 flex: 85,
                   child: SizedBox(
                     height: 45,
                     child: TextField(
                       decoration: InputDecoration(
                         prefixIcon: Icon(Icons.search),
                         filled: true,
                         fillColor: Colors.grey.shade300,
                         border: OutlineInputBorder(
                           borderSide: BorderSide.none,
                           borderRadius: BorderRadius.circular(15)
                         ),
                         hintText: "Search"
                       ),
                     ),
                   )),
               SizedBox(width: 10,),
               Expanded(
                 flex: 15,
                   child: GestureDetector(
                     onTap: (){},
                     child: Container(
                       height: 40,
                       decoration: BoxDecoration(
                         color: AppConstant.orange,
                         borderRadius: BorderRadius.circular(10)
                       ),
                       child: Padding(
                         padding: EdgeInsets.all(4),
                           child: Image.asset("assets/images/settings.png",)),
                     ),
                   ))

             ],
           ),

    );
  }


}
