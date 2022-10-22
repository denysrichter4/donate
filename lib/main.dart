import 'package:donate/view/anuncio.dart';
import 'package:donate/view/principal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Donate',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        initialRoute: "/",
        routes: {
          Routes.HOME: (_)=> const Principal(),
          Routes.ADD_ANUNCIO: (_)=> const AddAnuncio(),
        },
    );
  }
}
