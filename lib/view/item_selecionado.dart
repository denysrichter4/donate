import 'package:donate/model/item.dart';
import 'package:flutter/material.dart';

class ItemSelecionado extends StatefulWidget {
  final ItemFirebase itemFirebase;
  const ItemSelecionado({Key? key, required this.itemFirebase}) : super(key: key);

  @override
  State<ItemSelecionado> createState() => _ItemSelecionadoState();
}

class _ItemSelecionadoState extends State<ItemSelecionado> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Anúncio",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            color: Colors.black12,
            child: !widget
                .itemFirebase
                .imagem.contains("http")?
                const Center(
                  child: Text("Anúncio sem Imagens!"),
                ):
            Image.network(
              widget.itemFirebase.imagem,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    widget.itemFirebase.titulo,
                    style: const TextStyle(
                        fontSize: 28,
                        color: Colors.black54
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Descrição",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        widget.itemFirebase.descricao,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  )
                ),
                isSelected ? Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Local",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        widget.itemFirebase.localRetirada,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45
                        ),
                      ),
                    ],
                  ),
                ) : Text("..."),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          setState(() {
            isSelected = true;
          });
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(80, 16, 60, 16),
          height: 50,
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade400
              ),
              alignment: Alignment.center,
              child: const Text(
                "Quero esse item!!",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
          ),
        ),
      ),
    );
  }
}
