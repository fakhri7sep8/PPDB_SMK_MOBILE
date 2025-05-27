import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MathExamApp());
}

class MathExamApp extends StatelessWidget {
  const MathExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MathSoalPage(),
    );
  }
}

class MathSoalPage extends StatefulWidget {
  const MathSoalPage({super.key});

  @override
  State<MathSoalPage> createState() => _MathSoalPageState();
}

class _MathSoalPageState extends State<MathSoalPage> {
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  Duration _remainingTime = const Duration(minutes: 90);
  Timer? _timer;

  final List<Map<String, dynamic>> _questions = [
    {
      'title': 'Matematika Soal 1',
      'question': 'Berapakah hasil dari 12 + 8 × 2?',
      'options': {
        'A': '40',
        'B': '28',
        'C': '32',
        'D': '26',
      }
    },
    {
      'title': 'Matematika Soal 2',
      'question': 'Sebuah segitiga memiliki panjang alas 10 cm dan tinggi 6 cm. Berapakah luasnya?',
      'options': {
        'A': '30 cm²',
        'B': '60 cm²',
        'C': '20 cm²',
        'D': '40 cm²',
      }
    },
    {
      'title': 'Matematika Soal 3',
      'question': 'Hasil dari 72 : (8 × 3) adalah...',
      'options': {
        'A': '3',
        'B': '4',
        'C': '5',
        'D': '6',
      }
    },
    {
      'title': 'Matematika Soal 4',
      'question': 'Bilangan kelipatan 6 yang lebih dari 20 dan kurang dari 50 adalah...',
      'options': {
        'A': '24, 30, 36, 42, 48',
        'B': '25, 30, 36, 40, 48',
        'C': '26, 32, 36, 42, 50',
        'D': '22, 28, 36, 46, 54',
      }
    },
    {
      'title': 'Matematika Soal 5',
      'question': 'Jika x × 3 = 10, maka nilai x adalah...',
      'options': {
        'A': '6',
        'B': '7',
        'C': '9',
        'D': '3',
      }
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _selectOption(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedOption = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            _previousQuestion();
          },
        ),
        title: Text(current['title']),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                current['question'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Sisa Waktu: ${_formatDuration(_remainingTime)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ...current['options'].entries.map<Widget>((entry) => Column(
                  children: [
                    _buildOption(entry.key, entry.value),
                    const SizedBox(height: 10),
                  ],
                )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: 'prev',
                  backgroundColor: Colors.white,
                  elevation: 2,
                  onPressed: _previousQuestion,
                  child: const Icon(Icons.arrow_back, color: Colors.green),
                ),
                FloatingActionButton(
                  heroTag: 'next',
                  backgroundColor: Colors.white,
                  elevation: 2,
                  onPressed: _nextQuestion,
                  child: const Icon(Icons.arrow_forward, color: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String label, String text) {
    final isSelected = _selectedOption == label;

    return GestureDetector(
      onTap: () => _selectOption(label),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade100 : Colors.transparent,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Text(label, style: const TextStyle(color: Colors.black)),
          ),
          title: Text(text),
        ),
      ),
    );
  }
}