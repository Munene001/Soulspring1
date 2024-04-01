import 'package:flutter/material.dart';
import 'package:namer_app/Reusableloginwidget.dart';
import 'package:namer_app/main.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 27, 94, 32).withOpacity(0.9),
                Colors.green.withOpacity(0.9),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: reusableTextField(
                    'enter email', false, Icons.email, _emailTextController),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: reusableTextField('enter password', true,
                    Icons.password_outlined, _passwordTextController),
              ),
              SizedBox(
                height: 13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: loginButton(true, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                }),
              ),
              SizedBox(height: 7),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 90.0),
                child: signupField(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget signupField(BuildContext context) {
  return Row(
    children: [
      Text(
        "Don't have an account?|",
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Signup()));
        },
        child: Text("Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
      )
    ],
  );
}
