import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'search.dart';
import 'login.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'log.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Soulspring App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green,
              primary: Colors.green,
              secondary: Colors.deepOrange),
        ),
        home: Login(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

class Content extends StatefulWidget {
  final String userEmail;
  const Content({super.key, required this.userEmail});
  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  List<String> selectedItems = [];
  String? _emoji;
  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().substring(0, 10);
      });
    }
  }

  Future<void> _moodLog(BuildContext context) async {
    if (_dateController.text.isEmpty || _textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(Icons.thumb_down, color: Colors.deepOrange),
            SizedBox(width: 30),
            Text("Neither Date nor Written Diary can be empty")
          ],
        ),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.black.withOpacity(0.5),
      ));
      return;
    }
    DateTime parsedDate = DateTime.parse(_dateController.text);
  String formattedDate = "${parsedDate.year}-${parsedDate.month}-${parsedDate.day}";
    final url = Uri.parse("http://192.168.0.106:3000/api/log");
    final response = await http.post(url,
        body: jsonEncode({
          'journal': _textController.text,
          'date': formattedDate,
          'emoji': _emoji,
          'choice': selectedItems,
          'email': widget.userEmail
        }),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      setState(() {
        _textController.clear();
        selectedItems.clear();
        _emoji = null;
      });
    } else {
      debugPrint("failed to log mood:${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Mood Journal',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 35,
        backgroundColor: Colors.green[50]?.withOpacity(0.6),
      ),
      body: Container(
        color: Colors.green[50],
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'HOW ARE YOU FEELING?',
                style: TextStyle(fontSize: 35, color: Colors.blueGrey),
              ),
              SizedBox(height: 5),
              EmojiFeedback(
                animDuration: const Duration(milliseconds: 300),
                curve: Curves.bounceIn,
                inactiveElementScale: .8,
                onChanged: (value) {
                  setState(() {
                    _emoji = value.toString();
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What is affecting your mood?',
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: MygridView(
                  selectedItems: selectedItems,
                  onSelectedItemsChanged: (value) {
                    setState(() {
                      selectedItems = value;
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Let's write about it",
                      style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Container(
                      width: 170,
                      child: TextField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.deepOrange,
                          ),
                          labelText: 'Date',
                          alignLabelWithHint: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  scrollPadding: EdgeInsets.only(top: 1500),
                  decoration: InputDecoration(
                      hintText: 'Write here ---',
                      hintStyle: TextStyle(color: Colors.green),
                      prefixIcon: Icon(
                        Icons.book_outlined,
                        color: Colors.deepOrange,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(5),
                            right: Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            color: Colors.green,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 45.0, horizontal: 10.0)),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    _moodLog(context);
                  },
                  child: Text("Log Today's Mood"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String userEmail;

  const MyHomePage({
    super.key,
    required this.userEmail,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildPageForIndex(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Logs')
        ],
      ),
    );
  }

  Widget _buildPageForIndex(int index) {
    switch (index) {
      case 0:
        return Content(userEmail: widget.userEmail);
      case 1:
        return Search(userEmail: widget.userEmail);
      case 2:
        return Logs();
      // Add more cases as needed for additional icons
      // case 2:
      //   return SomeWidget();
      // case 3:
      //   return AnotherWidget();
      default:
        throw UnimplementedError('No widget for index $index');
    }
  }
}

class MygridView extends StatefulWidget {
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectedItemsChanged;

  const MygridView({
    super.key,
    required this.selectedItems,
    required this.onSelectedItemsChanged,
  });

  @override
  State<MygridView> createState() => _MygridViewState();
}

class _MygridViewState extends State<MygridView> {
  final List<String> items = [
    'Family',
    'Work',
    'Relationship',
    'Weather',
    'Health',
    'Travel',
    'Finances',
    'Exercise',
    'Food',
    'Hobbies',
    'Sleep',
    'Commitments',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2,
      children: List.generate(items.length, (index) {
        final isSelected = widget.selectedItems.contains(items[index]);
        return InkWell(
          onTap: () {
            setState(
              () {
                if (isSelected) {
                  widget.selectedItems.remove(items[index]);
                } else {
                  widget.selectedItems.add(items[index]);
                }
                widget.onSelectedItemsChanged(widget.selectedItems);
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20),
                ),
                border: Border.all(color: Colors.green)),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.deepOrange.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(30),
                  right: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  items[index],
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
