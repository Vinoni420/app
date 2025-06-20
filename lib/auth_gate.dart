// lib/auth_gate.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import the screens it needs to route to
import 'main_screen.dart'; 
import 'login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.data!.session;

        // If a session exists, the user is logged in. 
        // Show the MAIN SCREEN of your freelancer app.
        if (session != null) {
          return const MainScreen();
        } 
        // Otherwise, show the LoginPage.
        else {
          return const LoginPage();
        }
      },
    );
  }
}