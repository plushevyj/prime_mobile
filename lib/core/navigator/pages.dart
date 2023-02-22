import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:prime_mobile/pages/auth/auth_page.dart';

import '../../pages/home_page.dart';
import '../../pages/loading_page.dart';

final pages = [
  GetPage(name: '/', page: () => const LoadingPage()),
  GetPage(name: AuthPage.route, page: () => const AuthPage()),
  GetPage(name: HomePage.route, page: () => const HomePage()),
];
