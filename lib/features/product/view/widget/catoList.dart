import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatch/features/product/view/bloc/catocubit/catoCubit.dart';
import 'package:whatch/utils/appConstant.dart';

class Catogories extends StatelessWidget {
   Catogories({super.key});

   int selectedIndex = 0;

  List<String> cato = [
    "Trending",
    "Men",
    "Women",
    "Classic",
    "Digital"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.06,
      child: ListView.separated
        (itemCount: cato.length,
          separatorBuilder: (_,_)=>SizedBox(width: 10,),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index) {
          final state = context.watch<CatoCubit>().state;
          return  GestureDetector(
            onTap: (){
              context.read<CatoCubit>().updateCato(index);

            },
            child: Chip(
              backgroundColor: state == index ? AppConstant.orange : AppConstant.white,
                padding: EdgeInsets.all(5),
                label: Text(cato[index],style: TextStyle(fontSize: 18,color: state == index ? AppConstant.white : AppConstant.black),
                )),
          );
          }
            ),

    );
          }
}
