import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id ='/chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  late String messageText;
  final _auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
    final user = _auth.currentUser;
    try{
      if(user!=null){
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }catch(e){
      print(e);
    }
  }

  void messageStream()async{
    await for (var snapshot in _fireStore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                // _auth.signOut();
                // Navigator.pushNamed(context, WelcomeScreen.id);
                messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _fireStore.collection('messages').add({
                        'text':messageText,
                        'sender':loggedInUser.email,
                        'timeStamp': Timestamp.now(),
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fireStore.collection('messages').orderBy('timeStamp',descending: true).snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(),);
        }
        final messages = snapshot.data?.docs;

        for (var message in messages!) {
          final data = message.data() as Map;
          final messageText = data['text'];
          final messageSender = data['sender'];
          final currentUser = loggedInUser.email;



          final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe:currentUser == messageSender ,
          );
          messageBubbles.add(messageBubble);

        }

        return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              children: messageBubbles,
            )
        );
      },
    );
  }
}


class MessageBubble extends StatelessWidget {

  MessageBubble({required this.sender,required this.text, required this.isMe});

  late final String sender;
  late  final String text;
  late final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(sender,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white54
          ),),
          Material(
              borderRadius:isMe? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight:Radius.circular(30.0) ):BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight:Radius.circular(30.0) ),
              elevation: 5.0,
              color:isMe? Colors.blueGrey.shade400 : Colors.lightBlueAccent,
              child: Padding(
                padding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  '$text' ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0),),
              ),),

        ],
      ),
    );

  }
}

