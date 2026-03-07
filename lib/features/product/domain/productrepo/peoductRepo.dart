import 'package:dart_either/dart_either.dart';
import 'package:whatch/features/product/domain/productentity/product.dart';
import 'package:whatch/utils/failure.dart';

abstract class ProductRepositories{

  Future<Either<Failure,List<Watch>>> getPrroducts();

}