import 'package:flutter/material.dart';
import '../model/item.dart';

class ItemTile extends StatelessWidget{
  final Item item;
  const ItemTile(this.item);

  @override
  Widget build(BuildContext context) {
    return TileItem(
      imagem: item.imagem,
      title: item.titulo,
      description: item.descricao,
      localRetirada: item.localRetirada,
    );
  }
}

class TileItem extends StatelessWidget {
  const TileItem({
    Key? key,
    required this.imagem,
    required this.title,
    required this.description,
    required this.localRetirada,
  }) : super(key: key);

  final String imagem;
  final String title;
  final String description;
  final String localRetirada;

  @override
  Widget build(BuildContext context) {
    final imagem = this.imagem.isEmpty
        ? const Icon(Icons.add_a_photo_outlined)
        : Image(
      image:NetworkImage(this.imagem),
      fit: BoxFit.cover,
      width: 120,
      height: 120,
    );
    return Card(
        child: Row(
          children: [
            imagem,
            Container(
              height: 120,
              width: 260,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    localRetirada,
                    style: const TextStyle(
                      color: Colors.black45,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}

