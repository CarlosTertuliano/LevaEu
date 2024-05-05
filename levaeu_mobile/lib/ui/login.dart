import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget{
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login>{
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        centerTitle: true,
      ),

      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget> [
          Column(
            children: <Widget> [

              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(maxWidth: 280),
                child: Image.asset('img/img_login.png'),
              ),

              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                constraints: const BoxConstraints(maxWidth: 350),
                child: const Text(
                  "Entre com seu email ou número de telefone",
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Color.fromRGBO(65, 65, 65, 1)
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 350),
                child: buildTextField("Email ou telefone", TextInputType.emailAddress, emailController)
              ),

              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 5),
                constraints: const BoxConstraints(maxWidth: 350),
                child: buildTextField("Senha", TextInputType.visiblePassword, passController)
              ),

              Container(
                //constraints: const BoxConstraints(maxWidth: 300),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: buildElevatedButton(const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(255, 255, 255, 1), const Color.fromRGBO(57, 96, 143, 1.0), 320, 50, "Entrar", context, Login())
              ),

              Container(
                //constraints: const BoxConstraints(maxWidth: 300, minWidth: 250),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: buildElevatedButton(Colors.white, const Color.fromRGBO(57, 96, 143, 1.0), const Color.fromRGBO(57, 96, 143, 1.0), 320, 50,"Criar conta", context, Login())
              ),

            ],
          )
        ]
      )
    );
  }

  Widget buildTextField(String label, TextInputType inputType, TextEditingController controller) {
    return TextField (
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromRGBO(184, 184, 184, 1)),
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(color: Color.fromRGBO(184, 184, 184, 1), fontSize: 12.0),
      keyboardType: inputType
    );
  }

  Widget buildElevatedButton(Color? colorButton, Color? colorText, Color colorBorder, double sizeWidth, double sizeHeight, String text, BuildContext context, Widget f){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(sizeWidth, sizeHeight),
        backgroundColor: colorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side:  BorderSide(
          color: colorBorder
        )
      ),
      child: Row(
        children: <Widget>[
          Text(
            " $text",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorText,
              fontSize: 16,
            ),
          ),
        ],
      ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => f));        
      }, 
    );
  }

}