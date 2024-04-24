import 'package:deepl_dart/deepl_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:developer' as developer;

Future<String> translate(String textToTranslate) async {
  Translator translator = Translator(
      authKey: dotenv.env["DEEPL_API_KEY"].toString(),
      serverUrl: "https://api-free.deepl.com");

  final textTranslated =
      await translator.translateTextSingular(textToTranslate, 'fr');

  return textTranslated.text;
}
