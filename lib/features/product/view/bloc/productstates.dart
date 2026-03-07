import 'package:whatch/features/product/datasource/productmapper/productMapper.dart';
import 'package:whatch/features/product/domain/productentity/product.dart';

abstract class ProductMainState {}

class ProductInitialState extends ProductMainState {}

class ProductLoadingState extends ProductMainState {}

class ProductFetchedSuccessState extends ProductMainState {
  final List<Watch> products;

  ProductFetchedSuccessState({required this.products});
}

class ProductFetchedErrorState extends ProductMainState {
  final String errorMessage;

  ProductFetchedErrorState({required this.errorMessage});
}

class ProductEmptyState extends ProductMainState {}

class ProductRefreshingState extends ProductMainState {}