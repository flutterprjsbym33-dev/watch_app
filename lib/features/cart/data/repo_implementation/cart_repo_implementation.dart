import 'dart:io';

import 'package:dart_either/src/dart_either.dart';
import 'package:whatch/features/cart/data/datasource/cart_local_data_source.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import 'package:whatch/features/cart/domain/repo/cart_repo.dart';
import 'package:whatch/utils/appExpections.dart';
import 'package:whatch/utils/failure.dart';

class CartRepoImplementation extends CartRepository {
  CartLocalDataSourceImp cartLocalDataSourceImp;
  CartRepoImplementation({required this.cartLocalDataSourceImp});



  //ADD TO CART ----------------------------------------------------------
  @override
  Future<Either<Failure, bool>> addToCart(CartItem cart,String selectedImage)
  async {
    try{
      cartLocalDataSourceImp.addToCart(cart, selectedImage);
      return Right(true);

    }on NoInternetException{
      return Left(NetworkFailure(errMsg: "No Internet Available"));
    } catch (e)
    {
      return Left(ServerFailure(errMsg: e.toString()));
    }
  }


  //GETALL CART ITEMS TO CART ----------------------------------------------------------
  @override
  Future<Either<Failure, List<CartItem>>> getAllCartItems()async {
    try{
      final cartItems = await cartLocalDataSourceImp.getAllCartItems();
      return Right( cartItems);

    }on NoInternetException
    {
      return Left(NetworkFailure(errMsg:"No Internet Available" ));

    }
  }


// INCREASE QTY ------------------------------------------------------------------------
  @override
  Future<Either<Failure, CartItem>> increaseQty(String shoeId, int quantity)async{
    try{
      final cartItem =  await cartLocalDataSourceImp.increaseQty(shoeId, quantity);
      return Right(cartItem);

    }on NoInternetException
    {
      return Left(NetworkFailure(errMsg:"No Internet Available" ));

    }catch (e)
    {
      return Left(ServerFailure(errMsg: e.toString()));
    }
  }

  // REMOVE FROM CART ------------------------------------------------------------------------
  @override
  Future<Either<Failure,bool>> removeFromCart(String shoeId)async {
    try
    {
     final itemremoved =  await cartLocalDataSourceImp.removeFromCart(shoeId);
     return Right(itemremoved);

    }on NoInternetException
    {
      return Left(NetworkFailure(errMsg:"No Internet Available" ));

    }catch (e)
    {
      return Left(ServerFailure(errMsg: e.toString()));
    }
  }

}