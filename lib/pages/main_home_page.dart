import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/pages/adicionar_page.dart';
import 'package:listadecontatos/pages/lista_page.dart';
import 'package:listadecontatos/pages/perfil_page.dart';

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
    return SafeArea(
      child: Scaffold(
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
              children: [
                ListaPage(),
                AdicionarPage(),
                PerfilPage()
              ],
            )),
            SizedBox(
              height: 60,
              child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey[400],
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    controller.jumpToPage(value);
                  },
                  currentIndex: posicaoPagina,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                      label: "Lista",
                      icon: Align(
                          child: FaIcon(
                        FontAwesomeIcons.listUl,
                        size: 18,
                      )),
                    ),
                    BottomNavigationBarItem(
                      label: "Adicionar",
                      icon: Align(
                          child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 18,
                      )),
                    ),
                    BottomNavigationBarItem(
                      label: "Perfil",
                      icon: Align(
                          child: FaIcon(
                        FontAwesomeIcons.user,
                        size: 18,
                      )),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
