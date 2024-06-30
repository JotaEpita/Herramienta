import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GenderPage extends StatefulWidget {
  @override
  _GenderPageState createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';
  bool _isLoading = false;

  Future<void> _predictGender(String name) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _gender = data['gender'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _gender = '';
        _isLoading = false;
      });
      print('Error al predecir el género.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
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
                  _predictGender(name);
                }
              },
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _gender.isEmpty
                    ? SizedBox()
                    : _gender.toLowerCase() == 'male'
                        ? Container(
                            width: 100,
                            height: 100,
                            color: Colors.blue,
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            color: Colors.pink,
                          ),
            SizedBox(height: 10),
            _gender.isEmpty
                ? SizedBox()
                : Text(
                    'Género predicho: $_gender',
                    style: TextStyle(fontSize: 18),
                  ),
          ],
        ),
      ),
    );
  }
}
