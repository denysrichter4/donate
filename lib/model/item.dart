class Item{
  final String imagem;
  final String titulo;
  final String descricao;
  final String localRetirada;

  const Item({
    required this.imagem,
    required this.titulo,
    required this.descricao,
    required this.localRetirada
  });
}

const DUMMY_ITENS ={
  '1':Item(
      imagem:'https://cdn.pixabay.com/photo/2014/04/02/14/10/female-306407_960_720.png',
      titulo:'item 1',
      descricao:'sofa marrom',
      localRetirada:'rua 1 n 3'
  ),
  '2':Item(
      imagem:'https://cdn.pixabay.com/photo/2014/04/02/14/10/female-306407_960_720.png',
      titulo:'item 2',
      descricao:'sofa marrom',
      localRetirada:'rua 1 n 3'
  ),
  '3':Item(
      imagem:'https://cdn.pixabay.com/photo/2014/04/02/14/10/female-306407_960_720.png',
      titulo:'item 3',
      descricao:'sofa marrom',
      localRetirada:'rua 1 n 3'
  ),
};