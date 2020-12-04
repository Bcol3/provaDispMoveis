//import 'dart:js';
import 'dart:async';
import 'dart:html';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projeto_prova/model/logins.dart';

import 'model/pedidos.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fetuccine",
      
      theme: ThemeData(
        primaryColor: Colors.red[400],
        backgroundColor: Colors.red[300],
        fontFamily: "Roboto",
      ),

      initialRoute: "/Login",
      routes: {
        "/Login": (context) => Login(), 
        "/Menu": (context) => Menu(),  
        "/Pedido": (context) => Pedido(),
        "/Andamento": (context) => Andamento(),
        "/Perfil": (context) => Perfil(),
        "/Registra": (context) => Registra(),
        "/Info": (context) => Info(),
        "/Recupera": (context) => Recupera(),
      },
    )
  );


 //teste firebase

 //var db = FirebaseFirestore.instance;
//  db.collection("login").add(
//    {
//      "user": "kayke",
//      "senha": "kayke" 

//    }
//            ID AUTOMATICO
//  );

/*  db.collection("login").doc("login00001").set(
    {
      "user": "kayke",
      "senha": "kayke" 

    }
            ID MANUAL
 ); */ 

}

//LOGIN

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();

  static fromMap(Map<String, dynamic> data, String id) {}
}

class _LoginState extends State<Login> {

  //Chave do formulario

  var formkey = GlobalKey<FormState>();
  
  TextEditingController txtLogin = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  var db = FirebaseFirestore.instance;  
  List<Logins>lista = List();
  StreamSubscription<QuerySnapshot>ouvinte;
  @override
  void initState(){
    super.initState();
    ouvinte?.cancel();
    ouvinte = db.collection("login").snapshots().listen((res) { 
      setState(() {
        lista = res.docs.map((e) => Logins.fromMap(e.data(),e.id)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor: Theme.of(context).primaryColor,
    body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(40),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 5
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("imagens/Molho.jpg"),

                    //fit: BoxFit.fill,

                  )
                ),
                //child: Image.asset(,)
              ),
              
              Divider(
                height: 100,
                color: Colors.transparent,
              ),

              Text(
                " ~ Fetuccine",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),

              Divider(
                height: 100,
                color: Colors.transparent,
              ),

              campoTextoLogin("Login",txtLogin),
              campoTextoSenha("Senha",txtSenha),
              esqueceuSenha("Esqueceu sua senha?"),

              SizedBox(
                height: 2,
              ),
              btnLogin("Login"),
              SizedBox(
                height: 50,
              ),

              btnRegistrar("Registrar-se"),
            ],
          ),
        ),

      )
      
      ),
    );
  }

  //Campo login

Widget campoTextoLogin(rotulo, variavelControle){
  return Container(
    padding: EdgeInsets.all(5),
    child: TextFormField(
      controller: variavelControle,
      cursorColor: Colors.white,
      style: TextStyle(fontSize: 20,color: Colors.black),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.black),
        fillColor: Colors.white,
        filled: true,
        labelText: rotulo,
        icon: Icon(Icons.people,color: Colors.white,),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),

      ),
      validator: (value) {
        if (value == null || value.isEmpty || value.contains(" ")){
          return "Login incorreto!";
        }
        return null;
      },
    ),
  );
}

//Campo Senha

Widget campoTextoSenha(rotulo, variavelControle){
  return Container(
    padding: EdgeInsets.all(5),
    child: TextFormField(
      controller: variavelControle,
      obscureText: true,
      cursorColor: Colors.white,
      style: TextStyle(fontSize: 20,color: Colors.black),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.black),
        labelText: rotulo,
        icon: Icon(Icons.lock,color: Colors.white,),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      validator: (value){
        if (value == null || value.isEmpty || value.length <= 1) {
          return "Senha incorreta!";
        }
        return null;
      }
    ),
  );
}

//btn login

