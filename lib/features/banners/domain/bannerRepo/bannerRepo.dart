import 'package:dart_either/dart_either.dart';
import 'package:whatch/features/banners/domain/entity/bannerEntity.dart';
import 'package:whatch/utils/failure.dart';

abstract class BannerRepositories
{

   Future<Either<Failure,List<Banners>>> getBanners();

}