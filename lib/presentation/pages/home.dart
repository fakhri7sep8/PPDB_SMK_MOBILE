import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
            ),
              ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Tes'),
            ),
            ListTile(
              leading: Icon(Icons.announcement),
              title: Text('Pengumuman'),
            ),
              ListTile(
              leading: Icon(Icons.login),
              title: Text('Log Out'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Beranda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Container Pendaftaran
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📝 Pendaftaran',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('Klik tombol di bawah untuk mengisi formulir pendaftaran.'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman pendaftaran
                    },
                    child: const Text('Masuk Pendaftaran'),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📄 Upload Dokumen',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('Unggah dokumen yang dibutuhkan untuk melengkapi pendaftaran.'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman upload
                    },
                    child: const Text('Upload Sekarang'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
