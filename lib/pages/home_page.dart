import 'package:flutter/material.dart';
import 'package:minimalchatapp/auth/auth_service.dart';
import 'package:minimalchatapp/components/my_drawer.dart';
import 'package:minimalchatapp/components/user_tile.dart';
import 'package:minimalchatapp/pages/chat_page.dart';
import 'package:minimalchatapp/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() {
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }




  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if(userData["email"]!= _authService.getCurrentUser()!.email){
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage(recieverEmail: userData["email"], recieverID: userData["uid"],)),
          );
        },
      );
    }
    else {
      return Container();
    }
  }
}
