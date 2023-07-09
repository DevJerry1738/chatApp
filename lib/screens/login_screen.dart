import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/rounded_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  bool showSPinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSPinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  style: TextStyle(
                      color: Colors.black
                  ),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  buttonText: 'Login',
                  onPressed: (){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  // onPressed: ()async{
                  //   setState(() {
                  //     showSPinner=true;
                  //   });
                  //   try{
                  //     final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  //     if(user!= null){
                  //       Navigator.pushNamed(context, ChatScreen.id);
                  //     }
                  //     setState(() {
                  //       showSPinner=false;
                  //     });
                  //   }catch(e){
                  //     print(e);
                  //   }
                  //
                  // },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
