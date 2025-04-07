import 'package:flutter/material.dart';
import 'package:listadecontatos/model/lista_de_contatos_model.dart';
import 'package:listadecontatos/repository/back4app_custom_dio.dart';

class ContatosBack4appRepository {
  final _customDio = Back4appCustomDio();

  ContatosBack4appRepository();

  Future<ListaDeContatosModel> obterContatos() async {
    var url = "/Contatos";
    var result = await _customDio.dio.get(url);
    return ListaDeContatosModel.fromJson(result.data);
  }

  Future<ListaDeContatosModel> obterContatosFavoritos() async {
    var url = "/Contatos?where={\"favorito\":true}";
    var result = await _customDio.dio.get(url);
    return ListaDeContatosModel.fromJson(result.data);
  }

  Future<void> adicionarContato(ContatoBack4appModel contato) async {
    try {
      await _customDio.dio.post("/Contatos", data: {
        "nome": contato.nome,
        "email": contato.email,
        "telefone": contato.telefone,
        "aniversario": contato.aniversario?.toJson(),
        "endereco": contato.endereco,
        "instagram": contato.instagram,
        "favorito": false,
        "image_profile": contato.imageProfile,
      });
    } catch (e) {
      debugPrint("erro: $e");
    }
  }

  Future<void> atualizarContato(ContatoBack4appModel contato) async {
    try {
      var url = "/Contatos/${contato.objectId}";
      await _customDio.dio.put(url, data: contato.atualizarEndpoint());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> atualizaFavorito(ContatoBack4appModel contato) async {
    try {
      var url = "/Contatos/${contato.objectId}";
      var data = {"favorito": !(contato.favorito ?? false)};
      await _customDio.dio.put(url, data: data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> removerContato(String objectId) async {
    try {
      await _customDio.dio.delete("/Contatos/$objectId");
      return true;
    } catch (e) {
      return false;
    }
  }
}
