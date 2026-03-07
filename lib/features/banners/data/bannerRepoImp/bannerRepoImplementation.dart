import 'package:dart_either/src/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatch/features/banners/data/bannereDataSource/bannerRemoteDataSource.dart';
import 'package:whatch/features/banners/domain/bannerRepo/bannerRepo.dart';
import 'package:whatch/features/banners/domain/entity/bannerEntity.dart';
import 'package:whatch/utils/appExpections.dart';
import 'package:whatch/utils/failure.dart';

class BannerRepoImplementation extends BannerRepositories
{
  FetchBannersRemoteDataSource fetchBannersRemoteDataSource;
  BannerRepoImplementation({required this.fetchBannersRemoteDataSource});


  @override
  Future<Either<Failure, List<Banners>>> getBanners()async
  {
     try
     {
       final banners =  await fetchBannersRemoteDataSource.getBanners();
       return Right(banners);


     }
     on NoInternetException
     {
       debugPrint("No banner fetched ");
       return Left(NetworkFailure(errMsg: "Internet Unavailiable"));
     }
     on ServerErrorException
     {
       debugPrint("No banner fetched ");
       return Left(ServerFailure(errMsg: "ServerFailure"));
     }
     catch(e)
    {
      debugPrint("No banner fetched   ${e.toString()} ");
      return Left(CatchedFailure(errMsg: e.toString()));
    }

  }

}