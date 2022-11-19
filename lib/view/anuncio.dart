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

class _AddAnuncioState extends State<AddAnuncio> with RestorationMixin{
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
  var nameImage = "";
  var isImage = false;

  late DatabaseReference itemsRef;

  late Reference storageRef;

  String dataSelecionada = "";
  String horaInicial = "";
  String horaFinal = "";

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );
  @override
  String? get restorationId => "restorationId";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        dataSelecionada = '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

  Future selectedTime(BuildContext context, bool isInicial) async{
    var time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 08, minute: 00),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if(isInicial){
      if(time != null){
        setState((){
          horaInicial =  "Das ${time.hour}:${time.minute}";
        });
      }else{
        horaInicial =  "";
      }
    }else{
      if(time != null){
        setState((){
          horaFinal =  "ás ${time.hour}:${time.minute}";
        });
      }else{
        horaFinal =  "";
      }
    }

  }

  @override
  void initState() {
    storageRef = FirebaseStorage.instance.ref();
    itemsRef = FirebaseDatabase.instance.ref("em_analise");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    imageSelectorGallery() async {
      galleryFile = (await _picker.pickImage(source: ImageSource.gallery))!;
      nameImage = "http-${DateTime.now().millisecondsSinceEpoch}";
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
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child:ListView(
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
                child: SizedBox(
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
            Column(
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
                    child: TextFormField(
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
            Column(
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
                    child: TextFormField(
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
            Column(
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
                    child: TextFormField(
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
            Column(
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
                    child: TextFormField(
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
            Column(
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
                    child: TextFormField(
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
            Column(
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
                    child: TextFormField(
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
            Container(
              margin: const EdgeInsets.only(bottom: 16),
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
                          margin: const EdgeInsets.only(left: 32, right: 16, bottom: 8, top: 8),
                          width: 100,
                          child: GestureDetector(
                            onTap: (){
                              _restorableDatePickerRouteFuture.present();
                            },
                            child: dataSelecionada.isEmpty ? Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.amber.shade300,
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  border: Border.all()
                              ),
                              child: const Text(
                                "Até o Dia:",
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ) : Text(
                              dataSelecionada,
                              style: const TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          )
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
                          width: 90,
                          child: GestureDetector(
                            onTap: (){
                              selectedTime(context, true);
                            },
                            child: horaInicial.isEmpty ? Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.amber.shade300,
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  border: Border.all()
                              ),
                              child: const Text(
                                "Das:",
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ) : Text(
                              horaInicial,
                              style: const TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          )
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
                          width: 75,
                          child: GestureDetector(
                            onTap: (){
                              selectedTime(context, false);
                            },
                            child: horaFinal.isEmpty ? Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.amber.shade300,
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  border: Border.all()
                              ),
                              child: const Text(
                                "Ás:",
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ) : Text(
                              horaFinal,
                              style: const TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                if(_formKey.currentState != null){
                  if (_formKey.currentState!.validate()) {
                    if(dataSelecionada.isNotEmpty && horaInicial.isNotEmpty && horaFinal.isNotEmpty){
                      var imagem = "";
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
                        if(nameImage.isNotEmpty){
                          imagem = serverUrl+nameImage+tokenImage;
                        }else{
                          imagem = "";
                        }
                        map = {
                          keyName : ItemFirebase(
                              imagem: imagem,
                              titulo: tituloCrtl.text,
                              descricao: descriptionCrtl.text,
                              motivo: motivoCrtl.text,
                              especificidades: especifidadesCrtl.text,
                              problemas:problemasCrtl.text,
                              localRetirada: localCrtl.text,
                              prazoRetirada: "$dataSelecionada - $horaInicial $horaFinal",
                              data: day+t+month+t+year+e+hour+i+minute,
                              keyName: keyName,
                              user: FirebaseAuth.instance.currentUser!.uid,
                              isAprovado: false
                          ).toJson()
                        };
                      });
                      itemsRef.update(map);
                      Navigator.pop(context);
                    }else{
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>AlertDialog(
                            title: const Text('Atenção!'),
                            content: const Text('Informe um prazo válido!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                } ,
                                child: const Text('Ok'),
                              ),
                            ],
                          )
                      );
                    }
                  }
                }
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(50, 16, 50, 16),
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
      )
    );
  }
}
