import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatch/features/banners/view/bloc/FetchBannerState.dart';
import 'package:whatch/features/product/domain/productUseCases/getProduct.dart';
import 'package:whatch/features/product/view/bloc/productstates.dart';

class ProductStateCubit extends Cubit<ProductMainState>
{
  GetProduct getProduct;
  ProductStateCubit( { required this.getProduct}):super(ProductInitialState());

  void fetchProduct()async
  {
    emit(ProductLoadingState());
    final data = await getProduct.call();
    data.fold(ifLeft: (failure)=>emit(ProductFetchedErrorState(errorMessage: failure.errMsg)),
        ifRight: (success)=>emit(ProductFetchedSuccessState(products: success)));


  }


}