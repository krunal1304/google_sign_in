

import 'package:flutter/material.dart';
import 'package:sign_in_google/model/sign_in_response_model.dart';
import 'package:sign_in_google/screen/sign_in_detail_screen.dart';
import 'package:sign_in_google/service/api_url.dart';
import '../service/api_base.dart';
import 'base_provider.dart';

class ChangeDataProvider extends BaseProvider {
  bool? isShowPassword = false;
  bool? isSelectDate = true;
  String? selectGender;


  callPassword(bool? value){
    value == true ? isShowPassword = true : isShowPassword = false;
    notifyListeners();
  }

  selectedGender(String? gender){
    selectGender = gender;
    notifyListeners();
  }

  selectDate(bool? value){
    value == true ? isSelectDate = true : isSelectDate = false;
    notifyListeners();
  }


}