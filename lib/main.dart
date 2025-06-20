// lib/main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // <-- Correctly imported

// Import all our key files
import 'auth_gate.dart';

Future<void> main() async {
  // 1. Ensure Flutter is ready before doing anything else
  WidgetsFlutterBinding.ensureInitialized();

  // 2. LOAD the .env file into memory. This is the missing step!
  await dotenv.load(fileName: ".env");

  // 3. NOW you can safely initialize Supabase using the loaded variables
  await Supabase.initialize(
    // Use dotenv.env to get the value. The '!' means we are sure it exists.
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  
  // 4. Finally, run the app
  runApp(const MyApp());
}

// Helper to access the Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect App',
      debugShowCheckedModeBanner: false,
      // We use the theme from your original freelancer app
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        primarySwatch: Colors.blue,
      ),
      // The home is now the AuthGate, which will decide which page to show
      home: const AuthGate(),
    );
  }
}