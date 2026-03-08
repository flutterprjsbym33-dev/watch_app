 import 'package:whatch/features/product/domain/productentity/product.dart';

 class ProductMapper extends Watch {
   ProductMapper({
     required super.id,
     required super.title,
     required super.thumbnail,
     required super.rating,
     required super.price,
     required super.description,
     required super.images,
   });

   factory ProductMapper.fromJson(Map<String, dynamic> json) {
     return ProductMapper(
       id: json['id'].toString(),
       title: json['title'] ?? "",
       thumbnail: json['thumbnail'] ?? "",
       rating: json['rating'].toString(),
       price: json['price'].toString(),
       description: json['description'] ?? "",
       images: List<String>.from(json['picUrl'] ?? []),
     );
   }
 }