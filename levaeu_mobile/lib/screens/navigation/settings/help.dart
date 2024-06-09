import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';

class Help extends StatefulWidget{
  const Help({super.key});

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final _formKeyHelp = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final assuntoController = TextEditingController();
  final questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Suporte",
          style: TextStyle(color: Colors.white),
        ),
      ),
      

      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: <Widget>[

            Form(
              key: _formKeyHelp,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: const BoxConstraints(maxWidth: 300, minWidth: 240),
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    alignment: Alignment.topCenter,
                    child: const Text(
                      "Envie-nos sua dúvida/sugestão",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 300, minWidth: 240, maxHeight: 50, minHeight: 30), 
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      controller: assuntoController,
                      minLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Assunto',
                      ),
                      validator: TextFieldsForms.validateNotEmpty,
                    ),
                    
                  ),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 300, minWidth: 240, maxHeight: 50, minHeight: 30), 
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      controller: emailController,
                      minLines: 1,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                      validator: TextFieldsForms.validateEmail,
                    ),
                  ),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 300, minWidth: 240, maxHeight: 500, minHeight: 300), 
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      maxLines: 10,
                      minLines: 5,
                      controller: questionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Dúvida/sugestão',
                        alignLabelWithHint: kDebugMode
                      ),
                      validator: TextFieldsForms.validateNotEmpty,
                    ),
                  ),

                  Container(
                    constraints: const BoxConstraints(maxWidth: 300),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: ElevatedButton (
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(320, 50),
                        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side:  const BorderSide(
                          color: Color.fromRGBO(57, 96, 143, 1.0), 
                        ),
                      ),
                      child:const Text(
                        "Enviar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 16,
                        ),
                      ),
                      onPressed: (){
                        if (_formKeyHelp.currentState!.validate()) {
                          print("Enviando ${assuntoController.text}, ${emailController.text}, ${questionController.text}");
                          assuntoController.text = "";
                          emailController.text = "";
                          questionController.text = "";
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => f));

                        }        
                      }, 
                    )
                  ),


                ],
              ),
            )
            

          ],
        ),
      ),
    );
  }
}