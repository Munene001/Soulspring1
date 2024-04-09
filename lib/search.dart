import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'therapist.dart';

class Search extends StatefulWidget {
final String userEmail;
  const Search({Key? key, required this.userEmail}) : super(key: key);

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
          await http.get(Uri.parse('http://192.168.167.85:3000/api/data'));

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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Filter",
                  style: TextStyle(color:Colors.green, fontSize: 12),
                ),
                IconButton(
                  onPressed: toggleVisibility,
                  icon: Icon(Icons.filter_list, color:Colors.deepOrange[300]),
                ),
                // Adjust the height as needed
              ],
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
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListWidget(
                        item: item,
                        userEmail: widget.userEmail,
                      ),
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
   final String userEmail;

  


  const ListWidget({
    Key? key,
    required this.item,
    required this.userEmail
   
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Colors.green.withOpacity(0.1)),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange[300],
        radius: 5,
      ),
      title: Text(' ${item['first_name']} ${item['last_name']} '),
      subtitle: Text(' ${item['speciality']}'),
      trailing: Icon(Icons.arrow_forward, color:Colors.green ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Therapist(item:item,userEmail:userEmail),
          ),
        );

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
  final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.green[600],
    foregroundColor: Colors.white,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );

  FilterButtons({
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
            ElevatedButton(
              onPressed: onMalePressed,
              style: customButtonStyle,
              child: Text("Male"),
            ),
            ElevatedButton(
              onPressed: onFemalePressed,
              style: customButtonStyle,
              child: Text(
                "Female",
              ),
            ),
            ElevatedButton(
              onPressed: onNairobiPressed,
              style: customButtonStyle,
              child: Text("Nairobi"),
            ),
            ElevatedButton(
              onPressed: onMombasaPressed,
              style: customButtonStyle,
              child: Text("Mombasa"),
            ),
            ElevatedButton(
              onPressed: onKisumuPressed,
              style: customButtonStyle,
              child: Text("Kisumu"),
            ),
            ElevatedButton(
              onPressed: onNakuruPressed,
              style: customButtonStyle,
              child: Text("Nakuru"),
            ),
            ElevatedButton(
              onPressed: onEldoretPressed,
              style: customButtonStyle,
              child: Text("Eldoret"),
            ),
          ],
        ),
      ),
    );
  }
}
