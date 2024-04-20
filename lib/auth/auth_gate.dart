import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimalchatapp/pages/home_page.dart';
import 'package:minimalchatapp/pages/login_page.dart';
import 'package:minimalchatapp/pages/register_page.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
//constantly listening to auth state changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot){
          // logged in
          if(snapshot.hasData){
            return  HomePage();
          }
          //logged out
          else{
            return RegisterPage();
          }
        },
      ),
    );
  }
}
