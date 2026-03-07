import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatch/features/banners/domain/bannerUseCases/getBanners.dart';
import 'package:whatch/features/banners/view/bloc/FetchBannerState.dart';

class FetchBannersCubit extends Cubit<FetchBannerMainState>
{
  GetBanners getBanners;

  FetchBannersCubit({required this.getBanners}):super(FetchBannersInitalState());

  void fetchBanners()async
  {
     final banners = await getBanners.call();
     emit(FetchBannersLoadingState());
     banners.fold(
         ifLeft: (error)=>emit(FetchBannersErrorState(errMsg: error.errMsg)) ,
         ifRight: (success)=>emit(FetchBannersSuccessState(banners: success)));
  }


}