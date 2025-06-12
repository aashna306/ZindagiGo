import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Help Number',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AddHelpNumberPage(),
    );
  }
}

class AddHelpNumberPage extends StatefulWidget {
  const AddHelpNumberPage({super.key});

  @override
  State<AddHelpNumberPage> createState() => _AddHelpNumberPageState();
}

class _AddHelpNumberPageState extends State<AddHelpNumberPage> {
  final TextEditingController _nameController = TextEditingController(text: 'Radhika');
  final TextEditingController _phoneController = TextEditingController(text: '989898989898');
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _verifyController = TextEditingController();

  String? _selectedRelation = 'Daughter';

  final List<String> _relations = [
    'Daughter',
    'Son',
    'Brother',
    'Sister',
    'Friend',
    'Spouse',
    'Other'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    _verifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E0F0),
        centerTitle: true,
        // toolbarHeight: 30.0,
        // titleSpacing: 15,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(50),
        //   side: const BorderSide(color: Color(0xFF5A4087), width: 2),
        // ),
        title: const Text(
          'Add Help Number',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF594087),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1C1B1F)),
              ),
              const SizedBox(height: 8),
              _buildTextField(_nameController, 'Radhika', TextInputType.text),
              const SizedBox(height: 20),
              const Text(
                'Phone No.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1C1B1F)),
              ),
              const SizedBox(height: 8),
              _buildTextField(_phoneController, '989898989898', TextInputType.phone),
              const SizedBox(height: 20),
              const Text(
                'Relation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1C1B1F)),
              ),
              const SizedBox(height: 8),
              _buildDropdownField(),
              const SizedBox(height: 20),
              const Text(
                'Add description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1C1B1F)),
              ),
              const SizedBox(height: 8),
              _buildTextField(_descriptionController, '', TextInputType.multiline, maxLines: null),
              const SizedBox(height: 20),
              const Text(
                'Set as default emergency number?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1C1B1F)),
              ),
              const SizedBox(height: 8),
              _buildTextField(_verifyController, 'Type "YES" to verify', TextInputType.text),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('CANCEL pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9),
                        foregroundColor: const Color(0xFF1C1B1F),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print('SAVE pressed');
                        print('Name: ${_nameController.text}');
                        print('Phone: ${_phoneController.text}');
                        print('Relation: $_selectedRelation');
                        print('Description: ${_descriptionController.text}');
                        print('Verification: ${_verifyController.text}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF594087),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        'SAVE',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, TextInputType keyboardType, {int? maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF575555)),
        filled: true,
        fillColor: const Color(0xFFE2E0F0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF594087), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      style: const TextStyle(color: Color(0xFF1C1B1F)),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E0F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedRelation,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF594087)),
          hint: const Text('Select Relation', style: TextStyle(color: Color(0xFF575555))),
          onChanged: (String? newValue) {
            setState(() {
              _selectedRelation = newValue;
            });
          },
          items: _relations.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Color(0xFF1C1B1F))),
            );
          }).toList(),
          dropdownColor: const Color(0xFFE2E0F0),
        ),
      ),
    );
  }
}