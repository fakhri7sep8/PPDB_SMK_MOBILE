import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/core/routing/app_route.dart';

class AuthService {
  // Login
  Future<void> login(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login berhasil!')),
      );

      context.goNamed(Routes.home); // pastikan ini sesuai dengan nama rute home
    } on FirebaseAuthException catch (e) {
      String message = 'Login gagal';
      if (e.code == 'user-not-found') {
        message = 'Email tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        message = 'Password salah';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  // Register
  Future<void> register(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registrasi berhasil!')),
      );

      context.goNamed(Routes.login); // arahkan ke login setelah register
    } on FirebaseAuthException catch (e) {
      String message = 'Registrasi gagal';
      if (e.code == 'weak-password') {
        message = 'Password terlalu lemah';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email sudah terdaftar';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  // Logout
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.goNamed(Routes.login); // kembali ke login setelah logout
  }
}
