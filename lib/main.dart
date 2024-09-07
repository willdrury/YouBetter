import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:you_better/providers/settings_provider.dart';
import 'package:you_better/screens/auth_screen.dart';
import 'package:you_better/screens/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:you_better/screens/loading_screen.dart';

import 'firebase_options.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFFFF9B03)).copyWith(
  primary: const Color(0xFFFF9B03),
  surface: Colors.white,
);
final kColorSchemeDark = ColorScheme.fromSeed(seedColor: const Color(0xffFFBD03), brightness: Brightness.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'You Better',
      theme: ThemeData(
        colorScheme: settings[Setting.darkModeEnabled]! ? kColorSchemeDark : kColorScheme,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            if (snapshot.hasData) {
              return const MyHomePage();
            }
            return const AuthScreen();
          }
      ),
    );
  }
}