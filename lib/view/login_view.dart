import 'package:donate/view/cadastro_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../controller/login_google.dart';
import '../controller/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController senhaCtrl = TextEditingController();
  bool isAdmin = false;

  late DatabaseReference itemsRef;
  late FirebaseAuth auth;

  @override
  void initState() {
    signInWithGoogle();
    auth = FirebaseAuth.instance;
    itemsRef = FirebaseDatabase.instance.ref("users/${auth.currentUser?.uid}/admin");
    itemsRef.onValue.listen((DatabaseEvent event) {
      var admin = event.snapshot.value;
      isAdmin = admin as bool;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Ainda não é cadastrado?",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => const CadastroView(isLoginGoogle:false)
                            )
                        );
                      },
                      child: const Text(
                        "Cadastre-se",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                    builder: (BuildContext context) => const CadastroView(isLoginGoogle:true)
                    )
                );
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 20),
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
                      "Login Google",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                if(isAdmin){
                  Navigator.of(context).pushNamed(
                      Routes.HOME_ADMIN
                  );
                }else{
                  Navigator.of(context).pushNamed(
                      Routes.HOME_USER
                  );
                }
              },
              child: Container(
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
                      "Login",
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
