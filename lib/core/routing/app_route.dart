import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/presentation/pages/berkas.dart';
import 'package:ppdb_mobile/presentation/pages/cardujian.dart';
import 'package:ppdb_mobile/presentation/pages/home.dart';
import 'package:ppdb_mobile/presentation/pages/login.dart';
import 'package:ppdb_mobile/presentation/pages/pendaftaran.dart';
import 'package:ppdb_mobile/presentation/pages/pengumuman.dart';
import 'package:ppdb_mobile/presentation/pages/profile.dart';
import 'package:ppdb_mobile/presentation/pages/register.dart';
import 'package:ppdb_mobile/presentation/pages/tes.dart';
import 'package:ppdb_mobile/presentation/pages/ujian.BTA.dart';
import 'package:ppdb_mobile/presentation/pages/ujian.bahasainggris.dart';
import 'package:ppdb_mobile/presentation/pages/ujian.diniyyah.dart';
import 'package:ppdb_mobile/presentation/pages/ujian.matematika.dart';
import 'package:ppdb_mobile/presentation/pages/ujian.psikolog.dart';

part 'route_name.dart';
final appRoute = GoRouter(
  initialLocation: '/card', // Langsung masuk ke halaman home
  routes: [
    GoRoute(
      path: '/home',
      name: Routes.home,
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/pendaftaran',
      name: Routes.pendaftaran,
      builder: (context, state) => PendaftaranPage(),
    ),
    GoRoute(
      path: '/',
      name: Routes.login,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: Routes.register,
      builder: (context, state) => RegisterPage(),
    ),
     GoRoute(
      path: '/card',
      name: Routes.card,
      builder: (context, state) => cardPage(),
    ),
    GoRoute(
      path: '/profile',
      name: Routes.profile,
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: '/tes',
      name: Routes.tes,
      builder: (context, state) => TesPage(),
    ),
      GoRoute(
      path: '/ujian',
      name: Routes.ujian,
      builder: (context, state) => SoalPage(),
    ),
      GoRoute(
      path: '/matematika',
      name: Routes.matematika,
      builder: (context, state) => MathSoalPage(),
    ),
    GoRoute(
      path: '/english',
      name: Routes.english,
      builder: (context, state) => EnglishSoalPage(),
    ),
     GoRoute(
      path: '/BTA',
      name: Routes.BTA,
      builder: (context, state) => BtaSoalPage(),
    ),
      GoRoute(
      path: '/ujianpsikolog',
      name: Routes.psikolog,
      builder: (context, state) => PsikologSoalPage(),
    ),
    GoRoute(
      path: '/pengumuman',
      name: Routes.pengumuman,
      builder: (context, state) => PengumumanPage(),
    ),
  ],
);

