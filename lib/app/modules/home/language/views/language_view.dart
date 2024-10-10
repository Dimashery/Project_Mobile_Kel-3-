import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed('/profile');
          },
        ),
        title: const Text('Language'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0, // Hilangkan bayangan app bar
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Languange', // Ada typo di gambar aslinya
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            RadioListTile(
              title: const Text('English (EN)'),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value.toString();
                });
              },
            ),
            const Divider(height: 30, thickness: 1),
            RadioListTile(
              title: const Text('Bahasa Indonesia (IDN)'),
              value: 'Bahasa Indonesia',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value.toString();
                });
              },
            ),
            const Divider(height: 30, thickness: 1),
          ],
        ),
      ),
    );
  }
}
