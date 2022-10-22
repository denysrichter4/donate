import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:another_dashed_container/another_dashed_container.dart';

class AddAnuncio extends StatefulWidget {
  const AddAnuncio({Key? key}) : super(key: key);

  @override
  State<AddAnuncio> createState() => _AddAnuncioState();
}

class _AddAnuncioState extends State<AddAnuncio> {
  var galleryFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    imageSelectorGallery() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        galleryFile = image as File;
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
              child: galleryFile == null
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
                    : Center(child: Image.file(galleryFile)),
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
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      minLines: 1,
                      maxLines: 2,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
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
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      minLines: 3,
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
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
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black12
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child:  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      minLines: 2,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 20,

                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none
                      ),
                    ),),
                ),

              ],
            ),
          ),
          GestureDetector(
            onTap: (){

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
