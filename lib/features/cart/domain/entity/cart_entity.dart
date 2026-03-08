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
    required this.id,
    required this.selectedItemImage,
  required this.title,
  required this.price,
  required this.discrip,
  required this.brand,required this.qunantity,required this.dateTime});

  double get subtotal {
    final numericPrice =
        double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    return numericPrice * qunantity;
  }


}