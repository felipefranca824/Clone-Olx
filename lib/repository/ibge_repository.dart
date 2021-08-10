import 'dart:convert';

import 'package:clone_olx/models/city.dart';
import 'package:clone_olx/models/uf.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IBGERepository {
  Future<List?> getUFList() async {

    final preferences = await SharedPreferences.getInstance();

    if(preferences.containsKey('UF_LIST')){
      final j = json.decode(preferences.get('UF_LIST').toString());

      return j.map<UF>((e) => UF.fromJson(e)).toList()
        ?..sort((UF a, UF b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    }

    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    try {
      final response = await Dio().get<List>(endpoint);

      preferences.setString('UF_LIST', json.encode(response.data));

      final ufList = response.data?.map<UF>((e) => UF.fromJson(e)).toList()
        ?..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return ufList;
    } on DioError {
      return Future.error('Falha ao obter lista de estados.');
    }
  }

  getCityListFromApi(UF uf) async {
    final endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';

    try {
      final response = await Dio().get<List>(endpoint);

      final cityList = response.data
          ?.map<City>((e) => City.fromJson(e))
          .toList()
            ?..sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return cityList;
    } on DioError {
      return Future.error('Falha ao obter a lista de cidades');
    }
  }
}
