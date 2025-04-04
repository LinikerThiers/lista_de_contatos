import 'package:flutter/material.dart';
import 'package:listadecontatos/my_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('pt', 'BR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('pt', 'BR'),
      child: ChangeNotifierProvider(
        create: (context) => ThemeManager(),
        child: const MyApp(),
      ),
    ),
  );
}