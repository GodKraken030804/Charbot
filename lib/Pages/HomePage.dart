import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 255, 242, 0), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildInfoCard(context),
                  const SizedBox(height: 40),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/logo_universidad.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Universidad Politécnica de Chiapas',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoText('Carrera: Ingeniería en Software'),
            _buildInfoText('Materia: PROGRAMACIÓN PARA MÓVILES II'),
            _buildInfoText('Grupo: B'),
            _buildInfoText('Nombre: Jorge Arturo Molina Gómez'),
            _buildInfoText('Matrícula: 221251'),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.chat_bubble_outline),
          label: const Text('Ir al Chat'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/chat');
          },
        ),
        const SizedBox(height: 15),
        TextButton.icon(
          icon: const Icon(Icons.code),
          label: const Text('Ver Repositorio en GitHub'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            textStyle: const TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () async {
            const url = 'https://github.com/tu-repositorio';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              throw 'No se pudo abrir $url';
            }
          },
        ),
      ],
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
        textAlign: TextAlign.center,
      ),
    );
  }
}
