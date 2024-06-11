import 'package:flutter/material.dart';
import 'package:levaeu_mobile/model/user_data.dart';
import 'package:levaeu_mobile/utils/text_fields_forms.dart';
import 'package:provider/provider.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  SecurityState createState() => SecurityState();
}

class SecurityState extends State<Security> {
  TextEditingController senhaAtual = TextEditingController();
  TextEditingController novaSenha = TextEditingController();
  final _formKeyPass = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,

      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 96, 143, 1.0),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Segurança",
          style: TextStyle(color: Colors.white),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(
                maxWidth: 380,
                minWidth: 200,
                maxHeight: 100,
                minHeight: 50,
              ),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 80),
                  maximumSize: const Size(320, 120),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Color.fromRGBO(196, 198, 208, 1.0),
                  ),
                ),
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.key),
                    Text(
                      " Alterar senha",
                      style: TextStyle(
                        color: Color.fromRGBO(90, 90, 90, 1.0),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true, 
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.35, 
                          minChildSize: 0.2, 
                          maxChildSize: 0.8,
                          builder: (BuildContext context, ScrollController scrollController) {
                            return Form(
                              key: _formKeyPass,
                              child: Container(
                                color: Colors.white,
                                padding: const EdgeInsets.all(16.0),
                                child: SingleChildScrollView(
                                  controller: scrollController, 
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[

                                      TextFormField(
                                        obscureText: true,
                                        controller: senhaAtual,
                                        validator: TextFieldsForms.validatePassword,
                                        decoration: const InputDecoration(
                                          hintText: 'Senha atual',
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      TextFormField(
                                        obscureText: true,
                                        controller: novaSenha,
                                        validator: TextFieldsForms.validatePassword,
                                        decoration: const InputDecoration(
                                          hintText: 'Nova senha',
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      ElevatedButton(
                                        onPressed: () {
                                          if (userData.pass == senhaAtual.text && _formKeyPass.currentState!.validate()) {
                                            print(userData.pass);
                                            userData.updatePass(novaSenha.text);
                                            print(userData.pass);
                                            novaSenha.text = "";
                                            senhaAtual.text = "";
                                            Navigator.pop(context);
                                          } else if (userData.pass != senhaAtual.text) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Senha atual incorreta')),
                                            );
                                          }
                                        },
                                        child: const Text('Alterar senha'),
                                      ),

                                      const SizedBox(height: 10),
                                      
                                      ElevatedButton(
                                        child: const Text('Fechar'),
                                        onPressed: (){ 
                                          novaSenha.text = "";
                                          senhaAtual.text = "";
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
