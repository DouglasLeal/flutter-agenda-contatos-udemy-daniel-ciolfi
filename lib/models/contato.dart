class Contato{
  int? id;
  String? nome;
  String? email;
  String? telefone;
  String? imagem;

  Contato.fromMap(Map map){
    id = map['id'];
    nome = map['nome'];
    email = map['email'];
    telefone = map['telefone'];
    imagem = map['imagem'];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      "nome": nome,
      "email": email,
      "telefone": telefone,
      "imagem": imagem
    };

    if(id != null){
      map['id'] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contato(id: $id, nome: $nome, email: $email, telefone: $telefone, imagem: $imagem)";
  }
}