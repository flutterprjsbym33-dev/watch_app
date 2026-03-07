import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatoCubit extends Cubit<int>
{
  CatoCubit():super(0);

  void updateCato(int index)
  {
    emit(index);
  }

}