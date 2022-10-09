import 'package:donate/controller/itens_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item_tile.dart';
class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  @override
  Widget build(BuildContext context) {
    final ItemsProvider items = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Image.asset("assets/logo/donate_logo.jpg"),
        backgroundColor: Colors.amber.shade400,
        title: const Text(
          "DONATE",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 16),
        itemCount: items.count,
        itemBuilder: (ctx, i) => ItemTile(items.byIndex(i)),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(80, 16, 50, 2),
        height: 50,
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.amber.shade400
            ),
            alignment: Alignment.center,
            child: const Text(
                "Anunciar doação",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
        ),
      )
    );
  }
}
