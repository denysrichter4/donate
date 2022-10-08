import 'package:flutter/material.dart';
class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Donate",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const Center()
    );
  }
}