Widget btnLogin(rotulo){
  //ist<Login> logins = List();

  //StreamSubscription<QuerySnapshot> ouvidor;
  return Container(
    alignment: Alignment.center,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    child: SizedBox.expand(
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              rotulo,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            Container(
              child: SizedBox(child: Icon(Icons.login,color: Colors.black,),
              ),
            ),
          ],
        ),

        onPressed: (){ 
          
          String login = txtLogin.text;
          String senha = txtSenha.text;

          bool validate = false;
          debugPrint("lista de usuarios: $lista");
          if (formkey.currentState.validate()){
            setState(() {

              lista.forEach((element) {
                if(login == element.user && senha == element.senha){
                  validate = true;
                  debugPrint("Login: $login e Senha: $senha");
                }
              });

              if (!validate){
              debugPrint("Login: $login e Senha: $senha // NAO CADASTRADOS!!!" );
              caixaDialogo("Usuário ou Senha inválida!!");
              txtLogin.clear();
              txtSenha.clear();
              }
            
              if(validate){
                Navigator.pushNamed(context, "/Menu");
                txtLogin.clear();
                txtSenha.clear();
              }
            });

          }
          
        }, 
      ),
    ),
  );
}

//Esqueceu senha

Widget esqueceuSenha(rotulo){
  return Container(
    height: 100,
    alignment: Alignment.center,
    child: FlatButton(
      child: Text(rotulo,style: TextStyle(color: Colors.white),),
      onPressed: () {
        Navigator.pushNamed(context, "/Recupera");
      }
    ),
  );
}

//Registrar-se

Widget btnRegistrar(rotulo){
  //var db = FirebaseFirestore.instance;
  return Container(
    height: 40,
    child: FlatButton(
      child: Text(
        rotulo,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,decoration: TextDecoration.underline),
      ),
      onPressed: (){
        Navigator.pushNamed(context, "/Registra");
      },
    ),
  );

}

caixaDialogo(msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Aviso:", style: TextStyle(fontSize: 16,color: Colors.red[400], fontWeight: FontWeight.bold),),
          content: Text(msg, style: TextStyle(fontSize: 16, color: Colors.black)),

          actions: [
            FlatButton(
              color: Colors.red[400],
              onPressed: () {
                Navigator.of(context).pop();
                },
                child: Text('Entendi', style: TextStyle(color: Colors.white),),
            )
          ],
        );
      }
      );
  }

}



//MENU

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetuccine"),
        backgroundColor: Theme.of(context).primaryColor,),
        body: Container(
          padding: EdgeInsets.all(60),
          child: ListView(
              children: [
                Text("Menu",style: TextStyle(fontSize: 44,fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                ListTile(
                  leading: Icon(
                    Icons.double_arrow,
                    color: Colors.red[400],
                  ),
                  title: Text("Fazer Pedido", style: TextStyle(fontSize: 25),),
                  onTap: (){
                    Navigator.pushNamed(context, "/Pedido");
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.double_arrow,
                    color: Colors.red[400],
                  ),
                  title: Text("Andamento", style: TextStyle(fontSize: 25),),
                  onTap: (){
                    Navigator.pushNamed(context, "/Andamento");
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.double_arrow,
                    color: Colors.red[400],
                  ),
                  title: Text("Perfil", style: TextStyle(fontSize: 25),),
                  onTap: (){
                    Navigator.pushNamed(context, "/Perfil");
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.double_arrow,
                    color: Colors.red[400],
                  ),
                  title: Text("Informação" , style: TextStyle(fontSize: 25),),
                  onTap: (){
                    Navigator.pushNamed(context, "/Info");
                  },
                ),
                SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: FaIcon(FontAwesomeIcons.instagram),
                      color: Colors.red[400],
                      alignment: AlignmentDirectional.centerStart,

                    ),
                    IconButton(
                      onPressed: (){},
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      color: Colors.red[400],
                      alignment: AlignmentDirectional.centerEnd
                    )
                  ],

                )
              ],

          )

          
        ),
      
    );
  }
}

//PEDIDO

