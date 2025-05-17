import 'package:go_router/go_router.dart';
import 'package:ppdb_mobile/presentation/pages/berkas.dart';
import 'package:ppdb_mobile/presentation/pages/home.dart';
import 'package:ppdb_mobile/presentation/pages/login.dart';
import 'package:ppdb_mobile/presentation/pages/pendaftaran.dart';
import 'package:ppdb_mobile/presentation/pages/profile.dart';
import 'package:ppdb_mobile/presentation/pages/register.dart';

part 'route_name.dart';

final List<GoRoute> appRoute = [
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
    path: '/berkas',
    name: Routes.berkas,
    builder: (context, state) => Berkas(),
  ),
  GoRoute(
    path: '/login',
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
];
