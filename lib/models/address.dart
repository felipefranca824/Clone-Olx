import 'package:clone_olx/models/city.dart';
import 'package:clone_olx/models/uf.dart';

class Address {
  
  Address({
    required this.uf,
    required this.city,
    required this.cep,
    required this.district,
  });
  
  UF uf;
  City city;
  String cep;
  String district;
  
}
