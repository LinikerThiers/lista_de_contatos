import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LinguagensPage extends StatefulWidget {
  const LinguagensPage({super.key});

  @override
  State<LinguagensPage> createState() => _LinguagensPageState();
}

class _LinguagensPageState extends State<LinguagensPage> {
  String _opcaoSelecionada = "pt";

  @override
  void initState() {
    super.initState();
    _carregarIdiomaSalvo();
  }

  Future<void> _carregarIdiomaSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    String idiomaSalvo = prefs.getString("selected_language") ?? "pt";

    setState(() {
      _opcaoSelecionada = idiomaSalvo;
    });

    context.setLocale(Locale(idiomaSalvo, idiomaSalvo == "pt" ? "BR" : "US"));
  }

  Future<void> _salvarIdioma(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("selected_language", languageCode);
  }

  void _mudarIdioma(String languageCode, Locale locale) {
    setState(() {
      _opcaoSelecionada = languageCode;
    });
    context.setLocale(locale); 
    _salvarIdioma(languageCode); 
  }

  Widget _criarOpcaoIdioma(String idioma, String codigo, Locale locale, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade600,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                idioma,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            Icon(
              _opcaoSelecionada == codigo
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: _opcaoSelecionada == codigo 
                  ? (isDarkMode ? Colors.white : Colors.black)
                  : Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text("IDIOMA".tr(), style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
        surfaceTintColor: isDarkMode ? Colors.grey[900] : Colors.white,
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => _mudarIdioma("pt", const Locale('pt', 'BR')),
              child: _criarOpcaoIdioma("PORTUGUES".tr(), "pt", const Locale('pt', 'BR'), isDarkMode),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _mudarIdioma("en", const Locale('en', 'US')),
              child: _criarOpcaoIdioma("INGLES".tr(), "en", const Locale('en', 'US'), isDarkMode),
            ),
          ],
        ),
      ),
    );
  }
}