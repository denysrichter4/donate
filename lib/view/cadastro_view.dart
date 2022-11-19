import 'package:donate/controller/login_google.dart';
import 'package:donate/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:donate/controller/crypto.dart';
import 'package:get/get.dart';

import '../controller/routes.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({Key? key,}) : super(key: key);
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
    super.initState();
  }

  User? user() => auth.currentUser;

  Future<void> runSnapshot() async {
    try {
      auth.createUserWithEmailAndPassword(email: emailCtrl.text, password: Crypto.encrypt(senhaCtrl.text)).whenComplete(() {
        if(user() != null){
          String id = user()!.uid;
          String senha = Crypto.encrypt(senhaCtrl.text);
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
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 207, 0),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value != null) {
                          if(value.isEmpty){
                            return 'Informe o nome';
                          }
                          if(value.length < 5){
                            return 'O Nome deve ter 5 ou mais caracteres';
                          }

                        }
                      },
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
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null) {
                          if(value.isEmpty){
                            return 'Informe o email';
                          }
                          if(!value.isEmail){
                            return 'Informe um email valido';
                          }

                        }
                      },
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
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value != null) {
                          if(value.isEmpty){
                            return 'Informe a senha';
                          }
                          if(value.length < 6){
                            return 'A senha deve ter 6 ou mais caracteres';
                          }
                        }
                      },
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
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextFormField(
                      validator: (value) {
                        if (value != null) {
                          if(value.isEmpty){
                            return 'Confirme a senha';
                          }
                          if(value.length < 6){
                            return 'A senha deve ter 6 ou mais caracteres';
                          }
                          if(value != senhaCtrl.text){
                            return 'As senhas estão diferentes';
                          }
                        }
                      },
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
                if(_formKey.currentState != null){
                  if (_formKey.currentState!.validate()) {
                    runSnapshot();
                    Navigator.of(context).pushNamed(Routes.LOGIN);
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                height: 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.black,
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
      ),
    );
  }
}
