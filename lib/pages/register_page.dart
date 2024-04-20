import 'package:flutter/material.dart';
import 'package:minimalchatapp/auth/auth_service.dart';
import 'package:minimalchatapp/components/my_button.dart';
import 'package:minimalchatapp/components/my_textfield.dart';
import 'login_page.dart';
class RegisterPage extends StatelessWidget{
  void Function()? onTap;
  RegisterPage({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();

  Future<void> register(BuildContext context) async {
    //getauth service
    final authService = AuthService();
    if(_passwordcontroller.text == _confirmpasswordcontroller.text){
      try{
        await authService.signUpWithEmailPassword(_emailcontroller.text, _passwordcontroller.text);
      }

      catch(e){
        showDialog(context: context, builder: (context) => AlertDialog(
          title:Text(e.toString()),
        ) );
      }
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Passwords don't match!"),
          );
        },
      );
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
              Text("Happy to start a journey with you",
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
                height: 10.0,
              ),
              //confirm password
              MyTextField(hintText: "Confirm Password", obscureText: true, controller: _confirmpasswordcontroller,),
              SizedBox(
                height: 20.0,
              ),
              //register button
              MyButton(text: 'Register',onTap: () => register(context),),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  GestureDetector(
                    onTap:  () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  LoginPage()),
        );
        },
                    child: Text("Login ",
                      style: TextStyle(fontWeight:FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}