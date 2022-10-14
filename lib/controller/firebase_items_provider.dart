import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../data/dummy_items.dart';
import '../model/item.dart';

class FirebaseItemsProvider with ChangeNotifier{
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  final topUserPostsRef = FirebaseDatabase.instance
      .ref("principal").get();


  //final Map<String, String> _items = {...firebaseItens};

  // List<ItemFirebase> get all {
  //   //return [..._items.];
  // }
  //
  // int get count {
  //   return _items.length;
  // }
  //
  // Item byIndex(int i){
  //   return _items.values.elementAt(i);
  // }

}