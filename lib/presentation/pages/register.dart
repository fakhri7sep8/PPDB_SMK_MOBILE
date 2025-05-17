import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/core/routing/app_route.dart';
import 'package:ppdb_mobile/service/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
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
                authService.register(
                  context,
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: Text('Daftar'),
            ),
            TextButton(
              onPressed: () {
                context.goNamed(Routes.login);
              },
              child: Text('Sudah punya akun? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
