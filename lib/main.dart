import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:whatch/app/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatch/app/widgets/FirstHomeScreen.dart';
import 'package:whatch/features/banners/domain/bannerUseCases/getBanners.dart';
import 'package:whatch/features/banners/view/bloc/fetchbannerscubit.dart';
import 'package:whatch/features/cart/view/bloc/catt_main_cubit.dart';
import 'package:whatch/features/product/view/bloc/catocubit/catoCubit.dart';
import 'package:whatch/features/product/view/bloc/productstatecubit.dart';
import 'package:whatch/utils/di/getitDi.dart';
import 'package:whatch/utils/di/hiveinit.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveInit().intitHive();
    InitAll().registerAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchBannersCubit>(
            create: (context)=>FetchBannersCubit(getBanners:InitAll.geiit<GetBanners>())),
        BlocProvider<ProductStateCubit>(
            create: (context)=>InitAll.geiit<ProductStateCubit>()),
        BlocProvider<CatoCubit>(
            create: (context)=>CatoCubit()),
        BlocProvider<CartManagerCubit>(
            create: (context)=>InitAll().getIt<CartManagerCubit>())
      ],
        child:  MaterialApp(

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home:  FirstHomeScreen(),
        )
    );
  }
}

