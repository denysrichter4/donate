import 'dart:ffi';

class Usuario{
  final String uuid;
  bool? admin = false;
  final String nome;
  final String email;
  final Future<String> senha;

  Usuario({
    required this.uuid,
    this.admin,
    required this.nome,
    required this.email,
    required this.senha,
  });

  Usuario.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        admin = json['admin'],
        nome = json['nome'],
        email = json['email'],
        senha = json['senha'];

  Map toJson() {
    return {
      'uuid': uuid,
      'admin': admin,
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }
}