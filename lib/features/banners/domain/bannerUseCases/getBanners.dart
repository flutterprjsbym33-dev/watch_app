import 'package:dart_either/dart_either.dart';
import 'package:whatch/features/banners/domain/bannerRepo/bannerRepo.dart';
import 'package:whatch/features/banners/domain/entity/bannerEntity.dart';
import 'package:whatch/utils/failure.dart';

class GetBanners{
  BannerRepositories bannerRepositories;
  GetBanners({required this.bannerRepositories});

  Future<Either<Failure,List<Banners>>> call()async
  {
    return  await bannerRepositories.getBanners();
  }
}