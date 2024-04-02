import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  Future<void> _login(BuildContext context) async {
    final url = Uri.parse('http://192.168.0.108:3000/api/login');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': _emailTextController.text,
        'password': _passwordTextController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      print('Failed to login: ${response.statusCode}');
    }
  }

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
                child: ReusableTextField(
                    'enter email', false, Icons.email, _emailTextController),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: ReusableTextField('enter password', true,
                    Icons.password_outlined, _passwordTextController),
              ),
              SizedBox(
                height: 13,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: loginButton(true, () {
                  _login(context);
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
