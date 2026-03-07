import 'package:whatch/features/cart/domain/entity/cart_entity.dart';

abstract class CartMainState{}
class CartInitialState extends CartMainState{}

class AddToCartLoadingState extends CartMainState{}

class AddToCartSuccessState extends CartMainState{
  bool isSucess;
  AddToCartSuccessState({required this.isSucess});
}

class AddToCartErrorState extends CartMainState{
  String errMsg;
  AddToCartErrorState({required this.errMsg});
}

class IncrementQtySuccessState extends CartMainState{
  CartItem cartItem;
  IncrementQtySuccessState({required this.cartItem});
}

class IncrementQtyErrorState extends CartMainState{
  String errMsg;
  IncrementQtyErrorState({required this.errMsg});
}

class GetAllCartItemsSuccessState extends CartMainState{
  List<CartItem> cartItems;
  GetAllCartItemsSuccessState({required this.cartItems});
}
class GetAllCartItemsErrorState extends CartMainState{
  String errMsg;
  GetAllCartItemsErrorState({required this.errMsg});
}

class GetAllCartItemsLoadingState extends CartMainState{}


