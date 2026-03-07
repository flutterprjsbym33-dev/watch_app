import '../../../../utils/failure.dart';
import '../repo/cart_repo.dart';
import 'package:dart_either/dart_either.dart';

class RemoveFromCart{
  CartRepository cartRepository;
  RemoveFromCart({required this.cartRepository});

  Future<Either<Failure, bool>> call(String shoeId)async
  {
    return await cartRepository.removeFromCart(shoeId);

  }
}