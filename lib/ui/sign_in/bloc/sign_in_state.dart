abstract class SignInState{}

class SignInInitialState extends SignInState{}

class SignInValidState extends SignInState{}

class SignInSubmitState extends SignInState{}
class SignInLoadingState extends SignInState{
}

class SignInSuccessState extends SignInState{
  final String successMessage;
  SignInSuccessState(this.successMessage);
}

class SignInErrorState extends SignInState{
  final String errorMessage;
  SignInErrorState(this.errorMessage);
}

class SignInErrorSubmitState extends SignInState{
  final String errorMessage;
  SignInErrorSubmitState(this.errorMessage);
}