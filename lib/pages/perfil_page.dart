import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final String profileImagePath = 'assets/profile_image.jpg';
  final String nome = 'Liniker Thiers';
  final String email = 'liniker@email.com';
  final String telefone = '(75) 9 0000-0000';
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: profileImagePath.isNotEmpty
                      ? AssetImage(profileImagePath)
                      : null,
                  backgroundColor: Colors.grey[300],
                  child: profileImagePath.isEmpty
                      ? const Icon(Icons.person, color: Colors.black, size: 60)
                      : null,
                ),
              ),
              SizedBox(height: 10),
              Text(
                nome,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                telefone,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: Colors.black,
                ),
                label: Text('Editar Perfil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.grey.shade600,
                        width: 1,
                      )),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          )),
                      child: ListTile(
                        title: Text(
                          'Compartilhar Perfil',
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: FaIcon(FontAwesomeIcons.shareNodes,
                            size: 16, color: Colors.black),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.grey.shade600,
                            width: 1,
                          )),
                      child: ListTile(
                        leading: FaIcon(
                          FontAwesomeIcons.language,
                          color: Colors.black,
                          size: 18,
                        ),
                        title: Text(
                          'Idioma',
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: FaIcon(FontAwesomeIcons.arrowRight,
                            size: 16, color: Colors.black),
                        onTap: () {},
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      color: _isDarkMode ? Colors.grey[800] : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey.shade600,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          'Tema',
                          style: TextStyle(
                              color: _isDarkMode ? Colors.white : Colors.black),
                        ),
                        trailing: FaIcon(
                          _isDarkMode
                              ? FontAwesomeIcons.moon
                              : FontAwesomeIcons.sun,
                          color: _isDarkMode ? Colors.white : Colors.black,
                          size: 18,
                        ),
                        onTap: _toggleTheme,
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
