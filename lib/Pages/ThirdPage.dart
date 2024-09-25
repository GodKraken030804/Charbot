import 'package:flutter/material.dart';


void main() => runApp(const ThirdPage());

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usuario',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[600],
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const PaginaComida(),
    );
  }
}

class PaginaComida extends StatefulWidget {
  const PaginaComida({super.key});

  @override
  _PaginaComidaState createState() => _PaginaComidaState();
}

class _PaginaComidaState extends State<PaginaComida> with SingleTickerProviderStateMixin {
  late TabController _controladorTab;
  final TextEditingController _controladorTexto = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controladorTab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controladorTab.dispose();
    _controladorTexto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App de Comida Aleatoria'),
        bottom: TabBar(
          controller: _controladorTab,
          tabs: const [
            Tab(icon: Icon(Icons.fastfood), text: 'Inicio'),
            Tab(icon: Icon(Icons.list), text: 'Categorías'),
            Tab(icon: Icon(Icons.settings), text: 'Configuración'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controladorTab,
        children: [
          _construirPestanaInicio(),
          _construirPestanaCategorias(),
          _construirPestanaConfiguracion(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: Colors.orange[800],
        unselectedItemColor: Colors.orange[300],
      ),
    );
  }

  Widget _construirPestanaInicio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 100, color: Colors.orange[600]),
          const SizedBox(height: 20),
          Text(
            '¡Bienvenido a la App de Comida Aleatoria!',
            style: TextStyle(fontSize: 24, color: Colors.orange[800]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Explora nuevas recetas y descubre platos emocionantes.',
            style: TextStyle(fontSize: 16, color: Colors.orange[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _construirPestanaCategorias() {
    final List<String> categorias = [
      'Carne de res', 'Pollo', 'Postre', 'Cordero', 'Varios',
      'Pasta', 'Cerdo', 'Mariscos', 'Acompañamiento', 'Entrante', 'Vegano', 'Vegetariano'
    ];
    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.orange[100],
          child: ListTile(
            title: Text(categorias[index], style: TextStyle(color: Colors.orange[800])),
            leading: Icon(Icons.category, color: Colors.orange[600]),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange[300]),
            onTap: () {
              // Acción cuando se toca una categoría
            },
          ),
        );
      },
    );
  }

  Widget _construirPestanaConfiguracion() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controladorTexto,
            decoration: InputDecoration(
              labelText: 'Ingresa tu comida favorita',
              border:  const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange[600]!),
              ),
              labelStyle: TextStyle(color: Colors.orange[600]),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Acción para guardar la comida favorita
            },
            child: const Text('Guardar Favorito'),
          ),
        ],
      ),
    );
  }
}