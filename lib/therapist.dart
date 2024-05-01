import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Therapist extends StatefulWidget {
  final Map<String, dynamic> item;
  final String userEmail;


  const Therapist({Key? key, required this.item, required this.userEmail});
  @override
  State<Therapist> createState() => _TherapistState();
}

class _TherapistState extends State<Therapist> {
  Future<void> sendemails() async {
    final String therapistEmail = widget.item['email'];
    final url = Uri.parse('http://192.168.0.106:3000/api/consult');

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'therapistEmail': therapistEmail,
          'userEmail': widget.userEmail,
          
        }));
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(Icons.thumb_up, color: Colors.deepOrange[300]),
            SizedBox(
              width: 30,
            ),
            Text(
                'Consultation applied Successfully,'),
          ],
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.black.withOpacity(0.5),
      ));
    }
    else if (response.statusCode == 401){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(Icons.thumb_down, color: Colors.deepOrange[300]),
            SizedBox(
              width: 30,
            ),
            Text(
                'User is not logged in'),
          ],
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.black.withOpacity(0.5),
      ));


    }
  }
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(430),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: AppBar(
            title: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(72, 0, 0, 0),
                    child: Text(
                      'Therapist', // Corrected the string interpolation
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.grey[200],
            flexibleSpace: Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color.fromARGB(255, 27, 94, 32).withOpacity(0.9),
                        Colors.green.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
                  child: Column(
                    children: [
                      Material(
                        elevation: 8,
                        clipBehavior: Clip.antiAlias,
                        shape: CircleBorder(
                            side: BorderSide(
                          color: Colors.deepOrange.shade300,
                          width: 3.0,
                        )),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('${widget.item['profileimage']}'),
                          radius: 80,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.item['first_name']} ${widget.item['last_name']}',
                        style:
                            TextStyle(fontSize: 24, color: Colors.brown[900]),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${widget.item['city']}',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(92, 0, 0, 0),
                        child: Row(
                          children: [
                            ChoiceChip(
                              label: Text('Consult'),
                              avatar: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              selected: selected,
                              onSelected: (isselected) {
                                if (isselected) {
                                  sendemails();
                                }
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Chip(
                                label: Text('Follow'),
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.person_add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                          thickness: 15,
                          indent: 50,
                          endIndent: 50,
                          color: Colors.green)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Myprofile(item: widget.item),
    );
  }
}

class Myprofile extends StatelessWidget {
  final Map<String, dynamic> item;

  const Myprofile({Key? key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color.fromARGB(255, 27, 94, 32).withOpacity(0.9),
                Colors.green.withOpacity(0.9),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 20),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading:
                    Icon(Icons.ac_unit_outlined, color: Colors.deepOrange[300]),
                shape: Border(),
                title: Text('Jobtitle',
                    style: TextStyle(color: Colors.deepOrange[300])),
                subtitle: Text('${item['speciality']}',
                    style: TextStyle(color: Colors.white)),
                contentPadding: EdgeInsets.zero,
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.deepOrange[300],
                ),
                shape: Border(),
                title: Text('About',
                    style: TextStyle(color: Colors.deepOrange[300])),
                subtitle: Text('${item['description']}',
                    style: TextStyle(color: Colors.white)),
                contentPadding: EdgeInsets.zero,
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading:
                    Icon(Icons.ac_unit_outlined, color: Colors.deepOrange[300]),
                shape: Border(),
                title: Text('Contact',
                    style: TextStyle(color: Colors.deepOrange[300])),
                subtitle: Text('${item['email']}',
                    style: TextStyle(color: Colors.white)),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
