import 'dart:io';
import 'package:donate/model/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_dashed_container/another_dashed_container.dart';

class AddAnuncio extends StatefulWidget {
  const AddAnuncio({Key? key}) : super(key: key);

  @override
  State<AddAnuncio> createState() => _AddAnuncioState();
}

class _AddAnuncioState extends State<AddAnuncio> {
  XFile galleryFile = XFile("");
  final ImagePicker _picker = ImagePicker();

  final TextEditingController tituloCrtl = TextEditingController();
  final TextEditingController descriptionCrtl = TextEditingController();
  final TextEditingController motivoCrtl = TextEditingController();
  final TextEditingController especifidadesCrtl = TextEditingController();
  final TextEditingController problemasCrtl = TextEditingController();
  final TextEditingController localCrtl = TextEditingController();
  final TextEditingController prazoCrtl = TextEditingController();
  var serverUrl = "https://firebasestorage.googleapis.com/v0/b/donate-doacoes.appspot.com/o/images%2F";
  var tokenImage = "?alt=media&token=bd9138a3-94ea-46a5-b983-c44c6cb556f9";
  var nameImage = "http-${DateTime.now().millisecondsSinceEpoch}";
  var isImage = false;
  String dropdownDias = "1 dia";
  String dropdownHorario = "8h as 17h";
  List<String> dropdownDiasList = <String>['1 dia', '2 dias', '3 dias', '4 dias'];
  List<String> dropdownHorarioList = <String>['8h as 17h', '9h as 17h', '10h as 17h', '8h as 22h'];
  DropdownMenuItem<String> itemDropdown(String value) => DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(fontSize: 20),
      ),
    );

  List<DropdownMenuItem<String>> itensDropdownDias(){
    return dropdownDiasList.map<DropdownMenuItem<String>>(itemDropdown).toList();
  }
  List<DropdownMenuItem<String>> itensDropdownHorario(){
    return dropdownHorarioList.map<DropdownMenuItem<String>>(itemDropdown).toList();
  }

  late DatabaseReference itemsRef;

  late Reference storageRef;

  @override
  void initState() {
    storageRef = FirebaseStorage.instance.ref();
    itemsRef = FirebaseDatabase.instance.ref("em_analise");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      galleryFile = (await _picker.pickImage(source: ImageSource.gallery))!;
      var image = storageRef.child("images/$nameImage");
      image.putFile(File(galleryFile.path));
      setState((){
        isImage = true;
      });
    }
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
        title: const Text(
            "Inserir anúncio",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            color: Colors.black12,
              child: !isImage && galleryFile.path == ""
                    ? DashedContainer(
                  dashColor: Colors.orange,
                  borderRadius: 8,
                  dashedLength: 5,
                  blankLength: 2,
                  strokeWidth: 2,
                  child: Container(
                    height: 100.0,
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          imageSelectorGallery();
                        },
                        child: const Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.orange,
                            size: 64
                        ),
                      ),
                    ),
                  ),
                )
                    : Center(child: Image.file(File(galleryFile.path))),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Título do anúncio :",
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
                      controller: tituloCrtl,
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
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Descrição :",
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
                      controller: descriptionCrtl,
                      minLines: 3,
                      maxLines: 10,
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
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Motivo :",
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
                      controller: motivoCrtl,
                      minLines: 3,
                      maxLines: 10,
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
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Especificidades : (ex: voltagem, etc...)",
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
                      controller: especifidadesCrtl,
                      minLines: 3,
                      maxLines: 10,
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
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Problemas ou Danos :",
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
                      controller: problemasCrtl,
                      minLines: 3,
                      maxLines: 10,
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
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Local da retirada :",
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      controller: localCrtl,
                      minLines: 2,
                      maxLines: 3,
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
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                  child:  Text(
                    "Prazo de retirada :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                      width: 150,
                      child: DropdownButtonFormField(
                        items: itensDropdownDias(),
                        value: itensDropdownDias().first.value,
                        onChanged: (String? value){
                          setState(() {
                            dropdownDias = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, bottom: 8),
                      width: 150,
                      child: DropdownButtonFormField(
                        items: itensDropdownHorario(),
                        value: itensDropdownHorario().first.value,
                        onChanged: (String? value){
                          setState(() {
                            dropdownHorario = value!;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Map<String, dynamic> map = {};
              var keyName = "${DateTime.now().millisecondsSinceEpoch}";
              var day = "${DateTime.now().day}";
              var month = "${DateTime.now().month}";
              var year = "${DateTime.now().year}";
              var hour = "${DateTime.now().hour}";
              var minute = "${DateTime.now().minute}";
              var t = "/";
              var i = ":";
              var e = "-";
              setState(() {
                map = {
                  keyName : ItemFirebase(
                    imagem: serverUrl+nameImage+tokenImage,
                    titulo: tituloCrtl.text,
                    descricao: descriptionCrtl.text,
                    motivo: motivoCrtl.text,
                    especificidades: especifidadesCrtl.text,
                    problemas:problemasCrtl.text,
                    localRetirada: localCrtl.text,
                    prazoRetirada: "$dropdownDias - $dropdownHorario",
                    data: day+t+month+t+year+e+hour+i+minute,
                    keyName: keyName,
                    user: FirebaseAuth.instance.currentUser!.uid,
                    isAprovado: false
                  ).toJson()
                };
              });
              itemsRef.update(map);
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(50, 16, 50, 2),
              height: 50,
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade400
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Enviar Anúncio",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
