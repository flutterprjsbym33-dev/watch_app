import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:whatch/features/banners/view/bloc/FetchBannerState.dart';
import 'package:whatch/features/banners/view/bloc/fetchbannerscubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:whatch/utils/appConstant.dart';
import 'package:whatch/utils/snackBar.dart';

class Bannerss extends StatefulWidget {
  final height;
  
  const Bannerss({super.key,required this.height});

  @override
  State<Bannerss> createState() => _BannerssState();
}

class _BannerssState extends State<Bannerss> {
  late final height;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    
    context.read<FetchBannersCubit>().fetchBanners();
    height=widget.height;

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchBannersCubit,FetchBannerMainState>(
      builder: (context,state) {
        if(state is FetchBannersLoadingState)
          {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  child: Shimmer(
                    duration: Duration(seconds: 3), //Default value
                    interval: Duration(seconds: 5), //Default value: Duration(seconds: 0)
                    color: Colors.white, //Default value
                    colorOpacity: 0, //Default value
                    enabled: true, //Default value
                    direction: ShimmerDirection.fromLTRB(),  //Default Value
                    child: Container(
                      height: height*0.7,width: double.infinity,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ),
            );
          }
        if(state is FetchBannersSuccessState)
          {
            return PageView.builder(
              itemCount: state.banners.length,
                onPageChanged: (index){
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context,index)
                {

                  return
                      SizedBox(
                        height: height,width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0,right: 12,top: 8,bottom: 8),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: AnotherCarousel(images: state.banners.map((i)=>CachedNetworkImage(
                                imageUrl: i.imageUrl,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => Shimmer(
                                  duration: Duration(seconds: 3), //Default value
                                  interval: Duration(seconds: 5), //Default value: Duration(seconds: 0)
                                  color: Colors.white, //Default value
                                  colorOpacity: 0, //Default value
                                  enabled: true, //Default value
                                  direction: ShimmerDirection.fromLTRB(),  //Default Value
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              )).toList(),
                                dotSize: 0,
                                autoplay: true,
                                dotColor: Colors.transparent,
                                dotBgColor: Colors.transparent,)
                          ),
                        ),

                  );

                }
            );
          }
        else{
          return  SizedBox(
            height: height,width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Shimmer(
                  duration: Duration(seconds: 3), //Default value
                  interval: Duration(seconds: 5), //Default value: Duration(seconds: 0)
                  color: Colors.white, //Default value
                  colorOpacity: 0, //Default value
                  enabled: true, //Default value
                  direction: ShimmerDirection.fromLTRB(),  //Default Value
                  child: Container(
                    height: height,width: double.infinity,
                    color: AppConstant.darkGrey,
                  ),
                ),
              ),
            ),
          );
        }
      }
    );
  }
}
