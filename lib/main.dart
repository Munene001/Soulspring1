import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.
  key});

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
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    List<WordPair> favorites = [];
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('A random idea:'),
        Bigcard(pair: pair),
        SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {
                  appState.toggleFavorite();
                },
                child: Text('Like')),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text("Next"),
            ),
          ],
        ),
      ],
    );
  }
}

class Bigcard extends StatelessWidget {
  const Bigcard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: Colors.deepOrange.shade300,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(pair.asLowerCase,
            style: style, semanticsLabel: "${pair.first} ${pair.second}"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
        return Search();
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
