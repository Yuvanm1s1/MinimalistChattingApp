import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimalchatapp/auth/auth_service.dart';
import 'package:minimalchatapp/components/chat_bubble.dart';
import 'package:minimalchatapp/components/my_textfield.dart';
import 'package:minimalchatapp/services/chat/chat_service.dart';
class ChatPage extends StatelessWidget {
   ChatPage({super.key, required this.recieverEmail, required this.recieverID});
  final String recieverEmail;
  final String recieverID;
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService =AuthService();

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(recieverID, _messageController.text);
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
      ),
      body: Column(
        children: [
          //display message
          Expanded(child: _buildMessageList(),),
          //display input
          _buildUserInput(),
        ],
      ),
    );
  }
  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessage(recieverID, senderID), builder: (context,snapshot){
      //errors
      if(snapshot.hasError){
        return const Text("Error");
      }
      // loading
      if(snapshot.connectionState==ConnectionState.waiting){
        return const Text("Loading");
      }
      //return list view
      return ListView(
          children: snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
      );
    });
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment  = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;




    return Container(alignment:alignment,
        child: ChatBubble(message: data["message"], isCurrentUSer: isCurrentUser,));
  }

  Widget _buildUserInput(){
      return Row(
        children: [
          Expanded(child: MyTextField(
            controller: _messageController,
            hintText: "Type a message",
            obscureText: false,
          )),
          IconButton(onPressed:sendMessage, icon: Icon(Icons.send))

        ],
      );
  }
}
