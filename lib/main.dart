import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/core/routing/app_route.dart';
import 'package:ppdb_mobile/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final isLoggedIn = snapshot.data != null;

        final router = GoRouter(
          initialLocation: isLoggedIn ? '/home' : '/login',
          redirect: (context, state) {
            final currentLocation = state.uri.toString();
            final loggingInOrRegister = currentLocation == '/login' || currentLocation == '/register';

            if (!isLoggedIn && !loggingInOrRegister) return '/login';
            if (isLoggedIn && loggingInOrRegister) return '/home';

            return null;
          },
          routes: appRoute,
        );

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'PPDB Mobile',
          routerConfig: router,
        );
      },
    );
  }
}
