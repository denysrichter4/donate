class ItemFirebase{
  String? imagem;
  final String titulo;
  final String descricao;
  String? motivo;
  String? especificidades;
  String? problemas;
  final String localRetirada;
  final String prazoRetirada;
  final String data;
  final String keyName;
  String? dataSolicitada;
  String? horarioSolicitado;
  String? user;
  String? userInteressado;


  ItemFirebase({
    this.imagem,
    required this.titulo,
    required this.descricao,
    this.motivo,
    this.especificidades,
    this.problemas,
    required this.localRetirada,
    required this.prazoRetirada,
    required this.data,
    required this.keyName,
    this.user,
    this.userInteressado
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
        keyName = json['keyName'],
        dataSolicitada = json['dataSolicitada'],
        horarioSolicitado = json['horarioSolicitado'],
        user = json['user'],
        userInteressado = json['userInteressado'];

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
      'keyName': keyName,
      'dataSolicitada': dataSolicitada,
      'horarioSolicitado': horarioSolicitado,
      'user': user,
      'userInteressado': userInteressado,
    };
  }
}
