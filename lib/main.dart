import 'package:flutter/material.dart';
import 'package:listadecontatos/my_app.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('pt', 'BR')],
      path: 'assets/translations',  
      fallbackLocale: Locale('pt', 'BR'),
      child: MyApp()
    ),
  );
}

