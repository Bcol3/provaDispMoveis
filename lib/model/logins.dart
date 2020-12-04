import 'package:projeto_prova/main.dart';

class Logins{

  String id;
  String user;
  String senha;
  String email;

  Logins(this.id, this.user, this.senha, this.email);

  //Converter um DOCUMENTO em um OBJETO

  Logins.fromMap(Map<String,dynamic>map, String id){
    
    // Se parametro id != null, entao this.id = id,
    //Senao, this.id = '';
    
    this.id = id ?? '';
    this.user = map['user'];
    this.senha = map['senha'];
    this.email = map['email'];
  }


}