import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatch/app/home.dart';
import 'package:whatch/features/cart/view/pages/cart_screen.dart';
import 'package:whatch/utils/appConstant.dart';

import '../bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import '../bloc/bottom_navigator_cubit/bottom_nav_cubit.dart';


class BottomItems {
  String icons,name;
  BottomItems({required this.name,required this.icons});
}

class FirstHomeScreen extends StatefulWidget {
  FirstHomeScreen ({super.key});

  @override
  State<FirstHomeScreen> createState() => _FirstHomeScreen();
}




class _FirstHomeScreen  extends State<FirstHomeScreen> {
    _FirstHomeScreen();

    late final PageController _pageController;
  
  List<BottomItems> navbarItens = 
  [
    BottomItems(name: 'Home', icons: 'assets/images/btn_1.png'),
    BottomItems(name: 'Cart', icons: 'assets/images/btn_2.png'),
    BottomItems(name: 'Favourite', icons: 'assets/images/btn_3.png'),
    BottomItems(name: 'CheckIN', icons: 'assets/images/btn_4.png'),
    BottomItems(name: 'Profile', icons: 'assets/images/btn_5.png')
    
  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();


  }

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }
  


  @override
  Widget build(BuildContext context) {
    int selectedIndex = context.watch<BottomNavigatorCubit>().state;
    return BlocListener<BottomNavigatorCubit,int>(
      listener: (context,state) {
        _pageController.animateToPage(
          state,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
        selectedIndex = state;



      },
        child : Stack(
          children: [
            Positioned.fill(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index){
                    context.read<BottomNavigatorCubit>().addIndex(index);
                  },
                  children: const [
                    HomeScreen(),
                    CartScreen()

                  ],
                )
            ),

           //Bottom bar ------------------------------------------------------------

           BlocBuilder<BottomNavCubitHide,bool>(
             builder: (context,visible) {
               return AnimatedSlide(
                 offset:  visible ? Offset(0, 0) : Offset(0,1),
                 duration: Duration(milliseconds: 500),
                 child: Align(
                   alignment: Alignment.bottomCenter,
                   child: GestureDetector(
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
                               return GestureDetector(
                                 onTap: (){
                                   context.read<BottomNavigatorCubit>().addIndex(index);
                                 },
                                 child: Container(
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
                                 ),
                               );
                             }
                           )),
                         ),
                       ),
                     ),
                   ),
                 ),
               );
             }
           )
          ],

        )
    );}

  }

