import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  String profileImagePath = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Favoritos",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FaIcon(FontAwesomeIcons.solidStar),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey.shade600,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text('(75) 9 0000-0000'),
                            trailing: FaIcon(
                              FontAwesomeIcons.solidStar,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }))
            ],
          )),
    );
  }
}
