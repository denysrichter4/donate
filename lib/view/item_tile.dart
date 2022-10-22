import 'package:donate/view/item_selecionado.dart';
import 'package:flutter/material.dart';
import '../controller/routes.dart';
import '../model/item.dart';

class ItemTile extends StatelessWidget{
  final ItemFirebase item;
  const ItemTile(this.item);

  @override
  Widget build(BuildContext context) {
    return TileItem(
      imagem: item.imagem,
      title: item.titulo,
      description: item.descricao,
      localRetirada: item.localRetirada,
      data: item.data
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
    required this.data,
  }) : super(key: key);

  final String imagem;
  final String title;
  final String description;
  final String localRetirada;
  final String data;

  @override
  Widget build(BuildContext context) {
    final imagem = this.imagem.isEmpty || this.imagem == null || !this.imagem.contains("http") ? Container(
       height: 120,
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: const Center(
        child: Text(
            "Anúncio sem imagem",
            style: TextStyle(
                fontSize: 10
            )
        ),
      )
    ) : Image(
      image:NetworkImage(this.imagem),
      fit: BoxFit.cover,
      width: 120,
      height: 120,
    );
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                  builder: (BuildContext context) => ItemSelecionado(
                    itemFirebase: ItemFirebase(
                        imagem: this.imagem,
                        titulo: this.title,
                        descricao: this.description,
                        localRetirada: this.localRetirada,
                        data: this.data
                    ),
                  ),
            )
        );
      },
      child: Card(
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
                      data,
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
      ),
    );
  }
}

