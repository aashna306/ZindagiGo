import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';
import 'package:gsc_project/colors/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  String _selectedLanguage = 'en'; // Default language
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  final ImagePicker _picker = ImagePicker();

  final Map<String, String> languages = {
    'English': 'en',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
    'Hindi': 'hi',
  };

  Future<void> sendMessage(String userMessage) async {
    final response = await http.post(
      Uri.parse('http://172.20.10.2:3000/api/chat'),
      //in the place of 10.0.2.2  give your ipconfig(run ipconfig in cmd and copy ipv4 ) if you want to run this on real device
      // 10.0.2.2  this is for emulator
      // also remember that your pc and device must be connected with same wifi
      // Use localhost for emulator
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "message": userMessage,
        "targetLang": _selectedLanguage,
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

 void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) => print("Error: $error"),
    );

    if (available) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
          });

          if (result.finalResult && result.recognizedWords.isNotEmpty) {
            _speech.stop(); // Ensure we stop listening
            setState(() {
              _isListening = false;
            });
            sendMessage(_controller.text); // Send only once
          }
        },
        localeId: _selectedLanguage, // Set language for speech recognition
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  Future<void> _pickImageAndExtractText() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    String extractedText = recognizedText.text;
    if (extractedText.isNotEmpty) {
      setState(() {
        _controller.text = extractedText; // Set extracted text in input
      });

      // Ensure sendMessage() is only called once
      sendMessage(extractedText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.HomePageColor,
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
                  icon: Icon(
                    _isListening ? Icons.mic_off : Icons.mic,
                    color: _isListening ? Colors.red : Colors.black,
                  ),
                  onPressed: _isListening ? _stopListening : _startListening,
                ),
                // IconButton(
                //   icon: Icon(Icons.mic, color: Colors.red),
                //   onPressed: () {},
                // ),

                IconButton(
                  icon: Icon(Icons.upload_file, color: Colors.blue),
                  onPressed: _pickImageAndExtractText,
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
