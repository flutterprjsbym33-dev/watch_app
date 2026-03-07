import 'package:hive_flutter/adapters.dart';
import 'package:whatch/features/cart/domain/entity/cart_entity.dart';
import '../../../product/domain/productentity/product.dart';
import 'package:uuid/uuid.dart';
part 'cart_model.g.dart';



@HiveType(typeId: 1)
class CartModel extends HiveObject {
  @HiveField(0)
  String selectedImage;

  @HiveField(1)
  String price;

  @HiveField(2)
  String title;

  @HiveField(3)
  String description;

  @HiveField(4)
  String brand;

  @HiveField(5)
  int quantity;

  @HiveField(6)
  DateTime dateTime;

  @HiveField(7)
  String id;



   // Optional: to link back to original product

  CartModel({
    required this.selectedImage,
    required this.price,
    required this.title,
    required this.description,
    required this.brand,
    required this.quantity,
    required this.dateTime,
    required this.id

  });

  // Factory constructor to create CartModel from Product entity
  factory CartModel.fromProduct({
    required CartItem product,
    required String selectedImage,
    int quantity = 1,
  }) {
    return CartModel(
      id: product.id,
      selectedImage: selectedImage,
      price: product.price,
      title: product.title,
      description: product.discrip,
      brand: product.brand,
      quantity: quantity,
      dateTime: DateTime.now(),
      // Assuming Product has an id field
    );
  }

  //method for cartModel to cartIem entity

  CartItem fromModel( {
    required CartModel cartItem,
  }){
    return CartItem(
    id: cartItem.id,
    selectedItemImage: cartItem.selectedImage,
    title: cartItem.title,
    price: cartItem.price,
   discrip: cartItem.description,
   brand: cartItem.brand,
   qunantity: cartItem.quantity,
   dateTime: cartItem.dateTime);
}

  // Method to update quantity
  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
    dateTime = DateTime.now(); // Update timestamp when quantity changes
  }

  // Method to calculate subtotal (if price is numeric)
  double get subtotal {
    // Parse price string to double, remove currency symbols if needed
    final numericPrice = double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
    return numericPrice * quantity;
  }

  // Copy with method for immutability support
  CartModel copyWith({
    String? selectedImage,
    String? price,
    String? title,
    String? description,
    String? brand,
    int? quantity,
    DateTime? dateTime,
    String? productId,
  }) {
    return CartModel(
      selectedImage: selectedImage ?? this.selectedImage,
      price: price ?? this.price,
      title: title ?? this.title,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      dateTime: dateTime ?? this.dateTime,
      id: productId ?? this.id,
    );
  }

  @override
  String toString() {
    return 'CartModel(title: $title, quantity: $quantity, price: $price)';
  }
}

// Extension for cart operations
extension CartModelListExtension on List<CartModel> {
  double get totalAmount {
    return fold(0.0, (sum, item) => sum + item.subtotal);
  }

  int get totalItems {
    return fold(0, (sum, item) => sum + item.quantity);
  }

  bool containsProduct(String productId) {
    return any((item) => item.id == productId);
  }

  CartModel? findProduct(String productId) {
    try {
      return firstWhere((item) => item.id == productId);
    } catch (e) {
      return null;
    }
  }
}