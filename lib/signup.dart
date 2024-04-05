import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:namer_app/main.dart';
import 'Reusableloginwidget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _firstNameTextController = TextEditingController();
  TextEditingController _lastNameTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  Future<void> _signup(BuildContext context) async {
    final url = Uri.parse('http://192.168.0.108:3000/api/signup');
    
    final response = await http.post(
      url,
      body: json.encode({
        'firstname': _firstNameTextController.text,
        'lastname': _lastNameTextController.text,
        'email': _emailTextController.text,
        'password': _passwordTextController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(Icons.thumb_up, color: Colors.deepOrange[300]),
            SizedBox(
              width: 30,
            ),
            Text('Signup Succesfull', style: TextStyle(color: Colors.green),)
          ],
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.black.withOpacity(0.5),

      ));
    } else {
      print('Failed to login: ${response.statusCode}');

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Text('Sign Up',style: TextStyle(color: Colors.white),),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 27, 94, 32).withOpacity(0.9),
                Colors.green.withOpacity(0.9),
            ])
          ),
        ),
      ),
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
                child: ReusableTextField('enter firstname', false,
                    Icons.person_2_outlined, _firstNameTextController),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: ReusableTextField('enter lastname', false,
                    Icons.person_2_outlined, _lastNameTextController),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: ReusableTextField('enter email', false,
                    Icons.email_rounded, _emailTextController),
                     
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
                child: loginButton(false, () {
                  _signup(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
