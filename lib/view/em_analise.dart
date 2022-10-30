import 'dart:convert';
import 'package:donate/model/item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../controller/routes.dart';
import 'item_tile.dart';

class EmAnalise extends StatefulWidget {
  const EmAnalise({Key? key}) : super(key: key);

  @override
  State<EmAnalise> createState() => _EmAnaliseState();
}

class _EmAnaliseState extends State<EmAnalise> {

  late DatabaseReference itemsRef;

  @override
  void initState() {
    itemsRef = FirebaseDatabase.instance.ref("em_analise");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: Image.asset("assets/logo/donate_logo.jpg"),
          backgroundColor: Colors.amber.shade400,
          title: const Text(
            "Em análise",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: itemsRef.onValue,
          builder: (context, snapshot){
            if(snapshot.hasData && !snapshot.hasError) {
              var event = snapshot.data as DatabaseEvent;
              var snapshot2 = event.snapshot.value;

              if (snapshot2 == null) {
                return const Center(child: Text("Sem items na lista"),);
              }
              var encoded = jsonEncode(snapshot2);
              Map<String, dynamic> map = Map<String, dynamic>.from(jsonDecode(encoded.toString()));

              var items = <ItemFirebase>[];
              for (var itemMap in map.values) {
                ItemFirebase itemFirebase = ItemFirebase.fromJson(itemMap);
                items.add(itemFirebase);
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 16, left: 2, right: 2, bottom: 120),
                itemCount: items.length,
                itemBuilder: (ctx, i) => ItemTile(items[i], false),
              );

            }else{
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
    );
  }
}
