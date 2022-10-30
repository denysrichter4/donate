class ItemFirebase{
  final String imagem;
  final String titulo;
  final String descricao;
  final String motivo;
  final String especificidades;
  final String problemas;
  final String localRetirada;
  final String prazoRetirada;
  final String data;
  final String keyName;

  ItemFirebase({
    required this.imagem,
    required this.titulo,
    required this.descricao,
    required this.motivo,
    required this.especificidades,
    required this.problemas,
    required this.localRetirada,
    required this.prazoRetirada,
    required this.data,
    required this.keyName
  });

  ItemFirebase.fromJson(Map<String, dynamic> json)
      : imagem = json['imagem'],
        titulo = json['titulo'],
        descricao = json['descricao'],
        motivo = json['motivo'],
        especificidades = json['especificidades'],
        problemas = json['problemas'],
        localRetirada = json['localRetirada'],
        prazoRetirada = json['prazoRetirada'],
        data = json['data'],
        keyName = json['keyName'];

  Map toJson() {
    return {
      'imagem': imagem,
      'titulo': titulo,
      'descricao': descricao,
      'motivo': motivo,
      'especificidades': especificidades,
      'problemas': problemas,
      'localRetirada': localRetirada,
      'prazoRetirada': prazoRetirada,
      'data': data,
      'keyName': keyName
    };
  }
}
class Items{
  List<ItemFirebase> items;
  Items({
    required this.items
  });
}
