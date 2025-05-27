import 'package:flutter/material.dart';

void main() {
  runApp(const cardPage());
}

class cardPage extends StatelessWidget {
  const cardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UjianHomePage(),
    );
  }
}

class UjianHomePage extends StatefulWidget {
  const UjianHomePage({super.key});

  @override
  State<UjianHomePage> createState() => _UjianHomePageState();
}

class _UjianHomePageState extends State<UjianHomePage> {
  final PageController _pageController = PageController();

  void _showExamModal(BuildContext context, String subject) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.green.shade100, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.book, size: 48, color: Colors.green.shade800),
              const SizedBox(height: 16),
              Text(subject,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Durasi Ujian: 90 Menit",
                  style: TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Kembali"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green),
                    onPressed: () {
                      Navigator.pop(context);
                      // navigasi ke halaman ujian bisa ditambahkan di sini
                    },
                    child: const Text("Lanjutkan"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: PageView(
        controller: _pageController,
        children: [
          // Halaman Pengumuman
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Pengumuman",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE8F5E9),
                        ),
                        child: const Icon(Icons.notifications,
                            color: Colors.green),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ujian Matematika Dimulai Besok",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("26 Mei 2025, 09:00 WIB",
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut),
                          icon: const Icon(Icons.arrow_forward_ios,
                              color: Colors.green, size: 18))
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Halaman Kartu Peserta
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Kartu Peserta",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 30,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ahmad Fauzi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 4),
                          Text("Kelas 9B", style: TextStyle(color: Colors.grey))
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () => _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut),
                          icon: const Icon(Icons.arrow_forward_ios,
                              color: Colors.green))
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Halaman Daftar Ujian
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Daftar Ujian",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ...["Matematika", "Bahasa Inggris", "BTA", "Diniyyah"].map(
                  (subject) => GestureDetector(
                    onTap: () => _showExamModal(context, subject),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.book, color: Colors.green),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Text(subject,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))),
                          const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
