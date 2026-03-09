import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatch/features/cart/data/model/cart_model.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import 'package:whatch/features/cart/domain/repo/cart_repo.dart';
import 'package:whatch/utils/failure.dart';

class IncrementItem {
  CartRepository cartRepository;
  IncrementItem({required this.cartRepository});

  Future<Either<Failure,CartItem>> call(String shoeId)
  {
     return cartRepository.increaseQty(shoeId);
  }
}