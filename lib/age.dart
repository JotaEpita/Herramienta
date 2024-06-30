import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AgePage extends StatefulWidget {
  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  TextEditingController _nameController = TextEditingController();
  int _age = 0;
  String _ageGroup = '';
  bool _isLoading = false;

  Future<void> _predictAge(String name) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _age = data['age'];
        _isLoading = false;
        _setAgeGroup();
      });
    } else {
      setState(() {
        _age = 0;
        _ageGroup = '';
        _isLoading = false;
      });
      print('Error al determinar la edad.');
    }
  }

  void _setAgeGroup() {
    if (_age <= 25) {
      _ageGroup = 'Joven';
    } else if (_age <= 60) {
      _ageGroup = 'Adulto';
    } else {
      _ageGroup = 'Anciano';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determinar Edad'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Ingrese un nombre',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text.trim();
                if (name.isNotEmpty) {
                  _predictAge(name);
                }
              },
              child: Text('Determinar Edad'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _age == 0
                    ? SizedBox()
                    : Column(
                        children: [
                          Text(
                            'Edad estimada: $_age años',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Grupo de edad: $_ageGroup',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          _ageGroup == 'Joven'
                              ? Image.asset(
                                  'assets/img/joven.jpg',
                                  width: 100,
                                  height: 100,
                                )
                              : _ageGroup == 'Adulto'
                                  ? Image.asset(
                                      'assets/img/adulto.jpg',
                                      width: 100,
                                      height: 100,
                                    )
                                  : Image.asset(
                                      'assets/img/anciano.jpeg',
                                      width: 100,
                                      height: 100,
                                    ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
