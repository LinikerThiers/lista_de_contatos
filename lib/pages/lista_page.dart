import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:listadecontatos/model/lista_de_contatos_model.dart';
import 'package:listadecontatos/pages/adicionar_contato_page.dart';
import 'package:listadecontatos/pages/detalhes_contato_page.dart';
import 'package:listadecontatos/repository/contatos_back4app_repository.dart';
import 'package:listadecontatos/shared/widget/lista_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:listadecontatos/utils/gerenciador_de_temas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  ContatosBack4appRepository contatosBack4appRepository =
      ContatosBack4appRepository();
  var _contatosBack4app = ListaDeContatosModel([]);
  List<ContatoBack4appModel> _contatosOriginais = [];
  bool ordemAlfabetica = true;
  bool carregando = false;
  String imagemPerfil = '';
  String nomePerfil = '';

  @override
  void initState() {
    super.initState();
    carregarContatos();
    carregarOrdemAlfabetica();
    _carregarDadosPerfil();
  }

  Future<void> _carregarDadosPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      imagemPerfil = prefs.getString("image_profile") ?? "";
      nomePerfil = prefs.getString("nome_profile") ?? "";
    });
  }

  Future<void> carregarContatos() async {
    setState(() {
      carregando = true;
    });
    try {
      _contatosBack4app = await contatosBack4appRepository.obterContatos();
      _contatosOriginais = List.from(_contatosBack4app.contatos!);
      aplicarOrdenacao();
      debugPrint(_contatosBack4app.toString());
    } catch (e) {
      debugPrint("Erro ao obter contatos: $e");
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  Future<void> salvarOrdemAlfabetica(bool valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ordemAlfabetica', valor);
  }

  Future<void> carregarOrdemAlfabetica() async {
    final prefs = await SharedPreferences.getInstance();
    final ordem = prefs.getBool('ordemAlfabetica') ?? false;
    setState(() {
      ordemAlfabetica = ordem;
      aplicarOrdenacao();
    });
  }

  void aplicarOrdenacao() {
    if (_contatosBack4app.contatos != null &&
        _contatosBack4app.contatos!.isNotEmpty) {
      setState(() {
        if (ordemAlfabetica) {
          _contatosBack4app.contatos!.sort((a, b) {
            return (a.nome ?? "")
                .toLowerCase()
                .compareTo((b.nome ?? "").toLowerCase());
          });
        } else {
          _contatosBack4app.contatos = List.from(_contatosOriginais);
        }
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
        userName: nomePerfil,
        profileImagePath: imagemPerfil,
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
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        setState(() {
                          if (!ordemAlfabetica) {
                            _contatosBack4app.contatos!.sort((a, b) {
                              return (a.nome ?? "")
                                  .toLowerCase()
                                  .compareTo((b.nome ?? "").toLowerCase());
                            });
                          } else {
                            _contatosBack4app.contatos =
                                List.from(_contatosOriginais);
                          }
                          ordemAlfabetica = !ordemAlfabetica;
                        });
                        await salvarOrdemAlfabetica(ordemAlfabetica);
                      },
                      child: Row(
                        children: [
                          Icon(
                            ordemAlfabetica
                                ? FontAwesomeIcons.arrowDownAZ
                                : FontAwesomeIcons.sort,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 25),
                    InkWell(
                      onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AdicionarContatoPage()),
                            );
                            await carregarContatos();
                      },
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.plus,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
                              content: Text(
                                removido
                                    ? "CONTATO_REMOVIDO".tr()
                                    : "ERRO_REMOVER_CONTATO".tr(),
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.grey[300],
                                ),
                              ),
                              backgroundColor:
                                  isDarkMode ? Colors.grey[800] : Colors.black,
                            ),
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DetalhesContatoPage(contato: contato),
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
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
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
                                  InkWell(
                                    onTap: () async {
                                      await contatosBack4appRepository
                                          .atualizaFavorito(contato);
                                      setState(() {
                                        contato.favorito = !(contato.favorito!);
                                      });
                                    },
                                    child: FaIcon(
                                      contato.favorito!
                                          ? FontAwesomeIcons.solidHeart
                                          : FontAwesomeIcons.heart,
                                      size: 18,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      String aniversarioFormatado = (contato
                                                  .aniversario?.iso !=
                                              null)
                                          ? DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(
                                                  contato.aniversario!.iso!))
                                          : "Não informado";

                                      Share.share("${"FRASE_TO_SHARE".tr()}\n\n"
                                          "Nome: ${contato.nome}\n"
                                          "Telefone: ${contato.telefone}\n"
                                          "Email: ${contato.email}\n"
                                          "Aniversário: $aniversarioFormatado\n"
                                          "Endereço: ${contato.endereco}\n"
                                          "Instagram: ${contato.instagram}");
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.shareNodes,
                                      size: 18,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
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
