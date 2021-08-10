import 'package:brasil_fields/brasil_fields.dart';
import 'package:clone_olx/components/custom_drawer/custom_drawer.dart';
import 'package:clone_olx/stores/create/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateSreen extends StatelessWidget {
  CreateSreen({Key? key}) : super(key: key);

  final labelStyle =
      TextStyle(fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18);

  final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

  final CreateStore createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImagesField(createStore),
                Observer(builder: (_) {
                  return TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Título *',
                      labelStyle: labelStyle,
                      contentPadding: contentPadding,
                      errorText: createStore.titleError,
                    ),
                    onChanged: createStore.setTitle,
                  );
                }),
                Observer(builder: (_) {
                  return TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Descrição *',
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        errorText: createStore.descriptionError),
                  );
                }),
                CategoryField(createStore),
                CepField(),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Preço *',
                    labelStyle: labelStyle,
                    contentPadding: contentPadding,
                    prefixText: 'R\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    RealInputFormatter(centavos: true)
                  ],
                ),
                HidePhoneField(
                  createStore: createStore,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Enviar',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
