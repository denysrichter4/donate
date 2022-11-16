import 'package:donate/view/em_analise.dart';
import 'package:donate/view/principal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../controller/routes.dart';

class AdminView extends StatefulWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  bool isUser = false;
  bool isUserInteressado = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 207, 0),
                    ),
                    child: Image.asset("assets/logo/donate_logo.jpg"),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isUser = false;
                        isUserInteressado = false;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.add_business),
                    title: const Text(
                      'Minhas doações',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isUser = true;
                        isUserInteressado = false;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.access_time_rounded),
                    title: const Text(
                      'Itens Selecionados',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        isUser = false;
                        isUserInteressado = true;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamed(
                          Routes.LOGIN
                      );
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: Colors.amber.shade400,
              title: const Text(
                "DONATE ADMIN",
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
            body: TabBarView(
              children: [
                Principal(isUser: isUser, isUserInteressado: isUserInteressado,),
                const EmAnalise(),
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
