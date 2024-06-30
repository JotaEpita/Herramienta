import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UniversityPage extends StatefulWidget {
  @override
  _UniversityPageState createState() => _UniversityPageState();
}

class _UniversityPageState extends State<UniversityPage> {
  TextEditingController _countryController = TextEditingController();
  List<dynamic> _universities = [];
  bool _isLoading = false;

  Future<void> _fetchUniversities(String countryName) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=$countryName'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _universities = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _universities = [];
        _isLoading = false;
      });
      print('Error al cargar universidades.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades por País'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'Ingrese un país',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String country = _countryController.text.trim();
                if (country.isNotEmpty) {
                  _fetchUniversities(country);
                }
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _universities.isEmpty
                    ? SizedBox()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _universities.length,
                          itemBuilder: (context, index) {
                            var university = _universities[index];
                            return ListTile(
                              title: Text(university['name']),
                              subtitle: Text(university['country']),
                              onTap: () {
                                // Implementar acción al seleccionar una universidad si deseas
                              },
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
