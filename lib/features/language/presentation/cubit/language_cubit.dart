import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopfee/core/service/shared_service.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super(SharedService.getLanguage() ?? "en");

  void selectCurrentLang(String langCode){
    emit(langCode);
    print(langCode);
  }

  void saveLang() async{
    await SharedService.setLanguage(state);
  }

}
