import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:whatch/features/banners/data/bannereDataSource/bannerRemoteDataSource.dart';
import 'package:whatch/features/banners/domain/bannerRepo/bannerRepo.dart';
import 'package:whatch/features/banners/domain/bannerUseCases/getBanners.dart';
import 'package:whatch/features/cart/data/datasource/cart_local_data_source.dart';
import 'package:whatch/features/cart/data/repo_implementation/cart_repo_implementation.dart';
import 'package:whatch/features/cart/domain/repo/cart_repo.dart';
import 'package:whatch/features/cart/domain/usecase/decrement_item.dart';
import 'package:whatch/features/cart/domain/usecase/get_all_cart_items.dart';
import 'package:whatch/features/cart/domain/usecase/increment_item.dart';
import 'package:whatch/features/cart/view/bloc/catt_main_cubit.dart';
import 'package:whatch/features/product/datasource/productremotedatasource/productRemoteDataSource.dart';
import 'package:whatch/features/product/datasource/productrepoImplemetaion/produtrepoImplementaion.dart';
import 'package:whatch/features/product/domain/productUseCases/getProduct.dart';
import 'package:whatch/features/product/domain/productrepo/peoductRepo.dart';
import 'package:whatch/features/product/view/bloc/productstatecubit.dart';

import '../../app/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import '../../features/banners/data/bannerRepoImp/bannerRepoImplementation.dart';
import '../../features/cart/data/model/cart_model.dart';
import '../../features/cart/domain/usecase/add_to_car_usecase.dart';


class InitAll
{
 static final geiit = GetIt.instance;
  final getIt = GetIt.instance;
  
  void registerAll()async
  {



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


    //Cart Block Cubit

    //CARTLOCALDATASOURCR IMP
    geiit.registerLazySingleton<CartLocalDataSourceImp>(()=>
        CartLocalDataSourceImp(cartBox: Hive.box('cart')));

    // CART REPO IMP

    geiit.registerLazySingleton<CartRepository>(()=>CartRepoImplementation
      (cartLocalDataSourceImp: geiit<CartLocalDataSourceImp>()));

    //Add to Cart USe case

    geiit.registerLazySingleton<AddToCart>(()=>AddToCart(cartRepository: geiit<CartRepository>()));

    geiit.registerLazySingleton<IncrementItem>(()=>IncrementItem(cartRepository: geiit<CartRepository>()));

    geiit.registerLazySingleton<DecrementItem>(()=>DecrementItem(cartRepository: geiit<CartRepository>()));

    geiit.registerLazySingleton<GetCartItems>(()=>GetCartItems(cartRepository: geiit<CartRepository>()));

    geiit.registerLazySingleton<CartManagerCubit>(()=>CartManagerCubit(
        addToCartUseCase: getIt<AddToCart>(),
        incrementItem: getIt<IncrementItem>(),
        getCartItems: getIt<GetCartItems>(),
        decrementItem: getIt<DecrementItem>()),
    );

    //BOTTOM NAV CUBIT HIDE

    getIt.registerLazySingleton<BottomNavCubitHide>(()=>BottomNavCubitHide());



  }

}
