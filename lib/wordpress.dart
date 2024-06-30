import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WordPressPage extends StatefulWidget {
  @override
  _WordPressPageState createState() => _WordPressPageState();
}

class _WordPressPageState extends State<WordPressPage> {
  List<dynamic> _newsList = [];
  bool _isLoading = true;

  Future<void> _fetchWordPressNews() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('https://newsroom.spotify.com/wp-json/wp/v2/posts?per_page=3'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _newsList = data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _newsList = [];
        _isLoading = false;
      });
      print('Error al cargar noticias de WordPress.');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWordPressNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de WordPress'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _newsList.isEmpty
              ? Center(child: Text('No se encontraron noticias'))
              : ListView.builder(
                  itemCount: _newsList.length,
                  itemBuilder: (context, index) {
                    var news = _newsList[index];
                    return ListTile(
                      title: Text(news['title']['rendered']),
                      subtitle: Text(news['excerpt']['rendered']),
                      onTap: () {
                        // Implementar acción para abrir la noticia completa
                        // Esto podría ser abrir un navegador o cargar más detalles en otra pantalla
                        print('Abrir noticia: ${news['link']}');
                      },
                    );
                  },
                ),
    );
  }
}
