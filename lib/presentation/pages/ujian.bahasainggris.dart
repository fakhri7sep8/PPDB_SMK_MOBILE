import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const EnglishExamApp());
}

class EnglishExamApp extends StatelessWidget {
  const EnglishExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const EnglishSoalPage(),
    );
  }
}

class EnglishSoalPage extends StatefulWidget {
  const EnglishSoalPage({super.key});

  @override
  State<EnglishSoalPage> createState() => _EnglishSoalPageState();
}

class _EnglishSoalPageState extends State<EnglishSoalPage> {
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  Duration _remainingTime = const Duration(minutes: 90);
  Timer? _timer;

  final List<Map<String, dynamic>> _questions = [
    {
      'title': 'Bahasa Inggris Soal 1',
      'question': 'I ___ a student.',
      'options': {
        'A': 'is',
        'B': 'are',
        'C': 'am',
        'D': 'be',
      }
    },
    {
      'title': 'Bahasa Inggris Soal 2',
      'question': 'She ___ to school every day.',
      'options': {
        'A': 'go',
        'B': 'goes',
        'C': 'going',
        'D': 'gone',
      }
    },
    {
      'title': 'Bahasa Inggris Soal 3',
      'question': 'We ___ in Indonesia.',
      'options': {
        'A': 'live',
        'B': 'lives',
        'C': 'living',
        'D': 'lived',
      }
    },
    {
      'title': 'Bahasa Inggris Soal 4',
      'question': 'The opposite of "big" is...',
      'options': {
        'A': 'tall',
        'B': 'short',
        'C': 'small',
        'D': 'long',
      }
    },
    {
      'title': 'Bahasa Inggris Soal 5',
      'question': 'What is the past tense of "eat"?',
      'options': {
        'A': 'acted',
        'B': 'eaten',
        'C': 'ate',
        'D': 'eats',
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
