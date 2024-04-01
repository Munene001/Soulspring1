import 'package:flutter/material.dart';
import 'package:namer_app/login.dart';
import 'Reusableloginwidget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _usernameTextController = TextEditingController();
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
                child: reusableTextField('enter firstname', false,
                    Icons.person_2_outlined, _usernameTextController),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: reusableTextField('enter lastname', false,
                    Icons.person_2_outlined, _usernameTextController),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: reusableTextField('enter email', false,
                    Icons.email_rounded, _emailTextController),
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
                child: loginButton(false, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
