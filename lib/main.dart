import 'package:donate/view/admin_view.dart';
import 'package:donate/view/anuncio.dart';
import 'package:donate/view/cadastro_view.dart';
import 'package:donate/view/em_analise.dart';
import 'package:donate/view/login_view.dart';
import 'package:donate/view/principal.dart';
import 'package:donate/view/user_view.dart';
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
        initialRoute: Routes.LOGIN,
        routes: {
          Routes.LOGIN: (_)=> const LoginView(),
          Routes.USER_PROFILE: (_)=> const UserView(),
          Routes.HOME_USER: (_)=> const UserView(),
          Routes.HOME_ADMIN: (_)=> const AdminView(),
          Routes.ADD_ANUNCIO: (_)=> const AddAnuncio(),
        },
    );
  }
}
