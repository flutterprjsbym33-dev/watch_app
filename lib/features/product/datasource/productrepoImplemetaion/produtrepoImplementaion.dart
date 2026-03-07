import 'package:dart_either/src/dart_either.dart';
import 'package:whatch/features/product/datasource/productremotedatasource/productRemoteDataSource.dart';
import 'package:whatch/features/product/domain/productentity/product.dart';
import 'package:whatch/features/product/domain/productrepo/peoductRepo.dart';
import 'package:whatch/utils/appExpections.dart';
import 'package:whatch/utils/failure.dart';

class ProductRepoImplementaion extends ProductRepositories {

   final ProductRemoteDataSourceImplementation productRemoteImp;
   ProductRepoImplementaion({required this.productRemoteImp});




  @override
  Future<Either<Failure, List<Watch>>> getPrroducts()async {
    try{
      final response = await productRemoteImp.getProduct();
      return Right(response);

    } on NoInternetException
    {
      return Left(NetworkFailure(errMsg: "No Internet Availiable"));

    } on CatchedExpection
    {
      return Left(CatchedFailure(errMsg: "Something went wrong"));

    } catch (e)
    {
      return Left(ServerFailure(errMsg: e.toString()));
    }
  }

}