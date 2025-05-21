import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/core/routing/app_route.dart';
import 'package:ppdb_mobile/service/auth_service.dart';

class PengumumanPage extends StatelessWidget {
  final AuthService authService = AuthService();

  PengumumanPage({Key? key}) : super(key: key);

  // Mock data pengumuman hasil tes
  final List<Map<String, String>> hasilTes = [
    {
      'nama': 'Ahmad Fauzi',
      'hasil': 'Lulus',
      'nilai': '85',
      'catatan': 'Selamat, kamu lolos tes seleksi!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman Hasil Tes'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () {
                context.goNamed(Routes.home);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                context.goNamed(Routes.profile);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Tes'),
              onTap: () {
                context.goNamed(Routes.tes);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.announcement),
              title: const Text('Pengumuman'),
              onTap: () {
                context.goNamed(Routes.pengumuman);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                authService.logout(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: hasilTes.isEmpty
            ? const Center(
                child: Text('Belum ada pengumuman hasil tes'),
              )
            : ListView.builder(
                itemCount: hasilTes.length,
                itemBuilder: (context, index) {
                  final data = hasilTes[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['nama'] ?? '-',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Text(
                                'Hasil: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                data['hasil'] ?? '-',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: (data['hasil'] == 'Lulus')
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('Nilai: ${data['nilai'] ?? '-'}'),
                          const SizedBox(height: 8),
                          Text(data['catatan'] ?? ''),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
