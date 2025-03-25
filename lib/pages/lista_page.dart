import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/shared/widget/custom_app_bar.dart';

class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  String profileImagePath = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        userName: "Liniker",
        profileImagePath: "assets/profile_image.jpg",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Lista de Contatos",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key('ID'),
                  background: Container(
                    color: Colors.black,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: FaIcon(
                      FontAwesomeIcons.trash,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('name removido'),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[100],
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
                      trailing: FaIcon(FontAwesomeIcons.star, size: 18,),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    ));
  }
}
