import 'package:flutter/material.dart';
import 'package:whatch/app/home.dart';
import 'package:whatch/utils/appConstant.dart';


class BottomItems {
  String icons,name;
  BottomItems({required this.name,required this.icons});
}

class FirstHomeScreen  extends StatelessWidget {
    FirstHomeScreen ({super.key});
  
  List<BottomItems> navbarItens = 
  [
    BottomItems(name: 'Home', icons: 'assets/images/btn_1.png'),
    BottomItems(name: 'Cart', icons: 'assets/images/btn_2.png'),
    BottomItems(name: 'Favourite', icons: 'assets/images/btn_3.png'),
    BottomItems(name: 'CheckIN', icons: 'assets/images/btn_4.png'),
    BottomItems(name: 'Profile', icons: 'assets/images/btn_5.png')
    
  ];
  
  int selectedIndex  = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: PageView(
              children: const [
                HomeScreen()
              ],
            )
        ),
       
       Align(
         alignment: Alignment.bottomCenter,
         child: Padding(
           padding: const EdgeInsets.all(5.0),
           child: Container(
             padding: EdgeInsets.all(8),
             decoration: BoxDecoration(
                 color: AppConstant.black2,
               borderRadius: BorderRadius.circular(20)
               
             ),
             height: 70,width: double.infinity,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: List.generate(navbarItens.length, (index)=> LayoutBuilder(
                 builder: (context,constraintss) {
                   return Container(
                     padding: EdgeInsets.all(5),
                     height: constraintss.maxHeight,width: 65,
                     decoration: selectedIndex == index ?
                     BoxDecoration(
                       borderRadius: BorderRadius.circular(25),
                       gradient: LinearGradient(colors: [
                         Colors.orange.shade200,
                         AppConstant.orange.withOpacity(0.5)
                       ]),
                       boxShadow: [
                         BoxShadow(
                           color: AppConstant.black2,
                           blurRadius: 12
                         )
                       ]
                     ) : null,
                     child: Center(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Image.asset(navbarItens[index].icons,
                               height:  selectedIndex == index ? constraintss.maxHeight*0.3 : constraintss.maxHeight*0.5),
                           SizedBox(height: 5,),
                           selectedIndex == index ?
                           Text(navbarItens[index].name,style:
                           TextStyle(fontSize: 10,color: Colors.white,
                           decoration: TextDecoration.none),
                           overflow: TextOverflow.ellipsis,
                            ) : SizedBox()
                         ],
                       ),
                     ),
                   );
                 }
               )),
             ),
           ),
         ),
       )
      ],

    );
  }
}
