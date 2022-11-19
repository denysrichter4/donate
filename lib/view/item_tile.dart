import 'package:donate/view/item_selecionado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../controller/routes.dart';
import '../model/item.dart';

class ItemTile extends StatelessWidget{
  final ItemFirebase item;
  final String route;
  const ItemTile(this.item, this.route, {super.key});


  @override
  Widget build(BuildContext context) {
    DatabaseReference itemsRef = FirebaseDatabase.instance.ref("principal");
    DatabaseReference itemsRefExclude = FirebaseDatabase.instance.ref("em_analise");
    final _imagem = item.imagem == null ||item.imagem!.isEmpty || !item.imagem!.contains("http") ? Container(
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
      image:NetworkImage(item.imagem!),
      fit: BoxFit.cover,
      width: 120,
      height: 120,
    );
    return GestureDetector(
      onTap: (){
        switch(route){
          case "principal":{
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      ItemSelecionado(
                        itemFirebase: item,
                        isPrincipal: true,
                      ),
                )
            );
            break;
          }

          case"em_analise":{
            showDialog<String>(
                context: context,
                builder: (BuildContext context) =>AlertDialog(
                  title: const Text('Validar item'),
                  content: const Text('Deseja EXCLUIR ou APROVAR item?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                        itemsRefExclude.child(item.keyName).remove();
                      },
                      child: const Text('Excluir'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                        Map<String, dynamic> map = {};
                        map = {
                          item.keyName : item.toJson()
                        };
                        itemsRef.update(map);
                        itemsRefExclude.child(item.keyName).remove();
                      } ,
                      child: const Text('Aprovar'),
                    ),
                  ],
                )
            );
            break;
          }
          case"em_andamento":{
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      ItemSelecionado(
                        itemFirebase: item,
                        isPrincipal: false,
                      ),
                )
            );
            break;
          }
          default:{
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      ItemSelecionado(
                        itemFirebase: item,
                        isPrincipal: true,
                      ),
                )
            );
            break;
          }
        }
      },
      child: Card(
          child: Row(
            children: [
              _imagem,
              Container(
                height: 120,
                width: 260,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.titulo,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      item.descricao,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      item.data,
                      style: const TextStyle(
                        color: Colors.black45,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                      ),
                    ),
                    item.isAprovado! && item.user == FirebaseAuth.instance.currentUser!.uid ? const Text(
                      "Pronto para aprovação!",
                      style: TextStyle(
                        color: Colors.red,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                      ),
                    ):  const Padding(padding: EdgeInsets.zero)
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}