class Pedido extends StatefulWidget {
  @override
  _PedidoState createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> {
  var formkey = GlobalKey<FormState>();
  
  TextEditingController txtTamanho = TextEditingController();
  TextEditingController txtEndereco = TextEditingController();

  var db = FirebaseFirestore.instance;  
  List<Pedidos>lista = List();
  StreamSubscription<QuerySnapshot>ouvinte;

  @override
  void initState(){
    super.initState();
    ouvinte?.cancel();
    ouvinte = db.collection("pedidos").snapshots().listen((res) { 
      setState(() {
        lista = res.docs.map((e) => Pedidos.fromMap(e.data(),e.id)).toList();
      });
    });
  }
  String tamanho="";
   var _tamanho =['Pequeno - 500g','Grande - 1kg'];
   var _itemSelecionado = 'Pequeno - 500g';
   //var endereco = String;
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido"),
        backgroundColor: Colors.red[400],
       ),
       body: Container(
         child: Column(
           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children:[
             SizedBox(height: 50),
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Container(
                   child: Text("Faça seu pedido:", style: TextStyle(fontSize:30, fontWeight: FontWeight.bold, color: Colors.black),),
                   padding: EdgeInsets.only(left: 30),
                   ),
               ],
             ),
             widgetTextField(txtEndereco),
             SizedBox(height: 20),
             criaDropDownButton(),
             SizedBox(height: 20),
             FlatButton(
               height: 50,
               minWidth: 100,
              color: Colors.red[400],
              onPressed: () {
                String endereco = txtEndereco.text;
                String tamanho = txtTamanho.text;

                setState(() {
                  db.collection("pedidos").add(
                    {
                      "endereco": endereco,
                      "tamanho": _itemSelecionado,
                    }
                  );
                });
                
                Navigator.of(context).pop();
                },
                child: Text('Salvar', style: TextStyle(color: Colors.white),),
            )
             
             ],
             
           ),
           
           )
   );
  }

  widgetTextField(variavelControle) {
    return Container(
      child:Padding(
        padding: const EdgeInsets.only(left: 150,right: 110,top: 30),
        child: TextField(
            controller: variavelControle,
            decoration:InputDecoration(border: InputBorder.none,
            icon: FaIcon(FontAwesomeIcons.addressCard),
            hintText: ('Informe seu endereço'),
    )
    ),
      ),
    );
    
  }

     criaDropDownButton() {
       return Container(
       child: Column(
         children: <Widget>[
           SizedBox(height: 10),
           DropdownButton<String>(
             items : _tamanho.map((String dropDownStringItem) {
               return DropdownMenuItem<String>(
                 value: dropDownStringItem,
                 child: Text(dropDownStringItem),
                );
             }).toList(),
             onChanged: ( String novoItemSelecionado) {
               _dropDownItemSelected(novoItemSelecionado);
               setState(() {
                this._itemSelecionado =  novoItemSelecionado;
               });
             },
             value: _itemSelecionado
           ),

           SizedBox(height: 40),

           Container(
             child: Padding(
               padding: const EdgeInsets.only(left:20.0),
               child: Text("O tamanho do molho selecionado foi \n$_itemSelecionado e será entregue no endereço selecionado.",
                  style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400]
                  ),
                ),
             ),
           ),

         ],
        ),
      );
   }
   void _dropDownItemSelected(String novoItem){
       setState(() {
        this._itemSelecionado = novoItem;
       });
   }
}

class Recupera extends StatefulWidget {
  @override
  _RecuperaState createState() => _RecuperaState();
}

class _RecuperaState extends State<Recupera> {
  // Chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      backgroundColor: Colors.red[400],
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 40, left:40, right: 40),
        child: Form(
          key: formKey,
            child: Column(
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: Icon(
                  Icons.lock_open_rounded,
                  size: 120,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Para recuperar sua senha, por gentileza informar o E-mail associado a sua conta. \n\n Um link conténdo informações será enviado ao seu e-mail",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
                  ),
                  textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
      TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: "E-mail",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400
              ),
          ),
          controller: txtEmail,
          validator: (value) {
            if (value == null || value.isEmpty || value.contains(' ')) {
              return 'Campo vazio ou incorreto.';
            }
            return null;
          },
          style: TextStyle(fontSize: 20),
      ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 1],
                colors: [
              Colors.white,
              Colors.white,
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(5),),
            ),
            child: SizedBox.expand(
              // BOTÃO
              child: FlatButton(
                child: Text(
                  "Enviar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),

                onPressed: () {
                  if (formKey.currentState.validate()) {
                    setState(() {
                      caixaDialogo("Um link de recuperação de senha foi enviado para o e-mail ${txtEmail.text}.\n\nPor favor verifique a Caixa de Entrada e/ou Spam.");
                    });
                  }
                },
              ),
            ),
          ),
    SizedBox(
    height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //
  // CAIXA DE DIALOGO
  //
  caixaDialogo(msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Aviso", style: TextStyle(fontSize: 16),),
          content: Text(msg, style: TextStyle(fontSize: 16)),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                },
                child: Text('ok!'),
                color: Colors.black,
            )
          ],
        );
      }
      );
  }
}

