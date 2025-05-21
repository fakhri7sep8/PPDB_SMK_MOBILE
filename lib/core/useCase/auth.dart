import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ProsesAuth {
  var url = dotenv.env['baseUrl'];

  Future<String> register(
    BuildContext context,
    String username,
    String email,
    String password,
  ) async {
    if (url == null) {
      return 'Error: baseUrl belum di-set di .env';
    }

    Uri urlRegister = Uri.parse("$url/auth/register");
    var response = await http.post(
      urlRegister,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      await prefs.setString('password', password);

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registration Successful"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return 'Registrasi berhasil';
    } else {
      print("Registrasi gagal, status code: ${response.statusCode}");
      print(response.body);
      return 'Registrasi gagal: ${response.statusCode}';
    }
  }

  Future<String> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    if (url == null) {
      return 'Error: baseUrl belum di-set di .env';
    }

    print('Login function started');
    Uri urlLogin = Uri.parse("$url/auth/login");

    var response = await http.post(
      urlLogin,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      final jsonBody = jsonDecode(response.body);
      final accessToken = jsonBody['data']['access_token'];

      print('Access token: $accessToken');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('email', email);
      await prefs.setString('password', password);

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Successful"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return 'Login berhasil';
    } else {
      return 'Login gagal: ${response.statusCode}';
    }
  }

  Future<String> createCalonSiswa(
    BuildContext context,
    Map<String, dynamic> calonSiswaData,
  ) async {
    if (url == null) {
      return 'Error: baseUrl belum di-set di .env';
    }

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (accessToken == null) {
      return 'Error: User belum login atau token tidak ditemukan';
    }

    Uri urlCreate = Uri.parse("$url/calonsiswa/create");

    var response = await http.post(
      urlCreate,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode(calonSiswaData),
    );

    print('Create Calon Siswa status: ${response.statusCode}');
    print('Create Calon Siswa response: ${response.body}');

    if (response.statusCode == 201) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Berhasil Daftar Calon Siswa"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return 'Pendaftaran berhasil';
    } else {
      return 'Gagal daftar: ${response.statusCode}';
    }
  }
}
