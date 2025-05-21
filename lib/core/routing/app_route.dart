import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/presentation/pages/berkas.dart';
import 'package:ppdb_mobile/presentation/pages/home.dart';
import 'package:ppdb_mobile/presentation/pages/login.dart';
import 'package:ppdb_mobile/presentation/pages/pendaftaran.dart';
import 'package:ppdb_mobile/presentation/pages/pengumuman.dart';
import 'package:ppdb_mobile/presentation/pages/profile.dart';
import 'package:ppdb_mobile/presentation/pages/register.dart';
import 'package:ppdb_mobile/presentation/pages/tes.dart';

part 'route_name.dart';
final appRoute = GoRouter(routes: [
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
  // GoRoute(
  //   path: '/berkas',
  //   name: Routes.berkas,
  //   builder: (context, state) => BerkasPage(),
  // ),
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
    path: '/pengumuman',
    name: Routes.pengumuman,
    builder: (context, state) => PengumumanPage(),
  ),
]);