class Registra extends StatefulWidget {
  @override
  _RegistraState createState() => _RegistraState();
}

class _RegistraState extends State<Registra> {
    // Chave que identifica unicamente o formulário
  var formKey = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtLogin = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

  var db = FirebaseFirestore.instance;
  List<Logins>lista = List();
  StreamSubscription<QuerySnapshot>ouvinte;
  @override
  void initState(){
    super.initState();
    ouvinte?.cancel();
    ouvinte = db.collection("login").snapshots().listen((res) { 
      setState(() {
        lista = res.docs.map((e) => Logins.fromMap(e.data(),e.id)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30, left: 40, right: 40),
        child: Form(
          key: formKey,
            child: Column(
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                alignment: Alignment(0.0, 1.15),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30),), 
                  image: new DecorationImage(
                    image: AssetImage("imagens/profile.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Container(
                  height: 56,
                  width: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1.0],
                      colors: [
                        Colors.red[400],
                        Colors.red[400],
                      ],
                    ),
                    border: Border.all(
                      width: 4.0,
                      color: const Color(0xFFFFFFFF),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(56),),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Icon(
                          Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
      TextFormField(
          // autofocus: true,
          controller: txtLogin,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            focusColor: Colors.red[400],
            fillColor: Colors.white,
            filled: true,
            labelText: "Nome",
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          style: TextStyle(fontSize: 20),
      ),
      SizedBox(
          height: 20
      ),
      TextFormField(
          controller: txtEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: "E-mail",
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            return null;
          },
          style: TextStyle(fontSize: 20),
      ),
      SizedBox(
          height: 20,
      ),
      TextFormField(
          controller: txtSenha,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: "Senha",
            labelStyle: TextStyle(
              color: Colors.black38,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Campo vazio';
            }
            else if (value.length <= 3) {
              return 'Senha muito pequena!';
            }
            return null;
          },
          style: TextStyle(fontSize: 20),
      ),
      SizedBox(
          height: 10,
      ),
      Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1.0],
              colors: [
                Colors.black,
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(5),),
          ),
          child: SizedBox.expand(
            child: FlatButton(
              child: Text("Cadastrar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),
              ),
              onPressed: () {

                String email = txtEmail.text;
                String login = txtLogin.text ;
                String senha = txtSenha.text;

                if (formKey.currentState.validate()) {
                  setState(() {
                    
                     db.collection("login").add(
                      {
                        "user": login,
                        "senha": senha,
                        "email": email
                      }
                    );
                    
                    caixaDialogo("Um link com a confirmação de e-mail foi enviado no e-mail ${txtEmail.text}.\n\n");
                    txtLogin.clear();
                    txtSenha.clear();
                    txtEmail.clear();
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ),
      ),
      SizedBox(
          height: 10,
      ),
      Container(
          height: 40,
          alignment: Alignment.center,
          child: FlatButton(
            color: Colors.black,
            child: Text(
              "Cancelar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
      ),
            ],
          ),
        ),
      ),
    );
  }

  //
  // CAIXA DE DIALOGO
  //
  caixaDialogo(msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Aviso", style: TextStyle(fontSize: 16),),
          content: Text(msg, style: TextStyle(fontSize: 16)),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                },
                child: Text('Entendi'),
            )
          ],
        );
      }
      );
  }
}

//ANDAMENTO

class Andamento extends StatefulWidget {
  @override
  _AndamentoState createState() => _AndamentoState();
}

