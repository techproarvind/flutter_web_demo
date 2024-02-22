import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/ui/sign_in/bloc/sign_in_event.dart';
import 'package:internet_connection/ui/sign_in/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>{
  SignInBloc()  : super(SignInInitialState()){

    on<SignInValidationEvent>((event, emit) {
      if(EmailValidator.validate(event.emailValue) == false){
        emit(SignInErrorState("Please enter valid Email Id"));
      }else if(event.passwordValue.isEmpty || event.passwordValue.length < 7){
        emit(SignInErrorState("Please enter valid Password"));
      }else{
        emit(SignInValidState());
      }
    });

    on<SignInOnSubmitEvent>((event, emit) {
      emit(SignInLoadingState());
      if(event.password == "1234567"){
        emit(SignInSuccessState("Success"));
      }else{
        emit(SignInErrorSubmitState("Password Not match"));
      }
    });

  }

}