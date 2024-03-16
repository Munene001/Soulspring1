import 'package:flutter/material.dart';

class Therapist extends StatelessWidget {
  const Therapist({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(430),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: AppBar(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(72, 0, 0, 0),
                child: Text(
                  'Therapist',
                  style:
                      TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              ),
              backgroundColor: Colors.grey[200],
              flexibleSpace: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                        
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
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 120, 0, 0),
                      child: Column(
                        children: [
                          Material(
                            elevation: 8,
                            clipBehavior: Clip.antiAlias,
                            shape: CircleBorder(
                                side: BorderSide(
                              color: Colors.blue,
                              width: 3.0,
                            )),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://plus.unsplash.com/premium_photo-1705091980967-c21193be0dd3?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              ),
                              radius: 80,
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            'Jenice Akinyi',
                            style:
                                TextStyle(fontSize: 24, color: Colors.brown[900]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Nairobi',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.brown,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(92, 0, 0, 0),
                            child: Row(
                              children: [
                                Chip(
                                  label: Text('Consult'),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
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
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Myprofile(),
      );
  }
}

class Myprofile extends StatelessWidget {
  const Myprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),),
      
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
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 10,),
                ListTile(
                  leading:Icon(Icons.ac_unit_outlined) ,
                  shape: Border(),

                  title: Text('Description', style: TextStyle(color: Colors.white)),
                  subtitle:
                      Text('Description', style: TextStyle(color: Colors.white)),
                  contentPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading:Icon(Icons.ac_unit_outlined) ,
                  shape: Border(),
                  title: Text('Description', style: TextStyle(color: Colors.white)),
                  subtitle:
                      Text('Description', style: TextStyle(color: Colors.white)),
                  contentPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 10,),
                ListTile(
                  leading:Icon(Icons.ac_unit_outlined) ,
                  shape: Border(),
                  title: Text('Description', style: TextStyle(color: Colors.white)),
                  subtitle:
                      Text('Description', style: TextStyle(color: Colors.white)),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        
      ),
    );
  }
}
