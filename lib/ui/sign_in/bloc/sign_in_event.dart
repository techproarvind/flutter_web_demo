abstract class SignInEvent {}

class SignInValidationEvent extends SignInEvent {
  final String emailValue;
  final String passwordValue;

  SignInValidationEvent(this.emailValue, this.passwordValue);
}

class SignInOnSubmitEvent extends SignInEvent {
  final String email;
  final String password;
  SignInOnSubmitEvent(this.email, this.password);
}

class SignInLoadingEvent extends SignInEvent {}

class SignInSuccessEvent extends SignInEvent {
  final String successMessage;

  SignInSuccessEvent(this.successMessage);
}
