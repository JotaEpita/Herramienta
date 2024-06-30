import 'package:flutter/material.dart';
import 'gender.dart';
import 'age.dart';
import 'university.dart';
import 'wordpress.dart';
import 'weather.dart';
import 'about.dart'; // Asegúrate de tener el archivo about.dart correctamente implementado

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Herramienta App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/gender': (context) => GenderPage(),
        '/age': (context) => AgePage(),
        '/university': (context) => UniversityPage(),
        '/wordpress': (context) => WordPressPage(),
        '/weather': (context) => WeatherPage(),
        '/about': (context) => AboutPage(), // Ruta hacia la página "Acerca de"
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caja de Herramientas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/img/caja.jpg',
              width: 300,
            ),
            SizedBox(height: 20),
            Text(
              'Esta aplicación sirve para varias cosas',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              alignment: WrapAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/gender');
                  },
                  child: Text('Predicción de Género'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/age');
                  },
                  child: Text('Determinar Edad'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/university');
                  },
                  child: Text('Universidades por País'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/wordpress');
                  },
                  child: Text('Noticias WordPress'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/weather');
                  },
                  child: Text('Clima en Santo Domingo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  child: Text('Acerca de'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
