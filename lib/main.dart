import 'package:flutter/material.dart';
import 'second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical Work 10',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _textController = TextEditingController();
  final _sizeController = TextEditingController();

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: 'Введіть текст',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _sizeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Розмір шрифту (наприклад, 24)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF365B83),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final text = _textController.text;
                      final size = double.tryParse(_sizeController.text) ?? 16.0;

                      if (text.isEmpty) return;

                      // Переходимо на другий екран і чекаємо результату (реєструємо результат кнопки)
                      final result = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SecondScreen(text: text, fontSize: size),
                        ),
                      );

                      // Обробка результатів залежно від того, як повернулися
                      if (!mounted) return;
                      if (result == 'ok') {
                        _showDialog('Cool!');
                      } else if (result == 'cancel') {
                        _showDialog("Let's try something else.");
                      } else {
                        _showDialog("Don't know what to say.");
                      }
                    },
                    child: const Text('Попередній перегляд'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}