import 'dart:convert';
import 'package:donate/model/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../controller/routes.dart';
import 'item_tile.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key, required this.isUser, required this.isUserInteressado}) : super(key: key);

  final bool isUser;
  final bool isUserInteressado;

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  late DatabaseReference itemsRef;
  User? user;

  @override
  void initState() {
    itemsRef = FirebaseDatabase.instance.ref("principal");
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            if(itemFirebase.isAprovado != null){
              if(!widget.isUser && !widget.isUserInteressado && !itemFirebase.isAprovado!){
                items.add(itemFirebase);
              }
            }
            if(user != null){
              if(widget.isUser && itemFirebase.user == user!.uid){
                items.add(itemFirebase);
              }
              if(widget.isUserInteressado && itemFirebase.userInteressado == user!.uid){
                items.add(itemFirebase);
              }
            }
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 16, left: 2, right: 2, bottom: 120),
            itemCount: items.length,
            itemBuilder: (ctx, i) => ItemTile(items[i], "principal"),
          );

        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
