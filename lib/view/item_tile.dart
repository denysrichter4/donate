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
      motivo: item.motivo,
      especificidades: item.especificidades,
      problemas: item.problemas,
      localRetirada: item.localRetirada,
      prazoRetirada: item.prazoRetirada,
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
    required this.motivo,
    required this.especificidades,
    required this.problemas,
    required this.localRetirada,
    required this.prazoRetirada,
    required this.data,
  }) : super(key: key);

  final String imagem;
  final String title;
  final String description;
  final String motivo;
  final String especificidades;
  final String problemas;
  final String localRetirada;
  final String prazoRetirada;
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
                        motivo: this.motivo,
                        especificidades: this.especificidades,
                        problemas: this.problemas,
                        localRetirada: this.localRetirada,
                        prazoRetirada: this.prazoRetirada,
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

