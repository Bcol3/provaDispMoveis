//import 'dart:js';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
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
        "/Info": (context) => Info(),
      },
    )
  );
}

//LOGIN

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //Chave do formulario

  var formkey = GlobalKey<FormState>();

  TextEditingController txtLogin = TextEditingController();
  TextEditingController txtSenha = TextEditingController();

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
              //Image.asset("imagens/bruno.jpg"),
              
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
        if (value == null || value.isEmpty || value.length <= 8) {
          return "Senha incorreta!";
        }
        return null;
      }
    ),
  );
}

//btn login

Widget btnLogin(rotulo){
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

        onPressed: () { 
          if (formkey.currentState.validate()){
            setState(() {
              Navigator.pushNamed(context, "/Menu");
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
        Navigator.pushNamed(context, "/Menu");
      }
    ),
  );
}

//Registrar-se

Widget btnRegistrar(rotulo){
  return Container(
    height: 40,
    child: FlatButton(
      child: Text(
        rotulo,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,decoration: TextDecoration.underline),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/Info");
      },
    ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}

//ANDAMENTO

class Andamento extends StatefulWidget {
  @override
  _AndamentoState createState() => _AndamentoState();
}

class _AndamentoState extends State<Andamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
          Image.asset("imagens/bruno.jpg"),
          
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
