import 'package:projeto_prova/main.dart';

class Pedidos{

  String id;
  String endereco;
  String tamanho;

  Pedidos(this.id, this.endereco, this.tamanho);

  //Converter um DOCUMENTO em um OBJETO

  Pedidos.fromMap(Map<String,dynamic>map, String id){
    
    // Se parametro id != null, entao this.id = id,
    //Senao, this.id = '';
    
    this.id = id ?? '';
    this.endereco= map['endereco'];
    this.tamanho = map['tamanho'];
  }


}