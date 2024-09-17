import 'package:app_movil/Pages/NextPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Asegúrate de tener esta dependencia


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Lista de integrantes del equipo
  final List<Map<String, String>> teamMembers = const [
    {"name": "Jorge Arturo Molina Gómez 221251", "phone": "967 680 07 60", "message": "967 680 0760"},
    {"name": "Yoshtin German Gutierrez Perez 221246", "phone": "961 851 3478", "message": "961 851 3478"},
    {"name": "Andres Guizar Gómez 213360", "phone": "963 171 8235", "message": "963 171 8235"},
    {"name": "Yumari Teresa Morales Mendoza 2111225", "phone": "968 128 2169", "message": "968 128 2169"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrantes del Equipo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: teamMembers.length,
              itemBuilder: (context, index) {
                final member = teamMembers[index];
                return ListTile(
                  title: Text(member['name']!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () => _makePhoneCall(member['phone']!),
                      ),
                      IconButton(
                        icon: const Icon(Icons.message),
                        onPressed: () => _sendSMS(member['message']!),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: TextButton(
              onPressed: () {
                // Navegar a la página siguiente
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NextPage()),
                );
              },
              child: const Text(
                'Continuar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para hacer llamadas
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'No se pudo realizar la llamada';
    }
  }

  // Método para enviar SMS
  Future<void> _sendSMS(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'No se pudo enviar el mensaje';
    }
  }
}
