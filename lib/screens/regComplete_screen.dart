import 'package:flutter/material.dart';
import 'package:chat_app/rounded_Button.dart';
import 'login_screen.dart';


class RegistrationComplete extends StatefulWidget {
  static const String id =  '/registrationComplete_screen';

  @override
  State<RegistrationComplete> createState() => _RegistrationCompleteState();
}

class _RegistrationCompleteState extends State<RegistrationComplete> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            Text('Registration Complete'),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                colour: Colors.blueGrey,
                buttonText: 'Proceed to login',
                onPressed: (){
                  Navigator.pushNamed(context, LoginScreen.id);
                }
                )
          ],
        ),
      ),
    );
  }
}



