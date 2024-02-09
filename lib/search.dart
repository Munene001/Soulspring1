import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<List<Map<String, dynamic>>> searchData;
  List<Map<String, dynamic>> originalData = [];

  @override
  void initState() {
    super.initState();
    searchData = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.0.105:3000/api/data'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Map<String, dynamic>> mappedData = jsonData.cast<Map<String, dynamic>>();
        originalData = mappedData;
        return mappedData;
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

  List<Map<String, dynamic>> filterData(String query) {
    return originalData.where((item) {
      return item.values.any((value) {
        if (value is String) {
          return value.toLowerCase().contains(query.toLowerCase());
        }
        return false;
      });
    }).toList();
  }

  List<Map<String, dynamic>> filterDataByGender(String gender) {
    return originalData.where((item) => item['gender'] == gender).toList();
  }

  List<Map<String, dynamic>> applyFilters(String query, String genderFilter) {
    List<Map<String, dynamic>> filteredData = originalData;
    if (genderFilter.isNotEmpty) {
      filteredData = filterDataByGender(genderFilter);
    }
    if (query.isNotEmpty) {
      filteredData = filterData(query);
    }
    
    return filteredData;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchData = Future.value(filterDataByGender('Male'));
                    });
                  },
                  child: Text('Male'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      searchData = Future.value(filterDataByGender('Female'));
                    });
                  },
                  child: Text('Female'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  searchData = Future.value(applyFilters(query, ''));
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter Keywords...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
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
                        title: Text('Name: ${item['first_name']}'),
                        subtitle: Text('Gender: ${item['gender']}'),
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
        ],
      ),
    );
  }
}
