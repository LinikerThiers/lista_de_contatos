class ListaDeContatosModel {
  List<Results>? results;

  ListaDeContatosModel({this.results});

  ListaDeContatosModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? objectId;
  String? nome;
  String? email;
  String? telefone;
  Aniversario? aniversario;
  String? endereco;
  String? instagram;
  bool? favorito;
  String? imageProfile;
  String? createdAt;
  String? updatedAt;

  Results(
      {this.objectId,
      this.nome,
      this.email,
      this.telefone,
      this.aniversario,
      this.endereco,
      this.instagram,
      this.favorito,
      this.imageProfile,
      this.createdAt,
      this.updatedAt});

  Results.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
    aniversario = json['aniversario'] != null
        ? Aniversario.fromJson(json['aniversario'])
        : null;
    endereco = json['endereco'];
    instagram = json['instagram'];
    favorito = json['favorito'];
    imageProfile = json['image_profile'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['nome'] = nome;
    data['email'] = email;
    data['telefone'] = telefone;
    if (aniversario != null) {
      data['aniversario'] = aniversario!.toJson();
    }
    data['endereco'] = endereco;
    data['instagram'] = instagram;
    data['favorito'] = favorito;
    data['image_profile'] = imageProfile;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Aniversario {
  String? sType;
  String? iso;

  Aniversario({this.sType, this.iso});

  Aniversario.fromJson(Map<String, dynamic> json) {
    sType = json['__type'];
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['__type'] = sType;
    data['iso'] = iso;
    return data;
  }
}
