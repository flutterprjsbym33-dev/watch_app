import 'dart:io';

import 'package:whatch/features/cart/data/model/cart_model.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import 'package:whatch/utils/appExpections.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDataSource{
  Future<bool> addToCart(CartItem cart,String selectedImage);

  Future<bool> removeFromCart(String shoeId);

  Future<CartItem> increaseQty(String shoeId);

  Future<CartItem> decreaseQty(String shoeId);

  Future<List<CartItem>> getAllCartItems();
}

class CartLocalDataSourceImp extends CartLocalDataSource{

  Box<CartModel> cartBox;

  CartLocalDataSourceImp({required this.cartBox});

  // ADD TO CART ------------------------------------------------------------------------------------

  @override
  Future<bool> addToCart(CartItem cart,String selectedImage)async {
    try{
      final id = "${cart.id}_$selectedImage";
      final existing = cartBox.get(id);
      if(existing!=null)
        {
          existing.updateQuantity(existing.quantity+1);
          existing.save();
          return true;
        }
      else{
        cartBox.put(id,
            CartModel.fromProduct(product: cart, selectedImage: selectedImage));
        return true;
      }

    } on SocketException
    {
      throw NoInternetException();
    } catch (e)
    {
      throw CatchedExpection();
    }
  }

  //GET ALL CART ITEMS -----------------------------------------------------------------

  @override
  Future<List<CartItem>> getAllCartItems()async {
    try{
      final cartItems =  await cartBox.values.map((e)=>e.fromModel(cartItem: e)).toList();
      return cartItems;
    }on SocketException{
      throw NoInternetException();
    } catch (e){
      throw ServerErrorException();
    }

  }



  @override
  Future<CartItem> increaseQty(String shoeId)async {
    try{

      final beforeUpdate = cartBox.get(shoeId);
      beforeUpdate!.updateQuantity(beforeUpdate.quantity+1);
      beforeUpdate.save();
      final updateQtyProduct = cartBox.get(shoeId);
      return updateQtyProduct!.fromModel(cartItem: updateQtyProduct);

    } on SocketException
    {
      throw NoInternetException();

    } catch(e)
    {
      throw CatchedExpection();
    }
  }

  @override
  Future<bool> removeFromCart(String shoeId)async{
    try{
      cartBox.delete(shoeId);
      return true;


    } on SocketException
    {
      throw NoInternetException();

    } catch(e)
    {
      throw CatchedExpection();
    }
  }


  @override
  Future<CartItem> decreaseQty(String shoeId)async{
    try{

      final beforeUpdate = cartBox.get(shoeId);
      beforeUpdate!.updateQuantity(beforeUpdate.quantity-1);
      beforeUpdate.save();
      final updateQtyProduct = cartBox.get(shoeId);
      return updateQtyProduct!.fromModel(cartItem: updateQtyProduct);

    } on SocketException
    {
      throw NoInternetException();

    } catch(e)
    {
      throw CatchedExpection();
    }
  }

}