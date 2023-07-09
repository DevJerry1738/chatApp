import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/rounded_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'regComplete_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id =  '/registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                    colour: Colors.blueAccent,
                    buttonText: 'Register',
                    onPressed: (){
                      Navigator.pushNamed(context, RegistrationComplete.id);
                    },
                    // onPressed: ()async{
                    //   setState(() {
                    //     showSPinner=true;
                    //   });
                    //   try{
                    //     final newUser =await _auth.createUserWithEmailAndPassword(
                    //       email: email,
                    //       password: password);
                    //     if(newUser!=null){
                    //       Navigator.pushNamed(context, RegistrationComplete.id);
                    //     }
                    //     setState(() {
                    //       showSPinner=false;
                    //     });
                    //
                    //     }catch(e){
                    //     print(e);
                    //   }
                    // }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
