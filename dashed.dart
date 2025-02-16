import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ImagePicker _imagePicker = ImagePicker();
  File? _imageFile;

  String get _geminiApiKey => dotenv.env['AIzaSyB1a6LNXS1k9uQXEKoZQGOMlMitumpJNMQ'] ?? '';

  @override
  void initState() {
    super.initState();
    dotenv.load(fileName: ".env").then((_) {
      if (_geminiApiKey.isEmpty) {
        setState(() {
          _messages.add({'sender': 'system', 'content': 'Ошибка: API ключ не загружен.'});
        });
      }
    });
  }

  /// Отправка текста через Gemini API
  Future<void> _sendMessage(String message) async {
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({'sender': 'user', 'content': message});
      });
      _messageController.clear();

      try {
        final response = await http.post(
          Uri.parse(
              "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "prompt": {
              "text": message,
            },
            "candidateCount": 1
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final reply = responseData['candidates']?[0]?['output'] ??
              'Gemini не смог обработать ваш запрос.';
          setState(() {
            _messages.add({'sender': 'gemini', 'content': reply});
          });
        } else {
          _handleError('Ошибка: ${response.statusCode} ${response.reasonPhrase}');
        }
      } catch (e) {
        _handleError('Ошибка: $e');
      }
    }
  }

  /// Отправка изображения
  Future<void> _sendImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
        _messages.add({'sender': 'user', 'content': 'Фотография отправлена.'});
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.add({
            'sender': 'gemini',
            'content': 'Фотография обработана! Это пример ответа Gemini.'
          });
        });
      });
    }
  }

  /// Обработка ошибок
  void _handleError(String error) {
    setState(() {
      _messages.add({'sender': 'gemini', 'content': error});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Чат-бот",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['content']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo, color: Colors.green),
                  onPressed: _sendImage,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Напишите сообщение...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
