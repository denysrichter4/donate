import 'package:donate/model/item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ItemSelecionado extends StatefulWidget {
  final ItemFirebase itemFirebase;
  final bool isPrincipal;
  const ItemSelecionado({Key? key, required this.itemFirebase, required this.isPrincipal}) : super(key: key);

  @override
  State<ItemSelecionado> createState() => _ItemSelecionadoState();
}

class _ItemSelecionadoState extends State<ItemSelecionado> with RestorationMixin{

  bool isSelected = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Anúncio",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            color: Colors.black12,
            child: !widget
                .itemFirebase
                .imagem!.contains("http")?
                const Center(
                  child: Text("Anúncio sem Imagens!"),
                ):
            Image.network(
              widget.itemFirebase.imagem!,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    widget.itemFirebase.titulo,
                    style: const TextStyle(
                        fontSize: 28,
                        color: Colors.black54
                    ),
                  ),
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Descrição",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        widget.itemFirebase.descricao,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  )
                ),
                const Divider(),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Motivo",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          widget.itemFirebase.descricao,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    )
                ),
                const Divider(),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Especificidades (Voltagem, detalhes, ect...)",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          widget.itemFirebase.descricao,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    )
                ),
                const Divider(),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            "Problemas/Danos",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Text(
                          widget.itemFirebase.descricao,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    )
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Local",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        widget.itemFirebase.localRetirada,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Prazo de retirada Doador :",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        widget.itemFirebase.prazoRetirada,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                widget.itemFirebase.isAprovado! ? Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Prazo de retirada Donatário :",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        "${widget.itemFirebase.dataSolicitada!} - ${widget.itemFirebase.horarioSolicitado!}",
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45
                        ),
                      ),
                    ],
                  ),
                ) :Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 0, right: 16, top: 16, bottom: 8),
                        child:  Text(
                          "Prazo de retirada Donatário:",
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
                                    "No Dia:",
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
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: widget.isPrincipal ? (widget.itemFirebase.isAprovado! ? GestureDetector(
        onTap: (){
          FirebaseDatabase.instance.ref("em_andamento").update({widget.itemFirebase.keyName : widget.itemFirebase.toJson()});
          FirebaseDatabase.instance.ref("principal/${widget.itemFirebase.keyName}").remove();
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(80, 16, 60, 16),
          height: 50,
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade400
              ),
              alignment: Alignment.center,
              child: const Text(
                "Aprovar Retirada!",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
          ),
        ),
      ) : GestureDetector(
        onTap: (){
          Map<String, dynamic> map = {};
          if(widget.itemFirebase.user != FirebaseAuth.instance.currentUser!.uid){
            if(dataSelecionada.isNotEmpty && horaInicial.isNotEmpty && horaFinal.isNotEmpty){
              setState(() {
                widget.itemFirebase.userInteressado = FirebaseAuth.instance.currentUser!.uid;
                widget.itemFirebase.isAprovado = true;
                widget.itemFirebase.dataSolicitada = dataSelecionada;
                widget.itemFirebase.horarioSolicitado = "$horaInicial $horaFinal";
                map = {widget.itemFirebase.keyName : widget.itemFirebase.toJson()};
              });
              FirebaseDatabase.instance.ref("principal").update(map);
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
          }else{
            showDialog<String>(
                context: context,
                builder: (BuildContext context) =>AlertDialog(
                  title: const Text('Atenção!'),
                  content: const Text('Você não pode aceitar o item que está doando!'),
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

        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(80, 16, 60, 16),
          height: 50,
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber.shade400
              ),
              alignment: Alignment.center,
              child: const Text(
                "Quero esse item!!",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
          ),
        ),
      )) : const Padding(padding: EdgeInsets.zero),
    );
  }
}
