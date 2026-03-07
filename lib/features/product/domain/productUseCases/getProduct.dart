import 'package:dart_either/dart_either.dart';
import 'package:whatch/features/product/domain/productentity/product.dart';
import 'package:whatch/features/product/domain/productrepo/peoductRepo.dart';
import 'package:whatch/utils/failure.dart';

class GetProduct
{
  ProductRepositories productRepositories;
  GetProduct({required this.productRepositories});

  Future<Either<Failure,List<Watch>>> call()
  {
    return productRepositories.getPrroducts();
  }

}