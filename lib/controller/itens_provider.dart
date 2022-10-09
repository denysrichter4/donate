import 'dart:math';

import 'package:flutter/material.dart';
import '../data/dummy_items.dart';
import '../model/item.dart';

class ItemsProvider with ChangeNotifier{
  final Map<String, Item> _items = {...DUMMY_ITENS};

  List<Item> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Item byIndex(int i){
    return _items.values.elementAt(i);
  }

  void put(Item item){
    if(item==null){
      return;
    }

    if(item.id !=null &&
        item.id.trim().isNotEmpty &&
        _items.containsKey(item.id)){
      _items.update(
        item.id,
            (_) => Item(
            id: item.id,
            imagem: item.imagem,
            titulo: item.titulo,
            descricao: item.descricao,
            localRetirada: item.localRetirada
        ),
      );
    } else{
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
            () => Item(
             id: id,
             imagem: item.imagem,
             titulo: item.titulo,
             descricao: item.descricao,
             localRetirada: item.localRetirada
        ),
      );
    }
    notifyListeners();
  }

  void remove(Item item){
    if(item !=null && item.id !=null){
      _items.remove(item.id);
      notifyListeners();
    }
  }
}