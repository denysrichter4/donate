import 'dart:convert';

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
  late DatabaseReference itemsRefUserCheck;
  late DatabaseReference itemsRefAdmin;
  final auth = FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.NONE);
  Map<String, dynamic> map = {};
  User? user() => auth.currentUser;

  void initState() {
    itemsRefAdmin = FirebaseDatabase.instance.ref("users/${user()?.uid}/admin");
    itemsRef = FirebaseDatabase.instance.ref("users");
    itemsRefUserCheck = FirebaseDatabase.instance.ref("users/${user()?.uid}");
  }

  void runGoogleLogin() {
    signInWithGoogle().whenComplete(() async {
      if(await GoogleSignIn().isSignedIn()){
        if(user() != null){
          initState();
          final snapshot = await itemsRefUserCheck.get();
          if (!snapshot.exists) {
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
          adminCheck();
        }
      }
    });
  }

  void runLogin(String email, String password) async {
    initState();
    if(email.isNotEmpty && password.isNotEmpty){
      await initLogin(email, password);
      var user = auth.currentUser;
      if(user != null){
        adminCheck();
      }
    }
  }

  void adminCheck() async {
    initState();
    final snapshot = await itemsRefAdmin.get();
    if(snapshot.value as bool){
      goToRote(Routes.HOME_ADMIN);
    }else{
      goToRote(Routes.HOME_USER);
    }
  }

  goToRote(String route){
    Get.toNamed(route);
  }

  bool listenUser() {
    return isNUll;
  }

  void listenSignUser() {
   auth.authStateChanges().listen((event) {
     isNUll = event != null;
     update();
   });
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