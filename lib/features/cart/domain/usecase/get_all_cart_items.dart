

import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import 'package:dart_either/dart_either.dart';
import '../../../../utils/failure.dart';
import '../repo/cart_repo.dart';

class GetCartItems{
  CartRepository cartRepository;
  GetCartItems({required this.cartRepository});

  Future<Either<Failure, List<CartItem>>> call()async{
    return await  cartRepository.getAllCartItems();
  }
}
