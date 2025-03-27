import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/pages/editar_perfil.dart';
import 'package:listadecontatos/pages/linguagens_page.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    const String profileImagePath = 'assets/profile_image.jpg';
    const String nome = 'Liniker Thiers';
    const String email = 'liniker@email.com';
    const String telefone = '(75) 9 0000-0000';

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
                  backgroundImage: profileImagePath.isNotEmpty
                      ? const AssetImage(profileImagePath)
                      : null,
                  backgroundColor: Colors.grey[300],
                  child: profileImagePath.isEmpty
                      ? Icon(Icons.person,
                          color: isDarkMode ? Colors.white : Colors.black,
                          size: 60)
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                nome,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              Text(
                telefone,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditarPerfil()));
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
                        onTap: () {},
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
                          //ir para proxima pagina de relatar problema
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
                        onTap: () {
                          //Lógica para deslogar
                        },
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
