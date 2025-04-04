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

}