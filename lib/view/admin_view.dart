import 'dart:convert';
import 'package:donate/model/item.dart';
import 'package:donate/view/em_analise.dart';
import 'package:donate/view/principal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../controller/routes.dart';
import 'item_tile.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              leading: Image.asset("assets/logo/donate_logo.jpg"),
              backgroundColor: Colors.amber.shade400,
              title: const Text(
                "DONATE",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
              ),
              bottom: TabBar(
                enableFeedback: true,

                tabs: [
                  Container(
                    height: 35,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12
                      ),
                    ),
                    child: Text("Principal"),
                  ),
                  Container(
                    height: 35,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12
                      ),
                    ),
                    child: Text("Em análise"),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Principal(),
                EmAnalise(),
              ],
            ),
            floatingActionButton: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(
                    Routes.ADD_ANUNCIO
                );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(75, 16, 50, 2),
                height: 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber.shade400
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Anunciar doação",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                ),
              ),
            )
        )
    );
  }
}
