import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const PsikologUjianApp());
}

class PsikologUjianApp extends StatelessWidget {
  const PsikologUjianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PsikologSoalPage(),
    );
  }
}

class PsikologSoalPage extends StatefulWidget {
  const PsikologSoalPage({super.key});

  @override
  State<PsikologSoalPage> createState() => _PsikologSoalPageState();
}

class _PsikologSoalPageState extends State<PsikologSoalPage> {
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  Duration _remainingTime = const Duration(minutes: 90);
  Timer? _timer;

  final List<Map<String, dynamic>> _questions = [
    {
      'title': 'Psikolog Soal 1',
      'question': 'Manakah kelanjutan pola berikut? 2, 4, 8, 16, ...',
      'options': {
        'A': '18',
        'B': '20',
        'C': '24',
        'D': '32',
      }
    },
    {
      'title': 'Psikolog Soal 2',
      'question': 'Jika hari ini hari Rabu, maka 10 hari lagi adalah hari...',
      'options': {
        'A': 'Jumat',
        'B': 'Minggu',
        'C': 'Senin',
        'D': 'Sabtu',
      }
    },
    {
      'title': 'Psikolog Soal 3',
      'question': 'Anda lebih suka bekerja...',
      'options': {
        'A': 'Dalam kelompok',
        'B': 'Sendiri',
        'C': 'Tergantung situasi',
        'D': 'Dengan orang yang sudah dikenal',
      }
    },
    {
      'title': 'Psikolog Soal 4',
      'question': 'Jika semua kucing adalah hewan, dan beberapa hewan adalah anjing, maka...',
      'options': {
        'A': 'Semua anjing adalah kucing',
        'B': 'Semua kucing adalah anjing',
        'C': 'Beberapa hewan bukan kucing',
        'D': 'Tidak dapat disimpulkan',
      }
    },
    {
      'title': 'Psikolog Soal 5',
      'question': 'Saat menghadapi masalah, Anda cenderung...',
      'options': {
        'A': 'Langsung bertindak',
        'B': 'Memikirkan solusi matang',
        'C': 'Bingung',
        'D': 'Lari dan biarkan',
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