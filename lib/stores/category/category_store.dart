import 'package:clone_olx/models/Category.dart';
import 'package:clone_olx/repository/category_repository.dart';
import 'package:mobx/mobx.dart';
part 'category_store.g.dart';

class CategoryStore = _CategoryStoreBase with _$CategoryStore;

abstract class _CategoryStoreBase with Store {

  _CategoryStoreBase(){
    _loadCategories();
  }

  ObservableList<Category> categoryList = ObservableList();

  @observable
  String error = '';

  @computed
  List<Category> get allCategoryList => List.from(categoryList)
    ..insert(0, Category(description: 'Todas', id: '*'));


  @action
  void setCategories(List<Category> categories){
    categoryList.clear();
    categoryList.addAll(categories);
  }

  @action
  void setError(String value) => error = value;

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryRepository().getList();
      setCategories(categories);
    } catch (e) {
      setError(e.toString());
    }
    
  }
  
}