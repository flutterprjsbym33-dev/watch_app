import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:whatch/features/product/datasource/productmapper/productMapper.dart';
import 'package:whatch/features/product/domain/productentity/product.dart';
import 'package:whatch/utils/appExpections.dart';

abstract class ProductRemoteDataSource{
  Future<List<Watch>> getProduct();
}

class ProductRemoteDataSourceImplementation
    extends ProductRemoteDataSource {

  final DatabaseReference firebaseDatabase;

  ProductRemoteDataSourceImplementation({
    required this.firebaseDatabase,
  });

  @override
  Future<List<Watch>> getProduct() async {
    try {
      final snapshot = await firebaseDatabase.get();

      if (!snapshot.exists) {
        debugPrint("Snapshot unavailable");
        return [];
      }

      final data = snapshot.value as Map<dynamic,dynamic>;

      final datas = data['Popular'] as List<dynamic>;
      final products =  datas.map((e)=>ProductMapper.fromJson(Map<String,dynamic>.from(e))).toList();
      return products;

    } on SocketException {
      throw NoInternetException();
    } catch (e) {
      debugPrint("catched expnnnnn ${e.toString()}");
      throw CatchedExpection();
    }
  }
}