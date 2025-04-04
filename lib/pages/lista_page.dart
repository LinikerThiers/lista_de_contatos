import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/model/lista_de_contatos_model.dart';
import 'package:listadecontatos/pages/adicionar_contato_page.dart';
import 'package:listadecontatos/repository/contatos_back4app_repository.dart';
import 'package:listadecontatos/shared/widget/lista_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';

class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  ContatosBack4appRepository contatosBack4appRepository =
      ContatosBack4appRepository();
  var _contatosBack4app = ListaDeContatosModel([]);
  String profileImagePath = "";
  bool ordemAlfabetica = true;
  bool carregando = false;

  @override
  void initState() {
    super.initState();
    obterContatos();
  }

  Future<void> obterContatos() async {
    setState(() {
      carregando = true;
    });
    try {
      _contatosBack4app = await contatosBack4appRepository.obterContatos();
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
      appBar: ListaAppBar(
        userName: "Liniker",
        profileImagePath: "assets/profile_image.jpg",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "LISTA_DE_CONTATOS".tr(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      ordemAlfabetica = !ordemAlfabetica;
                    });
                  },
                  child: Icon(
                    ordemAlfabetica
                        ? FontAwesomeIcons.sort
                        : FontAwesomeIcons.arrowDownAZ,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: carregando
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          isDarkMode ? Colors.grey.shade300 : Colors.black),
                    ),
                  )
                : ListView.builder(
                    itemCount: _contatosBack4app.contatos!.length,
                    itemBuilder: (context, index) {
                      var contato = _contatosBack4app.contatos![index];
                      return Dismissible(
                        key: Key(contato.objectId.toString()),
                        background: Container(
                          color: isDarkMode ? Colors.white : Colors.black,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: FaIcon(
                            FontAwesomeIcons.trash,
                            color: isDarkMode ? Colors.black : Colors.white,
                            size: 22,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          String objectId = contato.objectId.toString();
                          bool removido = await contatosBack4appRepository
                              .removerContato(objectId);
                          if (mounted) {
                            setState(() {
                              _contatosBack4app.contatos
                                  ?.removeWhere((e) => e.objectId == objectId);
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(removido
                                  ? "CONTATO_REMOVIDO".tr()
                                  : "ERRO_REMOVER_CONTATO".tr(), style: TextStyle(
                                    color: isDarkMode ? Colors.white : Colors.grey[300],
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
                              backgroundImage: profileImagePath.isNotEmpty
                                  ? AssetImage(profileImagePath)
                                  : null,
                              backgroundColor: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.grey[300],
                              child: profileImagePath.isEmpty
                                  ? Icon(Icons.person,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      size: 24)
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: 18,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                                const SizedBox(width: 20),
                                FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 18,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => AdicionarContatoPage()));
        },
        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: isDarkMode ? Colors.grey[500]! : Colors.black,
            width: 2,
          ),
        ),
        child: const FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
