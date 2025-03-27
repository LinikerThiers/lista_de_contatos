import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/shared/widget/favoritos_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart'; 

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  String profileImagePath = "";

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = themeManager.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: const FavoritosAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                final contactId = 'contact_$index';
                return Dismissible(
                  key: Key(contactId),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: isDarkMode ? Colors.white : Colors.black,
                    child: FaIcon(
                      FontAwesomeIcons.heartCircleXmark,
                      color: isDarkMode ? Colors.black : Colors.white,
                      size: 22,
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      // favoritos remove
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("REMOVIDO_DOS_FAVORITOS".tr()),
                        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade600,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: profileImagePath.isNotEmpty
                            ? AssetImage(profileImagePath)
                            : null,
                        backgroundColor: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                        child: profileImagePath.isEmpty
                            ? Icon(Icons.person,
                                color: isDarkMode ? Colors.white : Colors.black, 
                                size: 24)
                            : null,
                      ),
                      title: Text(
                        'Liniker Thiers',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '(75) 9 0000-0000',
                        style: TextStyle(
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      trailing: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        size: 18,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}