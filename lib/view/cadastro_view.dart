import 'package:donate/controller/login_google.dart';
import 'package:donate/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:donate/controller/crypto.dart';

import '../controller/routes.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({Key? key, required this.isLoginGoogle}) : super(key: key);
  final bool isLoginGoogle;
  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {

  final TextEditingController nomeCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController senhaCtrl = TextEditingController();
  final TextEditingController confirmaSenhaCtrl = TextEditingController();

  late DatabaseReference itemsRef;
  late FirebaseAuth auth;
  Map<String, dynamic> map = {};

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    itemsRef = FirebaseDatabase.instance.ref("users");
    googleLogin();
    super.initState();
  }

  void googleLogin(){
    String name = user()!.displayName!;
    String email = user()!.email!;
    nomeCtrl.text = name;
    emailCtrl.text = email;
  }

  User? user() => auth.currentUser;

  Future<void> runSnapshot() async {
    if(user() != null){
      String id = user()!.uid;
      String senha = await Crypto.encrypt(senhaCtrl.text);
      map = {
        id : Usuario(
            uuid: id,
            admin: false,
            nome: nomeCtrl.text,
            email: emailCtrl.text,
            senha: senha
        ).toJson()
      };
      itemsRef.update(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    signInWithGoogle();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 207, 0),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: ListView(
          children: [
            Image.asset(
              "assets/logo/donate_splash_screen.jpg",
              height: 200,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Nome :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      controller: nomeCtrl,
                      minLines: 1,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none
                      ),
                    ),),
                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "E-mail :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      controller: emailCtrl,
                      minLines: 1,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none
                      ),
                    ),),
                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Senha :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      controller: senhaCtrl,
                      obscureText: true,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none
                      ),
                    ),),
                ),

              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Confirmar senha :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      controller: confirmaSenhaCtrl,
                      obscureText: true,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      decoration: const InputDecoration(
                          border: InputBorder.none
                      ),
                    ),),
                ),

              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  runSnapshot();
                });
                Navigator.of(context).pushNamed(
                    Routes.LOGIN
                );
              },
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
