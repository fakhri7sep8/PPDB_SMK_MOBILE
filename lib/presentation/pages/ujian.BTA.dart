import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const BtaExamApp());
}

class BtaExamApp extends StatelessWidget {
  const BtaExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BtaSoalPage(),
    );
  }
}

class BtaSoalPage extends StatefulWidget {
  const BtaSoalPage({super.key});

  @override
  State<BtaSoalPage> createState() => _BtaSoalPageState();
}

class _BtaSoalPageState extends State<BtaSoalPage> {
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  Duration _remainingTime = const Duration(minutes: 90);
  Timer? _timer;

  final List<Map<String, dynamic>> _questions = [
    {
      'title': 'BTA Soal 1',
      'question': 'Huruf hijaiyah yang keluar dari tenggorokan bagian atas adalah...',
      'options': {
        'A': 'ق dan ك',
        'B': 'ز dan ء',
        'C': 'خ dan غ',
        'D': 'ف dan س',
      }
    },
    {
      'title': 'BTA Soal 2',
      'question': 'Manakah di bawah ini yang merupakan huruf mad thabi’i?',
      'options': {
        'A': 'Alif, Wau, Ya',
        'B': 'Alif, Hamzah, Ta',
        'C': 'Ba, Ta, Tsa',
        'D': 'Dal, Dzal, Zai',
      }
    },
    {
      'title': 'BTA Soal 3',
      'question': 'Huruf hijaiyah "ج" dibaca seperti...',
      'options': {
        'A': 'Z',
        'B': 'D',
        'C': 'Dj',
        'D': 'Jh',
      }
    },
    {
      'title': 'BTA Soal 4',
      'question': 'Tanda baca fathah dibaca...',
      'options': {
        'A': '"a"',
        'B': '"u"',
        'C': '"e"',
        'D': '"o"',
      }
    },
    {
      'title': 'BTA Soal 5',
      'question': 'Berikut yang merupakan huruf qalqalah adalah...',
      'options': {
        'A': 'ب، ت، ج، د، ط',
        'B': 'ق، ك، غ، خ',
        'C': 'ق، ط، ب، ج، د',
        'D': 'ل، س، م، ن، ه',
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
