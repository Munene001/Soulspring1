import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<List<dynamic>> searchData;
  List<dynamic> originalData = [];

  @override
  void initState() {
    super.initState();
    searchData = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.0.104:3000/api/data'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        originalData = jsonData;
        return jsonData;
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during HTTP request: $error');
      throw Exception('Error during HTTP request: $error');
    }
  }

  List<dynamic> filterData(String query) {
    return originalData.where((item) {
      return item.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          onChanged: (query) {
            setState(() {
              searchData = Future.value(filterData(query));
            });
          },
          decoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Enter Keywords...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      FutureBuilder<List<dynamic>>(
        future: searchData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SizedBox(
              height: 640,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return ListTile(
                    title: Text('Data: $item'),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text('No data available.'),
            );
          }
        },
      )
    ]));
  }
}
