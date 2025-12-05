import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jumbled_word/core/constants/app_const.dart';

class LocalWordDataSource {
  Future<List<String>> loadWords() async {
    final data = await rootBundle.loadString(AppConst.wordAssets);
    return List<String>.from(json.decode(data));
  }
}
