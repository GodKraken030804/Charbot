import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  final String apiKey = 'AIzaSyB0wZHN5PiorXWoBw8VAt1982R3oEzdhXE';  // Reemplaza con tu API Key correcta
  final String apiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent';

  // Llamada a la API de Gemini
  Future<String?> _callGeminiAPI(String query) async {
    final response = await http.post(
      Uri.parse('$apiUrl?key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': query}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Respuesta del servidor: $data');

      // Extraer la respuesta del bot
      final text = data['candidates']?[0]['content']?['parts']?[0]['text'] ?? 'Sin respuesta.';
      return text;
    } else {
      print('Error: ${response.statusCode}');
      print('Body: ${response.body}');
      return 'Error en la respuesta del servidor.';
    }
  }

  // Enviar mensaje y mostrar respuesta
  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': message});
      _controller.clear();
    });

    final response = await _callGeminiAPI(message);
    if (response != null) {
      setState(() {
        _messages.add({'sender': 'bot', 'text': response});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot con Gemini API'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          _buildChatHistory(),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatHistory() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          final isUserMessage = message['sender'] == 'user';

          return Align(
            alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: isUserMessage ? Colors.teal : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message['text'] ?? '',
                style: TextStyle(
                  color: isUserMessage ? Colors.white : Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Escribe un mensaje...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => _sendMessage(value),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.teal,
            onPressed: () => _sendMessage(_controller.text),
          ),
        ],
      ),
    );
  }
}
