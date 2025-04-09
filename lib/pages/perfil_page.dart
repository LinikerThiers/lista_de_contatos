import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/pages/editar_perfil.dart';
import 'package:listadecontatos/pages/linguagens_page.dart';
import 'package:listadecontatos/pages/reportar_problema_page.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  String imagePath = '';
  String nome = '';
  String email = '';
  String telefone = '';
  String aniversario = '';
  String endereco = '';
  String instagram = '';

  @override
  void initState() {
    super.initState();
    _carregarDadosPerfil();
  }

  Future<void> _carregarDadosPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString("image_profile") ?? "";
      nome = prefs.getString("nome_profile") ?? "";
      email = prefs.getString("email_profile") ?? "";
      telefone = prefs.getString("telefone_profile") ?? "";
      aniversario = prefs.getString("aniversario_profile") ?? "";
      endereco = prefs.getString("endereco_profile") ?? "";
      instagram = prefs.getString("instagram_profile") ?? "";
    });
  }

  Future<void> _apagarPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("nome_profile");
    await prefs.remove("email_profile");
    await prefs.remove("telefone_profile");
    await prefs.remove("aniversario_profile");
    await prefs.remove("endereco_profile");
    await prefs.remove("instagram_profile");
    await prefs.remove("image_profile");

    setState(() {
      imagePath = '';
      nome = '';
      email = '';
      telefone = '';
      aniversario = '';
      endereco = '';
      instagram = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
                  backgroundColor: Colors.grey[300],
                  child: imagePath.isEmpty
                      ? Icon(Icons.person,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 60)
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                (nome.isEmpty) ? "User" : nome,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                (email.isEmpty) ? "email" : email,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              Text(
                (telefone.isEmpty) ? "Telefone" : telefone,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditarPerfil()),
                  ).then((_) {
                    _carregarDadosPerfil();
                  });
                },
                icon: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                label: Text(
                  "EDITAR_PERFIL".tr(),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.shade600,
                        width: 1,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          )),
                      child: ListTile(
                        title: Text(
                          "COMPARTILHAR_PERFIL".tr(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: FaIcon(
                          FontAwesomeIcons.shareNodes,
                          size: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        onTap: () async {
                          Share.share("${"FRASE_TO_SHARE".tr()}\n\n"
                              "Nome: $nome\n"
                              "Telefone: $telefone\n"
                              "Email: $email\n"
                              "Aniversário: $aniversario\n"
                              "Endereço: $endereco\n"
                              "Instagram: $instagram");
                        },
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          )),
                      child: ListTile(
                        title: Text(
                          "IDIOMA".tr(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          size: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LinguagensPage()));
                        },
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "TEMA".tr(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: FaIcon(
                          isDarkMode
                              ? FontAwesomeIcons.moon
                              : FontAwesomeIcons.sun,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 18,
                        ),
                        onTap: () => themeManager.toggleTheme(),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "RELATAR_PROBLEMA".tr(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 18,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ReportarProblemaPage()));
                        },
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          "SAIR".tr(),
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: FaIcon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 18,
                        ),
                        onTap: _apagarPerfil,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
