
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../core/controller/ticket/auth_controller.dart';


AuthController authController=Get.put(AuthController());
class LocaleString extends Translations {
 static final Map<String, Map<String, String>> _localizedStrings = {};

  static load() async {
    Map<String, Map<String, String>> languages = {};
    for (var languageModel in authController.languageList) {
      String jsonStringValues = await rootBundle
          .loadString('json/${languageModel['languageCode']}.json');
      // log("+++---------->${languageModel['languageCode']}");

      Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
      Map<String, String> loadJson = {};

      mappedJson.forEach((key, value) {
        loadJson[key] = value.toString();
      });
      languages[
      '${languageModel['languageCode']}_${languageModel['countryCode']}'] =
          loadJson;
    }    _localizedStrings.addAll(languages);
    // log("_localizedStrings---------->$_localizedStrings");
    // return _languages;
  }

  @override
  Map<String, Map<String, String>> get keys {
    return _localizedStrings;
  }
}

