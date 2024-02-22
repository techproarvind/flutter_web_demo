import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection/ui/sign_in/bloc/sign_in_bloc.dart';
import 'package:internet_connection/ui/sign_in/bloc/sign_in_event.dart';
import 'package:internet_connection/ui/sign_in/bloc/sign_in_state.dart';

import '../user_page.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(state.errorMessage.toString(),
                    style: const TextStyle(
                        color: Colors.red
                    ),);
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 12,),
            TextField(
              controller: emailController,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInValidationEvent(
                    emailController.text, passwordController.text));
              },
              decoration: const InputDecoration(
                  hintText: "Enter Email"
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInValidationEvent(
                    emailController.text, passwordController.text));
              },
              decoration: const InputDecoration(
                  hintText: "Enter password"
              ),
            ),
            const SizedBox(height: 20,),
            BlocConsumer<SignInBloc, SignInState>(
                builder: (context, state) {
                  if(state is SignInLoadingState){
                    return const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }
                  return CupertinoButton(
                    color: state is SignInValidState ? Colors.blue : Colors.grey,
                    onPressed: () {
                      BlocProvider.of<SignInBloc>(context).add(SignInOnSubmitEvent(emailController.text,
                          passwordController.text));
                    }, child: const Text("Submit"),
                  );
                },
                listener: (context, state){
                  if(state is SignInSuccessState){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserPage()));
                  } else if(state is SignInErrorSubmitState){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error Login")));
                  }
                })

          ],
        ),
      ),
    );
  }
}
