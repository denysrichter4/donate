class Item{
  final String id;
  final String imagem;
  final String titulo;
  final String descricao;
  final String localRetirada;

  const Item({
    required this.id,
    required this.imagem,
    required this.titulo,
    required this.descricao,
    required this.localRetirada
  });
}

class ItemFirebase{
  final String imagem;
  final String titulo;
  final String descricao;
  final String localRetirada;
  final String data;

  const ItemFirebase({
    required this.imagem,
    required this.titulo,
    required this.descricao,
    required this.localRetirada,
    required this.data
  });

  ItemFirebase.fromJson(Map<String, dynamic> json)
      : imagem = json['imagem'],
        titulo = json['titulo'],
        descricao = json['descricao'],
        localRetirada = json['localRetirada'],
        data = json['data'];
  Map toJson() {
    return {'imagem': imagem, 'titulo': titulo, 'descricao': descricao, 'localRetirada': localRetirada, 'data': data};
  }
}
class Items{
  List<ItemFirebase> items;
  Items({
    required this.items
  });
}
