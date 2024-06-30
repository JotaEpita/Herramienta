import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/img/yo.jpg'), // Reemplaza con tu foto
            ),
            SizedBox(height: 20),
            Text(
              'Jose Luis Acevedo Mendez',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Desarrollador de aplicaciones móviles',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('joseluis023.m@gmail.com'), // Reemplaza con tu correo electrónico
                onTap: () {
                  // Implementa la acción para enviar un correo electrónico
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text('+1 809 458 9453'), // Reemplaza con tu número de teléfono
                onTap: () {
                  // Implementa la acción para llamar al número de teléfono
                },
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                leading: Icon(Icons.web),
                title: Text('www.linkedin.com/in/josé-luis-acevedo-méndez-94ba8a245'), // Reemplaza con tu sitio web
                onTap: () {
                  // Implementa la acción para abrir tu sitio web
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
