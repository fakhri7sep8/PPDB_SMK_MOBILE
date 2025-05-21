import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/core/routing/app_route.dart';
import 'package:ppdb_mobile/core/useCase/auth.dart';
import 'package:ppdb_mobile/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Color(0xFFF3FCF6)),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/img/mq.png',
              height: 480,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 500,
            right: 330,
            child: Image.asset('assets/img/logo.png', width: 200, height: 200),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Selamat Datang di',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: 'PPDB ',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                              ),
                            ),
                            TextSpan(
                              text: '–SMK\n',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                              ),
                            ),
                            TextSpan(
                              text: 'MADINATUL QURAN',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'masukkan email...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberPassword,
                          onChanged: (value) {
                            setState(() {
                              rememberPassword = value!;
                            });
                          },
                        ),
                        Text('Remember password'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Forget password'),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'By signing in you are agreeing our',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Term and privacy policy",
                        style: TextStyle(color: Color(0xff5079F4)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        print('Tombol login ditekan');
                        final prosesAuth = ProsesAuth();
                        String result = await prosesAuth.login(
                          context,
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        if (result.contains('berhasil')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('login berhasil!'),
                            ),
                          );
                          context.goNamed(Routes.home);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal: $result')),
                          );
                        }

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(result)));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                    ),
                  ),
                  
                ),
                SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("belum membuat akun? "),
                      GestureDetector(
                        onTap: () => context.goNamed(Routes.register),
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
