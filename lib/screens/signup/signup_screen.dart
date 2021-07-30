import 'package:brasil_fields/brasil_fields.dart';
import 'package:clone_olx/components/box_error.dart';
import 'package:clone_olx/screens/signup/components/field_title.dart';
import 'package:clone_olx/stores/signup_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignUpStore signUpStore = SignUpStore();

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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(builder: (_) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: BoxError(message: signUpStore.error));
                    }),
                    FieldTitle(
                        title: 'Apelido',
                        subtitle: 'Como aparecerá nos seus anúncios.'),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !(signUpStore.loading),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Exemplo: João S.',
                          isDense: true,
                          errorText: signUpStore.nameError,
                        ),
                        onChanged: signUpStore.setName,
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(
                        title: 'Email',
                        subtitle: 'Enviaremos um email de confirmação.'),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !(signUpStore.loading),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Exemplo: joao@email.com',
                          isDense: true,
                          errorText: signUpStore.emailError,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: signUpStore.setEmail,
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(
                        title: 'Celular', subtitle: 'Proteja sua conta.'),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !(signUpStore.loading),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Exemplo: (99) 99999-9999',
                            isDense: true,
                            errorText: signUpStore.phoneError),
                        keyboardType: TextInputType.phone,
                        autocorrect: false,
                        onChanged: signUpStore.setPhone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(
                        title: 'Senha',
                        subtitle: 'Use letras, números e caracteres especiais'),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !(signUpStore.loading),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signUpStore.passwordError),
                        obscureText: true,
                        onChanged: signUpStore.setPassword,
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(
                        title: 'Confirme sua senha',
                        subtitle: 'Repita sua senha'),
                    Observer(builder: (_) {
                      return TextField(
                        enabled: !(signUpStore.loading),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            isDense: true,
                            errorText: signUpStore.confirmedPasswordError),
                        obscureText: true,
                        onChanged: signUpStore.setConfirmedPassword,
                      );
                    }),
                    Observer(builder: (_) {
                      return Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 12),
                        height: 40,
                        child: ElevatedButton(
                          onPressed: signUpStore.signUpPressed,
                          child: (signUpStore.loading)
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  'CADASTRAR',
                                  style: TextStyle(color: Colors.white),
                                ),
                          style: ButtonStyle(
                              backgroundColor: signUpStore.isFormValid &&
                                      !signUpStore.loading
                                  ? MaterialStateProperty.all<Color>(
                                      Colors.orange)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.orange.withAlpha(120)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)))),
                        ),
                      );
                    }),
                    Divider(
                      color: Colors.black,
                    ),
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
      ),
    );
  }
}
