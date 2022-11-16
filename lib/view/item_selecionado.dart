import 'package:donate/model/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ItemSelecionado extends StatefulWidget {
  final ItemFirebase itemFirebase;
  const ItemSelecionado({Key? key, required this.itemFirebase}) : super(key: key);

  @override
  State<ItemSelecionado> createState() => _ItemSelecionadoState();
}

class _ItemSelecionadoState extends State<ItemSelecionado> {

  bool isSelected = false;

  String dropdownDias = "1 dia";
  String dropdownHorario = "8h as 17h";
  List<String> dropdownDiasList = <String>['1 dia', '2 dias', '3 dias', '4 dias'];
  List<String> dropdownHorarioList = <String>['8h as 17h', '9h as 17h', '10h as 17h', '8h as 22h'];
  DropdownMenuItem<String> itemDropdown(String value) => DropdownMenuItem<String>(
    value: value,
    child: Text(
      value,
      style: TextStyle(fontSize: 20),
    ),
  );

  List<DropdownMenuItem<String>> itensDropdownDias(){
    return dropdownDiasList.map<DropdownMenuItem<String>>(itemDropdown).toList();
  }
  List<DropdownMenuItem<String>> itensDropdownHorario(){
    return dropdownHorarioList.map<DropdownMenuItem<String>>(itemDropdown).toList();
  }

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
                .imagem!.contains("http")?
                const Center(
                  child: Text("Anúncio sem Imagens!"),
                ):
            Image.network(
              widget.itemFirebase.imagem!,
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
                const Divider(),
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
                              color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        widget.itemFirebase.descricao,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  )
                ),
                const Divider(),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Motivo",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          widget.itemFirebase.descricao,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    )
                ),
                const Divider(),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Especificidades (Voltagem, detalhes, ect...)",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          widget.itemFirebase.descricao,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    )
                ),
                const Divider(),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Problemas/Danos",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          widget.itemFirebase.descricao,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    )
                ),
                const Divider(),
                Container(
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
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Prazo de retirada Doador :",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        widget.itemFirebase.prazoRetirada,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 0, right: 16, top: 16, bottom: 8),
                        child:  Text(
                          "Prazo de retirada Donatário:",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 0, right: 16, bottom: 8),
                            width: 150,
                            child: DropdownButtonFormField(
                              items: itensDropdownDias(),
                              value: itensDropdownDias().first.value,
                              onChanged: (String? value){
                                setState(() {
                                  dropdownDias = value!;
                                });
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 16, bottom: 8),
                            width: 150,
                            child: DropdownButtonFormField(
                              items: itensDropdownHorario(),
                              value: itensDropdownHorario().first.value,
                              onChanged: (String? value){
                                setState(() {
                                  dropdownHorario = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          Map<String, dynamic> map = {};
          setState(() {
            widget.itemFirebase.userInteressado = FirebaseAuth.instance.currentUser!.uid;
            widget.itemFirebase.isAprovado = true;
            widget.itemFirebase.dataSolicitada = dropdownDias;
            widget.itemFirebase.horarioSolicitado = dropdownHorario;
            map = {widget.itemFirebase.keyName : widget.itemFirebase.toJson()};
          });
          FirebaseDatabase.instance.ref("principal").update(map);
          Navigator.pop(context);
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
