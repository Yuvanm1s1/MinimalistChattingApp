import 'package:flutter/material.dart';
import 'package:minimalchatapp/auth/auth_service.dart';
import 'package:minimalchatapp/components/my_button.dart';
import 'package:minimalchatapp/components/my_textfield.dart';
import 'register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget{

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  void Function()? onTap;
  LoginPage({super.key});
  Future<void> login(BuildContext context) async {
    //getauth service
    final authService = AuthService();
    try{
      await authService.signInWithEmailPassword(_emailcontroller.text, _passwordcontroller.text);
    }
    
    catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title:Text(e.toString()),
      ) );
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(Icons.message,
              size: 60,
              color:Theme.of(context).colorScheme.primary,
              ),
              SizedBox(
                height: 50.0,
              ),
              //welcome meg
              Text("WELCOME back , you've been missed",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize:16.0,
              ),),
              SizedBox(
                height: 50.0,
              ),
              //emai text
              MyTextField(hintText: "Email", obscureText: false, controller: _emailcontroller,),
              SizedBox(
                height: 10.0,
              ),
              //pass text
              MyTextField(hintText: "Password", obscureText: true, controller: _passwordcontroller,),
              SizedBox(
                height: 50.0,
              ),
              //login button
              MyButton(text: 'Log In',
                onTap:() => login(context),
              ),
              SizedBox(
                height: 50.0,
              ),
              //regiister button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  RegisterPage()),
                      );
                    },
                    child: Text("Register ",
                      style: TextStyle(fontWeight:FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}