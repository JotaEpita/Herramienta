import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool _isLoading = true;
  String? _temperature;
  String? _description;
  String? _location = "Santo Domingo";

  Future<void> _fetchWeather() async {
    final response = await http.get(
      Uri.parse('https://wttr.in/Santo%20Domingo?format=j1'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _temperature = data['current_condition'][0]['temp_C'].toString();
        _description = data['current_condition'][0]['weatherDesc'][0]['value'];
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Error al cargar el clima.');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en Santo Domingo'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _temperature == null
                ? Text('Error al cargar el clima.')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Ubicación: $_location',
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Temperatura: $_temperature°C',
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Descripción: $_description',
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
      ),
    );
  }
}
