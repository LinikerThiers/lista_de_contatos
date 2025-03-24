import 'package:flutter/material.dart';
import 'package:listadecontatos/shared/widget/custom_app_bar.dart';

class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
      appBar: CustomAppBar(
        userName: "Liniker", profileImagePath: "assets/profile_image.jpg",
      ),
      body: Column(
        children: [
          
        ],
      ),
    ));
  }
}
