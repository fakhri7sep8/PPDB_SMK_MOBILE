import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/core/routing/app_route.dart';
import 'package:ppdb_mobile/service/auth_service.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                authService.login(
                  context,
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                context.goNamed(Routes.register);
              },
              child: Text('Belum punya akun? Daftar'),
            ),
          ],
        ),
      ),
    );
  }
}
