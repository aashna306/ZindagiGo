import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  String _selectedLanguage = 'en'; // Default language

  final Map<String, String> languages = {
    'English': 'en',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
    'Hindi': 'hi',
  };

  Future<void> sendMessage(String userMessage) async {
    final response = await http.post(
      Uri.parse(
          'http://10.0.2.2:3000/api/chat'),
          //in the place of 10.0.2.2  give your ipconfig(run ipconfig in cmd and copy ipv4 ) if you want to run this on real device
          // 10.0.2.2  this is for emulator
          // also remember that your pc and device must be connected with same wifi
          // Use localhost for emulator
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "message": userMessage,
        "targetLang": _selectedLanguage ?? 'en',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        messages.add({"user": userMessage});
        messages.add({"bot": data["reply"]});
      });
      _controller.clear();
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatbot")),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
              });
            },
            items: languages.entries.map<DropdownMenuItem<String>>((entry) {
              return DropdownMenuItem<String>(
                value: entry.value,
                child: Text(entry.key),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                String key = messages[index].keys.first;
                return ListTile(
                  title: Align(
                    alignment: key == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: key == "user"
                            ? Colors.blue[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(messages[index][key]!),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.red),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
