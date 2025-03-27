import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart'; 

class FavoritosAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritosAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return AppBar(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      surfaceTintColor: isDarkMode ? Colors.grey[900] : Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "FAVORITOS".tr(),
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          FaIcon(
            FontAwesomeIcons.solidHeart,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
          height: 1,
        ),
      ),
      iconTheme: IconThemeData(
        color: isDarkMode ? Colors.white : Colors.black, 
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}