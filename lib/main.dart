import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:prime_mobile/core/dependencies/injector.dart';
import 'package:prime_mobile/core/navigator/pages.dart';
import 'package:prime_mobile/modules/first_opening/first_opening_bloc.dart';

import 'customization/notifier/notifier.dart';
import 'modules/auth/bloc/auth_bloc.dart';
import 'pages/auth/auth_page.dart';
import 'pages/home_page.dart';

void main() async {
  await initializeDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc()..add(const AuthAppStarted())),
        BlocProvider(
            create: (_) => FirstOpeningBloc()..add(const CheckOpeningEvent())),
      ],
      child: GetMaterialApp(
        // supportedLocales: const [Locale('ru', 'RU')],
        title: 'Prime\'s delivery',
        initialRoute: '/',
        getPages: pages,
        theme: ThemeData(
          useMaterial3: true,
        ),
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Get.offNamed(HomePage.route);
              } else if (state is AuthError) {
                Notifier.showErrorSnackBar(state.error);
              } else {
                Get.offNamed(AuthPage.route);
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
