import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/pages/favoritos_page.dart';
import 'package:listadecontatos/pages/lista_page.dart';
import 'package:listadecontatos/pages/perfil_page.dart';
import 'package:provider/provider.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart'; 

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key, required this.title});
  final String title;

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  posicaoPagina = value;
                });
              },
              children: const [
                ListaPage(),
                FavoritosPage(),
                PerfilPage(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade600,
                  width: 1,
                ),
              ),
              color: isDarkMode ? Colors.grey[900] : Colors.white,
            ),
            child: BottomNavigationBar(
              backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
              selectedItemColor: isDarkMode ? Colors.white : Colors.black,
              unselectedItemColor: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                controller.jumpToPage(value);
              },
              currentIndex: posicaoPagina,
              items: [
                BottomNavigationBarItem(
                  label: "LISTA".tr(),
                  icon: Align(
                    child: FaIcon(
                      FontAwesomeIcons.listUl,
                      size: 22,
                      color: posicaoPagina == 0 
                          ? (isDarkMode ? Colors.white : Colors.black)
                          : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "FAVORITOS".tr(),
                  icon: Align(
                    child: FaIcon(
                      posicaoPagina == 1
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      size: 22,
                      color: posicaoPagina == 1
                          ? (isDarkMode ? Colors.white : Colors.black)
                          : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "PERFIL".tr(),
                  icon: Align(
                    child: FaIcon(
                      posicaoPagina == 2
                          ? FontAwesomeIcons.solidUser
                          : FontAwesomeIcons.user,
                      size: 22,
                      color: posicaoPagina == 2
                          ? (isDarkMode ? Colors.white : Colors.black)
                          : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                    ),
                  ),
                ),
              ],
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
              ),
              selectedLabelStyle: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}