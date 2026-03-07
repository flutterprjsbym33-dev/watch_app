

import 'package:whatch/features/cart/domain/entity/cart_entity.dart';

import '../../../../utils/failure.dart';
import 'package:dart_either/dart_either.dart';


abstract class CartRepository {
//add to cart
  Future<Either<Failure,bool>> addToCart(CartItem cart);

  // remove from cart
  Future<Either<Failure,bool>> removeFromCart(String shoeId);

//update quantity

  Future<Either<Failure,CartItem>> increaseQty(String shoeId,int quantity);

  Future<Either<Failure,List<CartItem>>> getAllCartItems();


}