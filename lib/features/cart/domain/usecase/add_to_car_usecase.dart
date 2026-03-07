import 'package:dart_either/dart_either.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';

import '../../../../utils/failure.dart';
import '../repo/cart_repo.dart';


class AddToCart {
  CartRepository cartRepository;

  AddToCart({required this.cartRepository});

  Future<Either<Failure,bool>> call(CartItem item,String selectedImage) {
    return cartRepository.addToCart(item,selectedImage);
  }

}