class _AndamentoState extends State<Andamento> {
   var db = FirebaseFirestore.instance;
  List<Pedidos>lista = List();
  StreamSubscription<QuerySnapshot>ouvinte;
  @override
  void initState(){
    super.initState();
    ouvinte?.cancel();
    ouvinte = db.collection("pedidos").snapshots().listen((res) { 
      setState(() {
        lista = res.docs.map((e) => Pedidos.fromMap(e.data(),e.id)).toList();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Pedidos em Andamento"),
        backgroundColor: Theme.of(context).primaryColor,),
        body: Container(
          padding: EdgeInsets.all(60),
          child: ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context,index){
              return ListTile(
                title: Text(lista[index].endereco),
                subtitle: Text(lista[index].tamanho),
                leading: Icon(
                    Icons.arrow_right,
                    color: Colors.red[400],
                  ),

              );
            }
          )

          
        ),     
    );
  }
}

//PERFIL

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
        title: Text("Perfil do usuário"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(60),
        child: Column(
          children: <Widget>[
           Container(
                width: 200,
                height: 200,
                alignment: Alignment(0.0, 1.15),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30),), 
                  image: new DecorationImage(
                    image: AssetImage("imagens/profile.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Container(
                  height: 56,
                  width: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.3, 1.0],
                      colors: [
                        Colors.red[400],
                        Colors.red[400],
                      ],
                    ),
                    border: Border.all(
                      width: 4.0,
                      color: const Color(0xFFFFFFFF),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(56),),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Icon(
                          Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ),
              ),
            
            
          
          Divider(
            color: Colors.red[400],
            height: 100,
            thickness: 3,
          ),

          const Text.rich(
            TextSpan(
              text: 'E-mail: ',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), // default text style
              children: <TextSpan>[
                TextSpan(text: "E-mail do usuário", style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
              ],
            ),
          ),

          Divider(
            color: Colors.transparent,
            height: 50,
            thickness: 0,
          ),

          const Text.rich(

            TextSpan(
              text: "Nome: ",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), // default text style
              children: <TextSpan>[
                TextSpan(
                  text: "Nome Usuário",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
                  ),
              ],
            ),
          ),

          Divider(
            color: Colors.transparent,
            height: 50,
            thickness: 0,
          ),          

          const Text.rich(

            TextSpan(
              text: "Hash ID: ",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), // default text style
              children: <TextSpan>[
                TextSpan(
                  text: "xxxxxxxxxxx",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
                  ),
              ],
            ),
          ),

          Divider(
            color: Colors.transparent,
            height: 50,
            thickness: 0,
          ),

    
          ],
        ),
      ),
      
    );
  }
}

//INFORMAÇÃO

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informações do desenvolvedor"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(60),
        child: Column(
          children: <Widget>[
          Container(
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
              image: AssetImage("imagens/bruno.jpg"),
              fit: BoxFit.none
              ), 
              ),
            ),
            
            
          
          Divider(
            color: Colors.red[400],
            height: 50,
            thickness: 3,
          ),

          const Text.rich(
            TextSpan(
              text: 'Desenvolvedor: ',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), // default text style
              children: <TextSpan>[
                TextSpan(text: "Bruno Coletti Marano", style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
              ],
            ),
          ),

          Divider(
            color: Colors.transparent,
            height: 50,
            thickness: 0,
          ),

          const Text.rich(

            TextSpan(
              text: "Tema: ",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), // default text style
              children: <TextSpan>[
                TextSpan(
                  text: "Aplicativo para entrega de comida",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
                  ),
              ],
            ),
          ),

          Divider(
            color: Colors.transparent,
            height: 50,
            thickness: 0,
          ),          

          const Text.rich(

            TextSpan(
              text: "Objetivo: ",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), // default text style
              children: <TextSpan>[
                TextSpan(
                  text: "Auxiliar na entrega de molho de tomate artesanal, realizando a interação entre cliente x fornecedor.",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
                  ),
              ],
            ),
          ),

          Divider(
            color: Colors.transparent,
            height: 50,
            thickness: 0,
          ),

    
          ],
        ),
      ),

      
    );
  }
}
