import 'package:donate/view/principal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/itens_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(
          create: (ctx) => ItemsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        routes: {
          "/": (_)=> const Principal(),
        },
      ),
    );
  }
}
