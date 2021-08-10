import 'package:clone_olx/models/address.dart';
import 'package:clone_olx/repository/cep_repository.dart';
import 'package:mobx/mobx.dart';
part 'cep_store.g.dart';

class CepStore = _CepStoreBase with _$CepStore;

abstract class _CepStoreBase with Store {

  _CepStoreBase(){
    autorun((_){
      if(clearCep.length != 8){
        _reset();
      } else {
        _searchCep();
      }
    });
  }
  
  @observable
  String cep = '';

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  Address? address;

  @action
  void setCep(String value) => cep = value;

  void setError(String value) => error = value;

  @computed
  String get clearCep => cep.replaceAll(RegExp('[^0-9]'), '');

  @action
  _searchCep() async {
    loading = true;
    try {
      address = await CepRepository().getAddressFromApi(clearCep);
      error = null;
    } catch (e) {
      error = e.toString();
      address = null;
    }
    
    loading = false;
  }

  @action
  void _reset(){
    error = null;
    address = null;
  }
}