import 'package:clone_olx/repository/user_repository.dart';
import 'package:clone_olx/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:clone_olx/helpers/extensions.dart';
part 'login_store.g.dart';


class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  bool loading = false;

  @observable
  String error = '';

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get emailValid => email != null && this.email!.isEmailValid();
  get emailError {
    if(email == null || emailValid)
      return null;
    else
      return 'Email Inválido';
  }

  @computed
  bool get passwordValid => this.password != null && this.password!.length >= 4;
  get passwordError{
    if(this.password == null || passwordValid)
      return null;
    else
      return 'Senha inválida';
      
  }

  @computed
  get loginPressed => emailValid && passwordValid && !loading ? _login : null;

  @action
  Future<void> _login() async {
    loading = true;
    try {
      final user = await UserRespository().loginWithEmail(email, password);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e.toString();
      print('Meu erro: ' + error);
    }
    

    loading = false;
  }
}
