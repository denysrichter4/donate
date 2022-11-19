import 'package:donate/controller/login_controller.dart';
import 'package:donate/view/cadastro_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:donate/controller/crypto.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController senhaCtrl = TextEditingController();
  String checkPassword = "";
  String checkEmail = "";


  String passwordCheck() {
    return senhaCtrl.text.isNotEmpty ? checkPassword = Crypto.encrypt(senhaCtrl.text) : "";

  }
  String emailCheck() {
    return emailCtrl.text.isNotEmpty ? checkEmail = emailCtrl.text : "";
  }


  @override
  void initState() {
    super.initState();
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
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 40),
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
                                  builder: (BuildContext context) => const CadastroView()
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
                  if(_formKey.currentState != null){
                    if (_formKey.currentState!.validate()) {
                      LoginController().runLogin(context, emailCheck(), passwordCheck());
                    }
                  }
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.only(bottom: 20),
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
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  LoginController().runGoogleLogin(context);
                },
                child: Container(
                  height: 50,
                  color: const Color.fromARGB(255, 255, 207, 0),
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 5,
                    child: Image.asset(
                      fit: BoxFit.cover,
                      "assets/logo/google_icon.png",
                    ),
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
