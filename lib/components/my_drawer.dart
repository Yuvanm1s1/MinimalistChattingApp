import 'package:flutter/material.dart';
import 'package:minimalchatapp/auth/auth_service.dart';
import 'package:minimalchatapp/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout(){
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:Theme.of(context).colorScheme.background ,
      child:  Column(
        children: [
          //logo
            DrawerHeader(child: Center(child: Icon(Icons.message,color: Theme.of(context).colorScheme.primary,size: 40.0,),)),
          //home list title
            GestureDetector(
              onTap: (){Navigator.pop(context);},
              child: ListTile(
                title: Text("H O M E"),
                leading: Icon(Icons.home),
              ),
            ),
          //settings
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>SettingsPage()
                ));},
              child: ListTile(
                title: Text("S E T T I N G S"),
                leading: Icon(Icons.settings),
              ),
            ),
          //logout
          GestureDetector(
            onTap: logout,
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
            ),
          ),
        ],
      )
    );
  }
}
