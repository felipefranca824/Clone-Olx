import 'package:clone_olx/models/address.dart';
import 'package:clone_olx/models/city.dart';
import 'package:clone_olx/repository/ibge_repository.dart';
import 'package:dio/dio.dart';

class CepRepository {
  Future<Address> getAddressFromApi(String cep) async {
    if (cep == null || cep.isEmpty) {
      return Future.error('CEP Inválido');
    }

    final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');

    if (clearCep.length != 8) {
      return Future.error('CEP Inválido');
    }

    final endpoint = 'https://viacep.com.br/ws/$clearCep/json/';

    try {
      final response = await Dio().get<Map>(endpoint);

      if (response.data!.containsKey('erro') && response.data!['erro']) {
        return Future.error('Cep Inválido');
      }

      final ufList = await IBGERepository().getUFList();

      return Address(
        uf: ufList!.firstWhere((uf) => uf.initials == response.data!['uf']),
        city: City(name: response.data!['localidade']),
        cep: response.data!['cep'],
        district: response.data!['bairro'],
      );
    } catch (e) {
      return Future.error('Falha ao buscar CEP');
    }
  }
}
