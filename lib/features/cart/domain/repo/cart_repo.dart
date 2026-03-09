

import 'package:whatch/features/cart/domain/entity/cart_entity.dart';

import '../../../../utils/failure.dart';
import 'package:dart_either/dart_either.dart';


abstract class CartRepository {
//add to cart
  Future<Either<Failure,bool>> addToCart(CartItem cart,String selectedImage);

  // remove from cart
  Future<Either<Failure,bool>> removeFromCart(String shoeId);

//update quantity

  Future<Either<Failure,CartItem>> increaseQty(String shoeId);

  Future<Either<Failure,CartItem>> decreaseQty(String shoeId);

  Future<Either<Failure,List<CartItem>>> getAllCartItems();


}