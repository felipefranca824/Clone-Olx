import 'package:mobx/mobx.dart';
import 'package:clone_olx/helpers/extensions.dart';
part 'signup_store.g.dart';


class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  
  @observable
  String ?name;

  @observable
  String ?email;

  @observable
  String ?phone;

  @observable
  String ?password;

  @observable
  String ?confirmedPassword;

  @observable
  bool loading = false;

  @action
  void setName(String value) => name = value;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPhone(String value) => phone = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void setConfirmedPassword(String value) => confirmedPassword = value;

  @action
  void setLoading(bool value) => loading = value;

  @computed
  bool get nameValid => this.name != null && this.name!.length > 6;
  get nameError{
    if(this.name == null || nameValid)
      return null;
    else if(this.name!.isEmpty)
      return 'Campo Obrigatótio';
    else
      return 'Nome muito curto';
      
  }

  @computed
  bool get emailValid => email != null && this.email!.isEmailValid();
  get emailError {
    if(email == null || emailValid)
      return null;
    else if(email!.isEmpty)
      return 'Campo Obrigatório';
    else
      return 'Email Inválido';
  }

  @computed
  bool get phoneValid => phone != null && this.phone!.length >= 14;
  get phoneError {
    if(phone == null || phoneValid)
      return null;
    else if(phone!.isEmpty)
      return 'Campo Obrigatório';
    else
      return 'Telefone Inválido';
  }

  @computed
  bool get passwordValid => this.password != null && this.password!.length >= 6;
  get passwordError{
    if(this.password == null || passwordValid)
      return null;
    else if(this.password!.isEmpty)
      return 'Campo Obrigatótio';
    else
      return 'Senha muito curta';
      
  }

  @computed
  bool get confirmedPasswordValid => this.confirmedPassword != null && this.confirmedPassword == this.password;
  get confirmedPasswordError{
    if(this.confirmedPassword == null || confirmedPasswordValid)
      return null;
    else
      return 'Senhas não coincidem';
      
  }

  @computed
  bool get isFormValid => nameValid && emailValid && phoneValid && passwordValid && confirmedPasswordValid;

  @computed
  get signUpPressed => (isFormValid && !loading) ? _signUp : null;

  Future<void> _signUp() async {
    print(isFormValid);
    setLoading(true);
    await Future.delayed(Duration(seconds: 3));
    setLoading(false);    
  }

}