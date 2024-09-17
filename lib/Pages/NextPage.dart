import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String _data = 'Cargando...';
  String _imageUrl = '';
  String _recipeInstructions = '';

  @override
  void initState() {
    super.initState();
    _fetchRandomMeal();
  }

  Future<void> _fetchRandomMeal() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['meals'] != null && jsonData['meals'].isNotEmpty) {
          final meal = jsonData['meals'][0];
          setState(() {
            _data = 'Nombre: ${meal['strMeal']}\n'
                'Categoría: ${meal['strCategory']}\n'
                'Área: ${meal['strArea']}\n';
            _imageUrl = meal['strMealThumb'];
            _recipeInstructions = meal['strInstructions'];
          });
        } else {
          setState(() {
            _data = 'No se encontraron datos de comida';
          });
        }
      } else {
        setState(() {
          _data = 'Error al cargar los datos: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _data = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comida Aleatoria', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20), 
              if (_imageUrl.isNotEmpty)
                Image.network(
                  _imageUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  _data,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              if (_recipeInstructions.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Instrucciones de preparación:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _recipeInstructions,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ElevatedButton(
                onPressed: _fetchRandomMeal,
                child: Text('Obtener otra comida'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}