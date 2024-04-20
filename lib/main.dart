import 'package:flutter/material.dart';
import 'package:minimalchatapp/auth/auth_gate.dart';
import 'package:minimalchatapp/firebase_options.dart';
import 'package:minimalchatapp/pages/register_page.dart';
import 'package:minimalchatapp/themes/light_mode.dart';
import 'package:minimalchatapp/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (context) => ThemeProvider(),
        child:  const MyApp()),

  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}