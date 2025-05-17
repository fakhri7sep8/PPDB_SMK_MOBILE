import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/core/routing/app_route.dart';
import 'package:ppdb_mobile/service/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => context.goNamed(Routes.home),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => context.goNamed(Routes.profile), // Tambahkan rute jika belum ada
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Tes'),
              onTap: () => context.goNamed(Routes.tes), // Tambahkan rute jika belum ada
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text('Pengumuman'),
              onTap: () => context.goNamed(Routes.pengumuman), // Tambahkan rute jika belum ada
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () => authService.logout(context),
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
                    onPressed: () => context.goNamed(Routes.pendaftaran),
                    child: const Text('Masuk Pendaftaran'),
                  ),
                ],
              ),
            ),

            // Container Upload Dokumen
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
                    onPressed: () => context.goNamed(Routes.berkas),
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
