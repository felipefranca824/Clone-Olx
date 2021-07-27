import 'package:brasil_fields/brasil_fields.dart';
import 'package:clone_olx/screens/signup/components/field_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FieldTitle(
                      title: 'Apelido',
                      subtitle: 'Como aparecerá nos seus anúncios.'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Exemplo: João S.',
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FieldTitle(
                      title: 'Email',
                      subtitle: 'Enviaremos um email de confirmação.'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Exemplo: joao@email.com',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  const SizedBox(height: 16),
                  FieldTitle(title: 'Celular', subtitle: 'Proteja sua conta.'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Exemplo: (99) 99999-9999',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FieldTitle(
                      title: 'Senha',
                      subtitle: 'Use letras, números e caracteres especiais'),
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  FieldTitle(
                      title: 'Confirme sua senha',
                      subtitle: 'Repita sua senha'),
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: true,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 12),
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('CADASTRAR'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Divider(color: Colors.black,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text(
                          'Já tem uma conta? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: Colors.purple,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}