import 'package:flutter/material.dart';

import '../../domain/entity/bannerEntity.dart';

abstract class FetchBannerMainState{}

class FetchBannersInitalState extends FetchBannerMainState{}
class FetchBannersLoadingState extends FetchBannerMainState{}
class FetchBannersSuccessState extends FetchBannerMainState{
  List<Banners> banners;
  FetchBannersSuccessState({required this.banners});
}
class FetchBannersErrorState extends FetchBannerMainState{
  String errMsg;
  FetchBannersErrorState({required this.errMsg});
}
