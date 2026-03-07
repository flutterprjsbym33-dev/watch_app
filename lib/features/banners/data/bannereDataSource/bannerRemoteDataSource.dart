import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatch/features/banners/domain/entity/bannerEntity.dart';
import 'package:whatch/utils/appExpections.dart';
import 'package:whatch/utils/failure.dart';

class FetchBannersRemoteDataSource
{
  FirebaseFirestore firebaseFirestore;
  FetchBannersRemoteDataSource({required this.firebaseFirestore});

  Future<List<Banners>> getBanners()async
  {
   try{
     final documentSnapshot = await firebaseFirestore.collection('banners').doc('banner').get();
     final data = documentSnapshot.data();
     debugPrint("data is $data");
     if(data!=null)
     {
       final List<dynamic> banners = data['b1'];
       return banners.map((i)=>Banners(imageUrl: i.toString(),
           time: DateTime.now().toString())).toList();
     }
     else {
       return [];
     }
   }on FirebaseException catch (e)
   {
     debugPrint("Banner Exp >>>>> ${e.toString()}");
     throw ServerErrorException();


   }on SocketException 
   {
     debugPrint("Banner Exp >>>>>  Socket Expn");
     throw NoInternetException();
   }
   catch (e)
    {
      debugPrint("Banner Exp >>>>> ${e.toString()}");
      throw CatchedExpection();
    }
  }

}