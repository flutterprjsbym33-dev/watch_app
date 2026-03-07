import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:whatch/features/banners/data/bannereDataSource/bannerRemoteDataSource.dart';
import 'package:whatch/features/banners/domain/bannerRepo/bannerRepo.dart';
import 'package:whatch/features/banners/domain/bannerUseCases/getBanners.dart';
import 'package:whatch/features/product/datasource/productremotedatasource/productRemoteDataSource.dart';
import 'package:whatch/features/product/datasource/productrepoImplemetaion/produtrepoImplementaion.dart';
import 'package:whatch/features/product/domain/productUseCases/getProduct.dart';
import 'package:whatch/features/product/domain/productrepo/peoductRepo.dart';
import 'package:whatch/features/product/view/bloc/productstatecubit.dart';

import '../../features/banners/data/bannerRepoImp/bannerRepoImplementation.dart';
import '../../features/cart/data/model/cart_model.dart';


class InitAll
{
 static final geiit = GetIt.instance;
  final getIt = GetIt.instance;
  
  void registerAll()async
  {
    await Hive.initFlutter();
    Hive.registerAdapter(CartModelAdapter());
    await Hive.openBox<CartModel>('cart');


    //-------------------------- Banners ---------------------------------------------
    //FIREBASE FIRESTORE INSTANCE
    getIt.registerLazySingleton<FirebaseFirestore>(()=>FirebaseFirestore.instance);

    //BANNERS REMOTE DATA SOURCE
    getIt.registerLazySingleton<FetchBannersRemoteDataSource>
      (()=>FetchBannersRemoteDataSource(firebaseFirestore: getIt<FirebaseFirestore>()));

    //Banners Remote Data Source
    getIt.registerLazySingleton<BannerRepoImplementation>
      (()=>BannerRepoImplementation(fetchBannersRemoteDataSource:getIt<FetchBannersRemoteDataSource>()));

    //banners repo

    getIt.registerLazySingleton<BannerRepositories>(()=>getIt<BannerRepoImplementation>());

    //Get Banners Use cases
    getIt.registerLazySingleton<GetBanners>(()=>GetBanners(bannerRepositories: getIt<BannerRepositories>()));

    //-------------------------- Products ---------------------------------------------

    //DatabaseRefrence obj

    getIt.registerLazySingleton<DatabaseReference>(()=>FirebaseDatabase.instance.ref());


    //ProductRemoteDataSource

    getIt.registerLazySingleton<ProductRemoteDataSource>(()=>
        ProductRemoteDataSourceImplementation(firebaseDatabase:getIt<DatabaseReference>()));

    getIt.registerLazySingleton<ProductRepositories>(()=>
        ProductRepoImplementaion(productRemoteImp:
        ProductRemoteDataSourceImplementation(firebaseDatabase:getIt<DatabaseReference>())));


    getIt.registerLazySingleton<GetProduct>(()=>
        GetProduct(productRepositories: getIt<ProductRepositories>()));

    getIt.registerLazySingleton<ProductStateCubit>(()=>ProductStateCubit(getProduct: getIt<GetProduct>()));



  }

}
