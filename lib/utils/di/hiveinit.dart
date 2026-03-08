import 'package:hive_flutter/adapters.dart';

import '../../features/cart/data/model/cart_model.dart';

class HiveInit{
  Future<void> intitHive()async
  {
    await Hive.initFlutter();
    Hive.registerAdapter(CartModelAdapter());

     // reset corrupted data


    await Hive.openBox<CartModel>('cart');
  }
}