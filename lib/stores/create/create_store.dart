import 'package:clone_olx/models/Category.dart';
import 'package:mobx/mobx.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStoreBase with _$CreateStore;

abstract class _CreateStoreBase with Store {
  
  ObservableList images = ObservableList();

  @observable
  Category? category;

  @observable
  String title = '';

  @observable
  String description = '';

  @observable
  bool? hidePhone = false;

  @action
  void setHidePhone(bool? value) => hidePhone = value;

  @action
  setCategory(Category? value) => category = value;

  @action
  void setTitle(String value) => title = value;

  @action
  void setDecription(String value) => description = value;

  @computed
  bool get imagesValid => images.isNotEmpty;
  String? get imagesError{
    if(imagesValid) return null;
    else return 'Insira imagens';
  }


  @computed
  bool get titleValid => title.length >= 6;
  String? get titleError{
    if(titleValid) return null;
    else if(title.isEmpty) return 'Campo Obrigatório';
    else return 'Título muito curto';
  }

  @computed
  bool get descriptionValid => description.length >= 10;
  String? get descriptionError{
    if(descriptionValid) return null;
    else if(description.isEmpty) return 'Campo Obrigatório';
    else return 'Descrição muito curta';
  }


}