import 'package:uuid/uuid.dart';

import '../../../product/domain/productentity/product.dart';

class CartItem
{
  String selectedItemImage;
  String price;
  String title;
  String discrip;
  String brand;
  int qunantity;
  DateTime dateTime;
  String id;

  CartItem({
  String? id,
    required this.selectedItemImage,
  required this.title,
  required this.price,
  required this.discrip,
  required this.brand,required this.qunantity,required this.dateTime}):id=Uuid().v4();


}