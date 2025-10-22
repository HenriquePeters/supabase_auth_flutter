import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/sign_in_page.dart';
import 'pages/home_page.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env[supabaseUrlKey]!,
    anonKey: dotenv.env[supabaseAnonKey]!,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
print('Sessão atual: $session');


    return MaterialApp(
      title: 'Supabase Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: session == null ? const SignInPage() : const HomePage(),
    );
  }
}
