import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HoopGPTScreen extends StatefulWidget {
  @override
  _HoopGPTScreenState createState() => _HoopGPTScreenState();
}

class _HoopGPTScreenState extends State<HoopGPTScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmitted(String text) {
    _controller.clear();
    _addMessage(text: text, isUserMessage: true);
    _fetchResponse(text);
  }

  void _addMessage({required String text, required bool isUserMessage}) {
    setState(() {
      messages.insert(0, {"text": text, "isUser": isUserMessage});
    });
  }

  Future<void> _fetchResponse(String query) async {
    // Use your API key securely from .env
    final apiKey = dotenv.env['HOOPGPT_API_KEY'];
    final url = Uri.parse('https://api.openai.com/v1/completions');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": query,
          "temperature": 0.7,
          "max_tokens": 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String textResponse = data['choices'][0]['text'].trim();
        _addMessage(text: textResponse, isUserMessage: false);
      } else {
        print('Failed to fetch data from the API');

      }
    } catch (e) {
      print('Error making API call: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HoopGPT Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Align(
                    alignment: message["isUser"] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: message["isUser"] ? Colors.blue[100] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(message["text"]),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask something...",
                    ),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
