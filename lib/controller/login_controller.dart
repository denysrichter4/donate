import 'package:donate/controller/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:donate/controller/crypto.dart';
import '../model/user.dart';
import 'login_google.dart';

class LoginController extends GetxController{
  bool isAdmin = false;
  bool isSigned = false;
  bool isNUll = false;
  late DatabaseReference itemsRef;
  late DatabaseReference itemsRefAdmin;
  final auth = FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.NONE);

  void initState() {
    itemsRefAdmin = FirebaseDatabase.instance.ref("users/${auth.currentUser?.uid}/admin");
    itemsRef = FirebaseDatabase.instance.ref("users");
  }

  Map<String, dynamic> map = {};
  User? user() => auth.currentUser;

  void runGoogleLogin(BuildContext context) {
    initState();
    signInWithGoogle().whenComplete(() async {
      if(await GoogleSignIn().isSignedIn()){
        if(user() != null){
          map = {
            user()!.uid : Usuario(
                uuid: user()!.uid,
                admin: false,
                nome: user()!.displayName!,
                email: user()!.email!,
                senha: Crypto.encrypt(user()!.uid)
            ).toJson()
          };
          itemsRef.update(map);
        }
        adminCheck(context);
      }
    });
  }

  void runLogin(BuildContext context, String email, String password) async {
    initState();
    if(email.isNotEmpty && password.isNotEmpty){
      if(await initLogin(email, password) != null){
        var user = auth.currentUser;
        if(user != null){
          adminCheck(context);
        }
      }
    }
  }

  void adminCheck(BuildContext context) {
    initState();
    itemsRefAdmin.onValue.listen((DatabaseEvent event) {
      var admin = event.snapshot.value;
      if(admin != null){
        if(admin as bool){
          Navigator.of(context).pushNamed(Routes.HOME_ADMIN);
        }else{
          Navigator.of(context).pushNamed(Routes.HOME_USER);
        }
      }
    });
  }

  bool listenUser() {
    return isNUll;
  }

  void listenSignUser() {
   auth.authStateChanges().listen((event) {
     isNUll = event != null;
     update();
   });
    // FirebaseAuth.instance
    //     .authStateChanges()
    //     .listen((User? user){
    //   if (user == null) {
    //     print('User is signed out!');
    //     isNUll = false;
    //     update();
    //   } else {
    //     print('User is signed in!');
    //     isNUll = true;
    //     update();
    //   }
    // });
  }

  Future<UserCredential> initLogin(String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: "", password: "");
    }
  }
}