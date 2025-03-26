import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/shared/widget/favoritos_app_bar.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  String profileImagePath = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: FavoritosAppBar(),
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
                      color: Colors.black,
                      child: FaIcon(
                        FontAwesomeIcons.heartCircleXmark,
                        color: Colors.white,
                        size: 22,
                      )),
                  onDismissed: (direction) {
                    setState(() {
                      // favoritos remove
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("REMOVIDO_DOS_FAVORITOS".tr()),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.grey.shade600,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.white,
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
                        backgroundColor: Colors.grey[300],
                        child: profileImagePath.isEmpty
                            ? const Icon(Icons.person,
                                color: Colors.black, size: 24)
                            : null,
                      ),
                      title: Text(
                        'Liniker Thiers',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: const Text('(75) 9 0000-0000'),
                      trailing: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        size: 18,
                        color: Colors.black,
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
