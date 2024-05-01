import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search.dart';
import 'login.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
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

class Content extends StatelessWidget {
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
        backgroundColor: Colors.grey.withOpacity(0.1),
      ),
      body: Container(
        
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'HOW ARE YOU DOING ?',
              style: TextStyle(fontSize: 35, color: Colors.green),
            ),
            SizedBox(
              height: 5
            ),
            EmojiFeedback(
              animDuration: const Duration(milliseconds: 300),
              curve: Curves.bounceIn,
              inactiveElementScale: .8,
              onChanged: (value) {
                print(value);
              },
            )
          ],
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
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
      ),
    );
  }

  Widget _buildPageForIndex(int index) {
    switch (index) {
      case 0:
        return Content();
      case 1:
        return Search(userEmail: widget.userEmail);
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
