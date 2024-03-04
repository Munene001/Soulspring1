import 'package:flutter/material.dart';

class Therapist extends StatelessWidget {
  const Therapist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(360),
          child: AppBar(
              title: Text('Therapist'),
              flexibleSpace: Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color.fromARGB(255, 27, 94, 32),
                            Colors.green
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: MediaQuery.of(context).size.width / 2 - 60,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipOval(
                        child: Image.network(
                          'https://plus.unsplash.com/premium_photo-1705091980967-c21193be0dd3?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.transparent,
            )
          ],
        ));
  }
}
