import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/model/lista_de_contatos_model.dart';
import 'package:listadecontatos/repository/contatos_back4app_repository.dart';
import 'package:listadecontatos/shared/widget/favoritos_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  ContatosBack4appRepository contatosBack4appRepository =
      ContatosBack4appRepository();
  var _contatosBack4app = ListaDeContatosModel([]);
  String profileImagePath = "";
  bool carregando = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarContatos();
  }

  Future<void> carregarContatos() async {
    setState(() {
      carregando = true;
    });
    try {
      _contatosBack4app =
          await contatosBack4appRepository.obterContatosFavoritos();
      debugPrint(_contatosBack4app.toString());
    } catch (e) {
      debugPrint("Erro ao obter contatos: $e");
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

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
            child: carregando
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isDarkMode ? Colors.grey.shade300 : Colors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _contatosBack4app.contatos!.length,
                    itemBuilder: (context, index) {
                      var contato = _contatosBack4app.contatos![index];
                      return Dismissible(
                        key: Key(contato.objectId.toString()),
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
                        onDismissed: (direction) async {
                          await contatosBack4appRepository
                              .atualizaFavorito(contato);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("REMOVIDO_DOS_FAVORITOS".tr(), style: TextStyle(
                                color: isDarkMode ? Colors.grey.shade300 : Colors.white
                              ),),
                              backgroundColor: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.black,
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade600,
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
                              backgroundImage: contato.imageProfile != null &&
                                      contato.imageProfile!.isNotEmpty
                                  ? FileImage(File(contato.imageProfile!))
                                  : null,
                              backgroundColor: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              child: (contato.imageProfile == null ||
                                      contato.imageProfile!.isEmpty)
                                  ? Icon(
                                      Icons.person,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      size: 24,
                                    )
                                  : null,
                            ),
                            title: Text(
                              contato.nome.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              contato.telefone.toString(),
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600],
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
