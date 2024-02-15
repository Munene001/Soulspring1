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
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    searchData = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.0.105:3000/api/data'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Map<String, dynamic>> mappedData =
            jsonData.cast<Map<String, dynamic>>();
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

  List<Map<String, dynamic>> filterDataByCity(String city) {
    return originalData.where((item) => item['city'] == city).toList();
  }

  List<Map<String, dynamic>> applyFilters(
      String query, String genderFilter, String cityFilter) {
    List<Map<String, dynamic>> filteredData = originalData;
    if (genderFilter.isNotEmpty) {
      filteredData = filterDataByGender(genderFilter);
    }
    if (cityFilter.isNotEmpty) {
      filteredData = filterDataByCity(cityFilter);
    }
    if (query.isNotEmpty) {
      filteredData = filterData(query);
    }

    return filteredData;
  }

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0),
                        bottomLeft: Radius.circular(60.0),
                        bottomRight: Radius.circular(60.0)),
                  ),
                  child: TextField(
                    onChanged: (query) {
                      setState(() {
                        searchData = Future.value(applyFilters(query, '', ''));
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter Keywords...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: toggleVisibility,
              icon: Icon(Icons.filter_list),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Map<String, dynamic>>>(
            future: searchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    final opacity = index.isOdd ? 0.2 : 0.1;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListWidget(item: item, opacity: opacity),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('No data available.'),
                );
              }
            },
          ),
          Positioned(
            top: 0,
            right: 0,
            child: FilterButtons(
              isVisible: isVisible,
              onFemalePressed: () {
                setState(() {
                  searchData = Future.value(filterDataByGender('Female'));
                });
              },
              onMalePressed: () {
                setState(() {
                  searchData = Future.value(filterDataByGender('Male'));
                });
              },
              onNairobiPressed: () {
                setState(() {
                  searchData = Future.value(filterDataByCity('Nairobi'));
                });
              },
              onMombasaPressed: () {
                setState(() {
                  searchData = Future.value(filterDataByCity('Mombasa'));
                });
              },
              onKisumuPressed: () {
                setState(() {
                  searchData = Future.value(filterDataByCity('Nakuru'));
                });
              },
              onNakuruPressed: () {
                setState(() {
                  searchData = Future.value(filterDataByCity('Kisumu'));
                });
              },
              onEldoretPressed: () {
                setState(() {
                  searchData = Future.value(filterDataByCity('Eldoret'));
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final double opacity;

  const ListWidget({Key? key, required this.item, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text('Name: ${item['first_name']}'),
      subtitle: Text('Gender: ${item['gender']}'),
      tileColor: Colors.brown[300]?.withOpacity(opacity),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        // Handle onTap action here
      },
    );
  }
}

class FilterButtons extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onMalePressed;
  final VoidCallback onFemalePressed;
  final VoidCallback onNairobiPressed;
  final VoidCallback onMombasaPressed;
  final VoidCallback onKisumuPressed;
  final VoidCallback onNakuruPressed;
  final VoidCallback onEldoretPressed;

  const FilterButtons({
    Key? key,
    required this.isVisible,
    required this.onMalePressed,
    required this.onFemalePressed,
    required this.onNairobiPressed,
    required this.onMombasaPressed,
    required this.onKisumuPressed,
    required this.onNakuruPressed,
    required this.onEldoretPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(onPressed: onMalePressed, child: Text("Male")),
            ElevatedButton(onPressed: onFemalePressed, child: Text("Female")),
            ElevatedButton(onPressed: onNairobiPressed, child: Text("Nairobi")),
            ElevatedButton(onPressed: onMombasaPressed, child: Text("Mombasa")),
            ElevatedButton(onPressed: onKisumuPressed, child: Text("Kisumu")),
            ElevatedButton(onPressed: onNakuruPressed, child: Text("Nakuru")),
            ElevatedButton(onPressed: onEldoretPressed, child: Text("Eldoret")),
          ],
        ),
      ),
    );
  }
}
