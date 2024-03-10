
import 'package:flutter/material.dart';

class Therapist extends StatelessWidget {
  const Therapist({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(380),
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
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color.fromARGB(255, 27, 94, 32),
                      Colors.green,
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
                      Text('Jenice Akinyi',style: TextStyle(
                        fontSize: 20, color: Colors.brown[900]
                      ),),
                      SizedBox(
                        height: 3,
                      ),
                      Text('Nairobi',style: TextStyle(
                        fontSize: 15, color: Colors.brown,
                      ),),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(92, 0, 0, 0),
                        child: Row(
                        
                        children: [
                          Chip(label: Text('Consult'),
                          
                          avatar:CircleAvatar(
                            backgroundColor: Colors.green,
                            
                            child: Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                               size: 15,
                              
                                    
                            ),
                                    
                          ) ,),
                          SizedBox( width: 10,),
                          Chip(label: Text('Follow'),
                          avatar:CircleAvatar(
                            backgroundColor: Colors.green,
                            
                            
                            child: Icon(
                              Icons.person_add,
                              color: Colors.white,
                              size: 13,
                            ),
                                    
                          ) ,),
                          
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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          
        ),
        
          
            
              child: Myprofile()
            ),
          
        
      );
  }
}
class Myprofile extends StatelessWidget {
  const Myprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      

      
    );
  }
}
