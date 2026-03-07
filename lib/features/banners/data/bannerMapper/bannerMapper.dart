import 'package:whatch/features/banners/domain/entity/bannerEntity.dart';

class BannersMapper extends Banners{
  BannersMapper({required super.imageUrl, required super.time});

  factory BannersMapper.fromJson({ required Map<String,dynamic> json})
  {
    return BannersMapper(
        imageUrl: json['image'],
        time: json['time']);
  }


}