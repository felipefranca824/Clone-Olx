import 'package:brasil_fields/brasil_fields.dart';
import 'package:clone_olx/stores/cep/cep_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CepField extends StatelessWidget {
  CepField({Key? key}) : super(key: key);

  final CepStore cepStore = CepStore();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: cepStore.setCep,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          decoration: InputDecoration(
            labelText: 'CEP *',
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w800,
            ),
            contentPadding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
          ),
        ),
        Observer(builder: (_) {
          if (cepStore.address == null &&
              cepStore.error == null &&
              !cepStore.loading) {
            return Container();
          } else if (cepStore.address == null && cepStore.error == null) {
            return LinearProgressIndicator();
          } else if (cepStore.error != null) {
            return Container(
              alignment: Alignment.center,
              color: Colors.red.withAlpha(100),
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                cepStore.error.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            final address = cepStore.address;

            return Container(
              alignment: Alignment.center,
              color: Colors.purple.withAlpha(150),
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                'Localização: ${address!.district}, ${address.city.name} - ${address.uf.initials}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        })
      ],
    );
  }
}
