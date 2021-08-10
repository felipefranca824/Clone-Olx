import 'package:clone_olx/stores/create/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HidePhoneField extends StatelessWidget {
  HidePhoneField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: Row(
        children: [
          Observer(builder: (_) {
            return Checkbox(
              value: createStore.hidePhone,
              onChanged: createStore.setHidePhone,
              activeColor: Colors.purple,
            );
          }),
          Expanded(
            child: Text('Ocultar meu telefone neste anúncio'),
          ),
        ],
      ),
    );
  }
}
