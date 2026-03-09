import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import 'package:whatch/features/cart/domain/usecase/add_to_car_usecase.dart';
import 'package:whatch/features/cart/domain/usecase/decrement_item.dart';
import 'package:whatch/features/cart/domain/usecase/get_all_cart_items.dart';
import 'package:whatch/features/cart/domain/usecase/increment_item.dart';
import 'package:whatch/features/cart/view/bloc/cart_states.dart';

class CartManagerCubit extends Cubit<CartMainState>
{
  AddToCart addToCartUseCase;
  IncrementItem incrementItem;
  GetCartItems getCartItems;
  DecrementItem decrementItem;
  CartManagerCubit({
    required this.addToCartUseCase,
    required this.incrementItem,
    required this.getCartItems,
    required this.decrementItem
   }):super(CartInitialState());


   void addToCart(CartItem cartItem,String selectedImage)async
   {
     emit(AddToCartLoadingState());
    final response = await addToCartUseCase.call(cartItem, selectedImage);
    response.fold(ifLeft: (failure)=>emit(AddToCartErrorState(errMsg: failure.errMsg)),
        ifRight: (sucess)=>emit(AddToCartSuccessState(isSucess: sucess)));
   }

   void getAllCartItems()async
   {
     emit(GetAllCartItemsLoadingState());
     final response =  await getCartItems.call();
     response.fold(ifLeft: (failure)=>emit(GetAllCartItemsErrorState(errMsg: failure.errMsg)),
         ifRight: (success)=>emit(GetAllCartItemsSuccessState(cartItems: success)));

   }

   void increaseCartQty(String id,String selectedImage)async
   {
     final cartId = "${id}_$selectedImage";
     final response = await incrementItem.call(cartId);
     response.fold(ifLeft: (failure)=>{emit(IncrementQtyErrorState(errMsg: failure.errMsg))},
         ifRight: (success)=>{
         getAllCartItems(),
       emit(IncrementQtySuccessState(cartItem: success))

     });

   }

  void decreasseCartQty(String id,String selectedImage)async
  {
    final cartId = "${id}_$selectedImage";
    final response = await decrementItem.call(cartId);
    response.fold(ifLeft: (failure)=>{emit(IncrementQtyErrorState(errMsg: failure.errMsg))},
        ifRight: (success)=>{
          getAllCartItems(),
          emit(IncrementQtySuccessState(cartItem: success))
        });

  }





}